import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dcomic/database/configDatabaseProvider.dart';
import 'package:dcomic/database/database.dart';
import 'package:dcomic/database/downloader.dart';
import 'package:dcomic/database/tracker.dart';
import 'package:dcomic/http/http.dart';
import 'package:dcomic/model/baseModel.dart';
import 'package:dcomic/model/comic_source/baseSourceModel.dart';
import 'package:dcomic/view/comic_viewer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

/// 漫画详情页，记录漫画订阅记录，漫画阅读记录，漫画下载记录，和提供章节的列表
/// 预计多次迭代
class ComicDetailModel extends BaseModel {
  BaseSourceModel _model;

  get headers =>
      detail == null ? {'referer': 'http://image.dmzj.com'} : detail.headers;

  void changeModel(BaseSourceModel model) {
    _model = model;
    init();
    notifyListeners();
  }

  String _comicId;
  String _title;

  ComicDetail detail;

  //漫画加载状态
  Exception error;

  //基础信息
  String get title => detail == null ? "" : detail.title;

  String get rawComicId => _comicId;

  String get cover => detail == null
      ? 'http://manhua.dmzj.com/css/img/mh_logo_dmzj.png?t=20131122'
      : detail.cover;

  List get author => detail == null ? [] : detail.authors;

  List get types => detail == null ? [] : detail.tags;

  int get hotNum => detail == null ? 0 : detail.hotNum;

  int get subscribeNum => detail == null ? 0 : detail.subscribeNum;

  String get description => detail == null ? '加载中...' : detail.description;

  String get updateDate => detail == null ? '' : detail.updateTime;

  String get status => detail == null ? '加载中' : detail.status;

  String get comicId => detail == null ? '' : detail.comicId;

  //章节信息
  List get chapters => detail == null ? [] : detail.getChapters();
  bool _reverse = false;

  //最后浏览记录
  String get lastChapterId => detail == null ? null : detail.historyChapter;
  List lastChapterList = [];

  //用户信息
  String uid = '';

  Map data;

  ComicDetailModel(this._model, this._title, this._comicId) {
    init().then((value) =>
        getHistory(_comicId).then((value) => addReadHistory(_comicId)));
  }

  Future<void> init() async {
    try {
      detail = await _model.get(title: this._title, comicId: this._comicId);
      if(detail!=null){
        await detail.getIfSubscribed();
      }
      error = null;
      notifyListeners();
    } catch (e,s) {
      FirebaseCrashlytics.instance.recordError(e, s, reason: 'comicDetailLoadingFail: $_comicId');
      error = e;
      notifyListeners();
      logger.w('class: ComicDetail, action: loadingFailed, exception: $e');
    }
  }

  Future<void> addReadHistory(comicId) async {
    // 添加历史记录
    if (detail != null) {
      await detail.updateUnreadState();
    }
  }

  Future<void> getHistory(comicId) async {
    //获取本地最后阅读记录

    //对没有记录的本地信息提供默认值
    // if (lastChapterId == '' && chapters.length > 0) {
    //   lastChapterList = chapters[0]['data']
    //       .map((value) => value['chapter_id'].toString())
    //       .toList();
    //   if (lastChapterList.length > 0) {
    //     lastChapterId = lastChapterList[lastChapterList.length - 1];
    //   }
    // }

    //查找本地记录对应的板块
    chapters.forEach((element) {
      List chapterList = element['data']
          .map((value) => value['chapter_id'].toString())
          .toList();
      if (chapterList.indexOf(lastChapterId) >= 0) {
        lastChapterList = chapterList;
      }
    });

    //反向list
    lastChapterList = List.generate(lastChapterList.length,
        (index) => lastChapterList[lastChapterList.length - 1 - index]);

    print(
        'class: ComicDetailModel, action: historyLoading, comicId: $comicId, lastChapterId: $lastChapterId, lastChapterList: $lastChapterList');
    notifyListeners();
  }

  Widget _buildBasicButton(context, String title, style, VoidCallback onPress,
      {double width: 120}) {
    return Container(
      width: width,
      margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
      child: OutlineButton(
        child: Text(
          '$title',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: style,
        ),
        onPressed: onPress,
      ),
    );
  }

