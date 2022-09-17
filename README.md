# DComic——简单奇怪的漫画阅读器

[![](https://img.shields.io/github/v/release/hanerx/flutter_dmzj)](https://github.com/hanerx/flutter_dmzj/releases/latest) [![](https://img.shields.io/github/downloads/hanerx/flutter_dmzj/total)](https://github.com/hanerx/flutter_dmzj/releases) ![](https://img.shields.io/github/release-date/hanerx/flutter_dmzj)

​	这是一个简单奇怪的漫画阅读器，前身是动漫之家的第三方APP，现在是一个多源解析的漫画阅读器，灵感来自于 [tachiyomi](https://github.com/tachiyomiorg/tachiyomi) 不过不同的是首页还是用的动漫之家的首页

**End of Support, New Version Will In New Depot**
[https://github.com/hanerx/DComicReborn](https://github.com/hanerx/DComicReborn)

~~**还是那句话，大家暗搓搓用，不允许发布到任何公共社交平台上，如果影响较大就直接删库**~~

**由于动漫之家的服务器启用了新的接口，新接口采用加密算法，初步猜测是aes或者魔改的base64，因为无法读取所以动漫之家漫画源的接口会逐步停止支持**

## 免责声明

1. 这是第三方的APP，所展示的内容均来自于数据提供源，本程序不对程序展示的内容负责。
2. 本程序并未获得解析源授权，故在任何时刻均有可能下架。
3. 本程序由于是第三方APP，提供的登录功能可能存在风险，您使用本程序的登录功能即代表您了解并愿意承担该风险。

## 隐私条款

1. 本软件在除存储登录凭证等必要情况下不会收集您的数据源账号信息，如账户密码、订阅列表等。
2. 本软件将会匿名收集您的异常记录与其外围数据用于软件维护，如果您不希望上传这些数据请在 `设置->调试->启用崩溃追踪` 中关闭。
3. 各个漫画源的隐私条款请以各个漫画源官网隐私条款为准，本软件不对此负责。

## 概览

​	本软件主要用于解决多个漫画源造成的APP冗余问题，并提供类原生的使用体验。漫画数据通过API接口爬取获取，部分接口使用类BeatifulSoup插件实现HTML文件解析实现。支持json、html、JavaScript等语言的数据解析。

## 下载

[https://github.com/hanerx/flutter_dmzj/releases/latest](https://github.com/hanerx/flutter_dmzj/releases/latest)

<img src=".\doc\image-20210419184914844.png" alt="image-20210419193403782" />

## 预览

<img src=".\doc\image-20210419193403782.png" alt="image-20210419193403782" style="zoom: 80%;" /><img src=".\doc\image-20210419193440494.png" alt="image-20210419193440494" style="zoom: 80%;" /><img src=".\doc\image-20210419193540196.png" alt="image-20210419193540196" style="zoom: 80%;" />

## 程序功能

- 看漫画
  - 音量翻页
  - 点击翻页
  - 双指放大
  - 背景颜色更换
  - 纵向横向切换
  - 左右阅读方向切换
  - 禁用翻页动画
- 浏览动漫之家首页
- 浏览动漫之家分类、排行、最近更新等附属页面
- 多解析源漫画浏览
  - 动漫之家
  - 动漫之家网页版
  - Mangabz
  - 漫画柜
  - KuKu漫画
  - 本地漫画（beta）
  - 拷贝漫画
  - 自建服务器（alpha）
- 多解析源漫画搜索
- 多解析源漫画自动绑定
- 多解析源历史记录查看
- 多解析源订阅内容查看
- 多用户登录
- 漫画下载（重构中，不稳定）
- 本地漫画解析（自封装格式.manga）
- 多解析源漫画分享
- 动漫之家评论查看
- IPFS去中心化网络漫画源（alpha版本）

## 问题报告与新功能建议

### 如何提交你的问题

1. 请先确认你的问题是否非常必要，如果您只是想唠嗑请直接去 [讨论版](https://github.com/hanerx/dcomic/discussions) 水贴
2. 请先查看 [FAQ](#FAQ) 和已关闭的 [ISSUE](https://github.com/hanerx/dcomic/issues) ，这里很可能有你需要的问题，如果没有请再选择新建 [ISSUE](https://github.com/hanerx/dcomic/issues/new/choose)
3. 请按照给出的模板填写相关信息，信息不足可能导致您的ISSUE被丢入垃圾桶
4. 请耐心等待开发者回复，或者跑去 [讨论版](https://github.com/hanerx/dcomic/discussions) 直接水贴

### 关于崩溃追踪

​	本软件集成了Firebase的crashlytics功能，因此很多问题我后台能获得足够多的数据，如果你不想写issue或者又没法把问题讲清楚请打开崩溃追踪，我后台看到异常足够频繁时自然会提醒我该修bug了。你不想提供数据也讲不清楚怎么复现的话麻烦你忍忍，等我啥时候碰到了的时候再说，或者去用 [tachiyomi](https://github.com/tachiyomiorg/tachiyomi) 。

### 新的功能建议

1. 我的工作进度都是在issue里有的，每个功能我都会开一个issue来记录，所以推荐也是去那里看看有没有你想要的功能，我有可能已经在摸了（
2. 如果每个在搞得issue里面都没有你需要的功能麻烦按照标准的模板开一个issue，我看到以后会去实现的。
3. 求人不如求自己，从1.0.0的版本到现在1.4.10后台的代码已经很模块化了（在解析源这块），如果你有一定的代码水平的话我是很欢迎你直接实现一个源然后pull request给我。
4. 我水平很菜的，代码有多丑我是知道的，在改了在改了。

## IPFS相关

### 自建服务器

​	软件内置了一套自建服务器的管理界面和其配套的解析模块，你可以从 https://github.com/hanerx/dcomic-server 这个项目里拿到服务端的代码，服务端采用MongoDB作为数据库，请确认go-ipfs、MongoDB可以运行后执行go run启动服务端。在软件中添加网址后即可完成自建服务器的使用。

### IPFS客户端

​	先来说一下IPFS是啥，IPFS是一套去中心化的存储解决方案，我们用这个来解决咱们自建服务器没有足够好的服务器来放漫画图片，我们选择直接丢到IPFS网络里面，然后依靠IPFS网络来存储，因此你可以不在服务器上存这些图片文件，直接在自己电脑里存着就行，理论上有足够的节点存了这些东西的话就能保证文件不丢，反正很cooool。

​	软件里提供了两套IPFS客户端的实现，第一种需要你有一个IPFS节点，但是他的访问速度是真的很快，反正你要自建的话得有这么一个节点，填你服务器的IPFS端口就行了。第二种是直接通过ipfs.io访问，但是这个网址被墙了，基本都要靠代理，但是他不用节点，你直接访问就完事了，各位自行选择好了。

## 开发

### 安装

```shell
flutter pub get
flutter build apk
```

### 实现解析源

​	想开发这玩意的估计也都是想加几个解析源了吧，那我就先写解析源的结构啥的了，其他的先放着 ~~毕竟干脆没重构完~~

- 一个可用的解析源必须需要实现以下几个类
  - BaseSourceModel
  - ComicDetail
  - Comic
  - SourceOptions
  - SearchResult
- 可选的得实现下面几个类
  - UserConfig（主要用于处理用户管理的各种问题，不用登录和订阅的可以不实现这个逼玩意）
  - SourceOptionProvider（这个其实就是SourceOptions的一个Provider类，主要是因为设置里flutter的控件监听需要个ChangeNotiferProvider来提供更新，如果你没有啥需要配置的选项其实这个也可以不管）

​	之后就是把你实现好的解析源注册到SourceProvider这个类里面了，很简单，在init那个函数里直接add就好了。嘛，蛮复杂的，就现在暂时这样吧，毕竟代码水平在这里了。

### .manga文件格式

​	.manga是一个我自己封装的漫画格式，欸，就很coooool。其实这玩意很简单，就是一个zip文件改了个名字，你直接把后缀改成zip你也能直接解压出来，所以，嘛，就你直接用zip格式我也能正常解析。你说为啥改成这个后缀——浪漫，嗯，就浪漫。

​	这个格式主要就两个东西，一个是data文件夹，顾名思义就是存储图片啊杂七杂八的数据的地方，第二个就是meta.json这个文件，也很好理解，里面存了这个漫画叫啥每个图片是哪个章节的一系列详情信息，编码格式。。。显而易见肯定是json，额，对就是json格式的编码。然后这个玩意主要是在 `/model/mag_model/baseMangaModel.dart` 这个文件里面实现的，现在是个很早期的版本，所以bug和缺陷起飞，问题与大饼共舞。教程啥的有空再说吧，就现在的支持就支持本地图片的解析，例子里那些牛逼哄哄的都没有的，所以就这样了（

​	虽然我认为不存在嗷，有没有大手子来帮忙重构一个（逃

## FAQ

#### 漫画源在哪里，为啥我没有这么多漫画源

​	在 `设置->漫画源->漫画源管理` 里有所有的漫画源和他们的可配置选项，你可以在这里配置这些漫画源的开关。

#### 漫画为啥不能解析，显示未绑定漫画ID

​	部分漫画源的同本漫画因为各种原因没法被全称搜索到，需要你点击下面的 `点击此处打开搜索` 手动选择漫画，部分源是确实没有这本漫画的，这种就没有办法了。

#### 我绑定错ID了，现在解析成其他漫画了，怎么解决

​	在绑定ID的右侧有一个刷新按钮，点击按钮后即可进行手动的重新绑定。

#### 我怎么登录

​	在侧边栏右上角有一个账户管理按钮，点击后会自动跳转至登录页面，选择需要的源进行登录即可。无法点击可能由于您已登录或者该源不支持登录，请参考右侧图表。带 `√` 即为已登陆成功，如需重新登录请去 `设置->用户` 选择需要登出的源进行登出操作。出现 `X` 标识即为该源不支持登录操作，如需要该源的用户管理等功能，请提交 [ISSUE](https://github.com/hanerx/dcomic/issues/new/choose) 。

#### 评论在哪里

​	漫画详情的评论在右侧侧边栏中，请从右往左滑。除动漫之家以外其他漫画源均不支持评论，请耐心等待更新。

#### 找不到我的问题

​	请参见 [如何提交你的问题](#如何提交你的问题) 。
