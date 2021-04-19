import 'package:flutter/cupertino.dart';
import 'package:dcomic/database/sourceDatabaseProvider.dart';
import 'package:dcomic/model/comic_source/baseSourceModel.dart';

class IKanManSourceModel extends BaseSourceModel {
  IKanManSourceOptions _options = IKanManSourceOptions.fromMap({});

  IKanManSourceModel() {
    init();
  }

  Future<void> init() async {
    Map map = await SourceDatabaseProvider.getSourceOptions(type.name);
    _options = IKanManSourceOptions.fromMap(map);
  }

  @override
  Future<ComicDetail> get({String comicId, String title}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Comic> getChapter(
      {String comicId, String title, String chapterId, String chapterTitle}) {
    // TODO: implement getChapter
    throw UnimplementedError();
  }

  @override
  Widget getSettingWidget(context) {
    // TODO: implement getSettingWidget
    return Container();
  }

  @override
  // TODO: implement options
  SourceOptions get options => _options;

  @override
  Future<List<SearchResult>> search(String keyword, {int page: 0}) {
    // TODO: implement search
    throw UnimplementedError();
  }

  @override
  // TODO: implement type
  SourceDetail get type => SourceDetail(
      name: 'ikanman',
      title: '看漫画',
      description: '一个毫无卵用的漫画源，写出来是因为cimoc的原版有这个，甚至没有实现',
      canDisable: true,
      sourceType: SourceType.DeprecatedSource,
      deprecated: true,
      canSubscribe: false);

  @override
  // TODO: implement userConfig
  UserConfig get userConfig => InactiveUserConfig(this.type);

  @override
  Future<List<FavoriteComic>> getFavoriteComics(int page) {
    // TODO: implement getFavoriteComics
    throw UnimplementedError();
  }
}

class IKanManSourceOptions extends SourceOptions {
  @override
  bool get active => false;

  IKanManSourceOptions.fromMap(Map map);

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    return {'active': active};
  }

  @override
  set active(bool value) {
    // TODO: implement active
    return;
  }
}