  Widget _buildButton(context, chapter, chapterIdList) {
    //创建章节UI
    // print(
    //     'chapter: ${chapter['chapter_id']}, lastChapterId: $lastChapterId, status: ${chapter['chapter_id'].toString() == Provider.of<ComicDetailModel>(context).lastChapterId}');
    return _buildBasicButton(
        context,
        chapter['chapter_title'],
        chapter['chapter_id'].toString() ==
                Provider.of<ComicDetailModel>(context).lastChapterId
            ? TextStyle(color: Colors.blue)
            : null, () async {
      Comic comic = await detail.getChapter(
          title: chapter['chapter_title'],
          chapterId: chapter['chapter_id'].toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ComicViewPage(
          comic: comic,
        );
      },settings: RouteSettings(name: 'comic_view_page')));
    });
  }

  Future<List<dynamic>> downloadChapter(comicId, chapterId) async {
    DownloadProvider downloadProvider = DownloadProvider();
    if (await downloadProvider.getChapter(chapterId) != null) {
      return null;
    }
    var state = await Permission.storage.request().isGranted;
    if (state) {
      CustomHttp http = CustomHttp();
      var response = await http.getComic(comicId, chapterId);
      var path = await SystemConfigDatabaseProvider().downloadPath;

      List data = <String>[];
      if (response.statusCode == 200) {
        var directory = Directory('$path/chapters/$comicId/$chapterId');
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        for (var item in response.data['page_url']) {
          String taskId = await FlutterDownloader.enqueue(
            headers: {'referer': 'http://images.dmzj.com'},
            url: item,
            savedDir: '$path/chapters/$comicId/$chapterId',
            showNotification: false,
            // show download progress in status bar (for Android)
            openFileFromNotification:
                false, // click on notification to open downloaded file (for Android)
          );
          data.add(taskId);
        }
      }
      if (await downloadProvider.getComic(comicId) == null) {
        DownloadComic comic = DownloadComic();
        comic.title = title;
        comic.cover = cover;
        comic.comicId = comicId;
        await downloadProvider.insertComic(comic);
      }
      DownloadChapter chapter = DownloadChapter();
      chapter.comicId = comicId;
      chapter.tasks = data;
      chapter.chapterId = chapterId;
      chapter.title = response.data['title'];
      await downloadProvider.insertChapter(chapter);
      notifyListeners();
      return data;
    }
    return null;
  }

  Future<Widget> _buildDownloadButton(context, chapter) async {
    DownloadProvider downloadProvider = DownloadProvider();
    if (await downloadProvider.getChapter(chapter['chapter_id'].toString()) !=
        null) {
      return _buildBasicButton(context, chapter['chapter_title'], null, null,
          width: 80);
    }
    return _buildBasicButton(context, chapter['chapter_title'], null, () async {
      List list =
          await downloadChapter(comicId, chapter['chapter_id'].toString());
      logger.i(
          'action: downloadChapter, chapterId: ${chapter['chapter_id']}, tasks: $list');
    }, width: 80);
  }

  List<Widget> buildChapterWidgetList(context) {
    List<Widget> lists = [];
    for (var item in this.chapters) {
      // 生成每版的章节ID列表
      // List<String> chapterIdList = item['data']
      //     .map<String>((value) => value['chapter_id'].toString())
      //     .toList();
      // chapterIdList = List.generate(chapterIdList.length,
      //     (index) => chapterIdList[chapterIdList.length - 1 - index]);

      // 生成每版的章节列表
      List<Widget> chapterList = item['data']
          .map<Widget>((value) => _buildButton(context, value, item['data']))
          .toList();
      // 反向排序
      if (_reverse) {
        var tempList = List.generate(chapterList.length,
            (index) => chapterList[chapterList.length - 1 - index]);
        chapterList = tempList;
      }

      //添加每版
      lists.add(Column(
        children: <Widget>[
          Divider(),
          Text(item['title']),
          Divider(),
          Wrap(
            children: chapterList,
          )
        ],
      ));
    }
    return lists;
  }

  Future<List<Widget>> buildDownloadWidgetList(context) async {
    List<Widget> lists = [];
    for (var item in this.chapters) {
      // 生成每版的章节列表
      List<Widget> chapterList = [];
      for (var value in item['data']) {
        chapterList.add(await _buildDownloadButton(context, value));
      }
      // 反向排序
      if (_reverse) {
        var tempList = List.generate(chapterList.length,
            (index) => chapterList[chapterList.length - 1 - index]);
        chapterList = tempList;
      }

      //添加每版
      lists.add(Column(
        children: <Widget>[
          Divider(),
          Text(item['title']),
          Divider(),
          Wrap(
            children: chapterList,
          )
        ],
      ));
    }
    return lists;
  }

  TracingComic get model => TracingComic.fromMap(
      {'comicId': rawComicId, 'cover': cover, 'title': title, 'data': '{}'});

  set reverse(bool reverse) {
    this._reverse = reverse;
    notifyListeners();
  }

  bool get reverse => this._reverse;

  set sub(bool sub) {
    if (detail != null&&detail.isSubscribed!=null) {
      this.detail.isSubscribed = sub;
    }
    notifyListeners();
  }

  bool get sub => this.detail == null ? false : this.detail.isSubscribed;

  bool get login=>_model.userConfig.status!=UserStatus.logout;

  bool get loading=>this.detail==null||this.detail.isSubscribed==null;
}
