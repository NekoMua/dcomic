import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutterdmzj/component/LoadingCube.dart';
import 'package:flutterdmzj/component/LoadingRow.dart';
import 'package:flutterdmzj/component/SubscribeCard.dart';
import 'package:flutterdmzj/database/database.dart';
import 'package:flutterdmzj/http/http.dart';
import 'package:flutterdmzj/model/comicFavoriteModel.dart';
import 'package:flutterdmzj/model/novelFavoriteModel.dart';
import 'package:flutterdmzj/utils/static_language.dart';
import 'package:flutterdmzj/view/novel_pages/novel_detail_page.dart';
import 'package:provider/provider.dart';

class NovelFavoritePage extends StatefulWidget {
  final String uid;

  const NovelFavoritePage({Key key, this.uid}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NovelFavoritePage();
  }
}

class _NovelFavoritePage extends State<NovelFavoritePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (_)=>NovelFavoriteModel(widget.uid),
      builder: (context,child){
        return EasyRefresh(
          scrollController: ScrollController(),
          onRefresh: () async {
            await Provider.of<NovelFavoriteModel>(context,listen: false).refresh();
          },
          onLoad: () async {
            await Provider.of<NovelFavoriteModel>(context,listen: false).nextPage();
          },
          header: ClassicalHeader(
              refreshedText: '刷新完成',
              refreshFailedText: '刷新失败',
              refreshingText: '刷新中',
              refreshText: '下拉刷新',
              refreshReadyText: '释放刷新'),
          footer: ClassicalFooter(
              loadReadyText: '下拉加载更多',
              loadFailedText: '加载失败',
              loadingText: '加载中',
              loadedText: '加载完成',
              noMoreText: '没有更多内容了'),
          firstRefresh: true,
          firstRefreshWidget: LoadingCube(),
          child: Container(
            padding: EdgeInsets.fromLTRB(2, 7, 2, 0),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 0.6,
              children: Provider.of<NovelFavoriteModel>(context).getFavoriteWidget(context),
            ),
          ),
        );
      },
    );
  }
}