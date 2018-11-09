//
//  MainViewController.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/8.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "MainViewController.h"
#import <CoreGraphics/CoreGraphics.h>
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
     项目名称：球友乐
     项目周期：2018.2～2018.6（纯原生）  2016.6～8(RN二次开发然后和原生混编)
     项目描述：球友乐是我司为迎接2018世界杯而开发的一个足球项目。
     项目分为四个模块、
     首页：最新足球赛事，最热论坛资讯。
     赛事：各类足球赛事应有尽有，时时文字或动画直播世界杯赛事。赛事开始前可以竞彩的赛事可以发布赛事观点（推荐理由）。发布观点需要消耗积分，解锁观点需要花费积分，支持观点也消耗积分。 观点有两种玩法：1.混合。2.胜负平。点击对应赛事可以参看盘面，队伍阵容，赔率和已发布的观点。进入直播，事件统计记录赛事情况。进球分布分析进球情况。聊天室可以发送两种消息：1.普通聊天消息（展示在消息显示栏）。 2.弹幕（需要消耗用户积分）。
     论坛：查看，收藏，分享，评论，球友或官方发布的帖子。打赏和关注楼主。发布帖子。
     个人中心：积分任务，签到，粉丝，关注，用户名，头像，收藏等等。
     主要技术：
     1.使用MVC设计模式
     2.在圆角比较多的列表，为优化用户体验使用CoreGraphics和贝塞尔曲线绘制圆角放弃使用layer.cornerRadius
     3.使用GCD线程组，信号量，线程栅栏 待请求到网络数据时在渲染页面。
     4.接入腾讯bugly采集分析线上崩溃
     5.数据无痕埋点（分析用户喜好，使用时间段，使用时长等）封装好的静态库
     6.使用PPNetworkHelper实现对网络数据的缓存(对AFNetworking 3.x 与YYCache的二次封装,封装常见的GET、POST、文件上传/下载、网络状态监测的功能、方法接口简洁明了,并结合YYCache实现对网络数据的缓存,简单易用,不用再写FMDB那烦人的SQL语句,一句代码搞定网络数据的请求与缓存. 无需设置,无需插件,控制台可直接打印json中文字符,调试更方便)
     7.使用SocketRocket开发聊天室，使用Block封装SocketRocket，提供建立连接成功的回调，断开连接回调，发送消息成功或失败的回调，发送心跳包，断开重连机制（重连时间2的指数级增长）等接口。消息框使用SDAutoLayout做Cell和Tableview高度自适应。开源弹幕渲染库使用的是BarrageRenderer
     8.使用SDWebImage，实现图片异步缓存、加载、计算缓存大小、清除缓存等功能
     9.赛事界面采用属性传值传递matchId，聊天室使用通知传值，使用NSUserDefaults保存用户信息
     10.论坛帖子内容使用富文本图文混排，并使用AFN进行多图上传。
     11.代码混淆，
     12.使用MD5对排序完成后的参数进行加密得到sign进行验签
     13.使用WKWebView加载h5页面，首页图库为h5页面，使用JavaScriptCore进行原生与h5的交互，提供一个保存图片到相册的方法让h5调用
     14.集成微信登录，友盟分享分享帖子到朋友圈或微信好友。 极光推送：推送已收藏即将开始的赛事，点击通知跳转到对应赛事直播页面。
     15.赛事进球分布使用PNChart绘制进球分布柱状图。
     16使用MJExtension做json解析。MJRefresh做下拉刷新和上拉加载更多。IQKeyboardManager管理键盘。SVProgressHUD做提示框。SDCycleScrollView做轮播图。YBImageBrowser做图片浏览器，使用Masonry自动布局框架。
     */
    
    /**
     
     应用市场用户争夺越来越激烈，优质化的用户体验成为决定现在的一款APP软件是否留住用户的关键，所以如何开发高性能的优质APP，成为时下最受关注的热点。本文总结几点开发APP的技巧供大家参考：
     1、定位好核心功能
     在做一款高性能的优质APP之前，得先想好这款APP需要解决用户哪些实际的需求，然后提炼出这款APP的主要功能，一个APP并不需要花里胡哨的功能，核心功能才是需要定位清楚的关键。
     2、做好应用架构评估
     在定位好核心功能之后，接下来就要做好应用架构评估。一般不匹配的技术选择、低效的网络配置、可扩展性的限制、不符合移动端的UI设计等都会影响应用程序性能，所以做好清晰完整的APP架构规划才有利于构建用户所需的系统功能。
     3、养成良好的编程习惯
     良好的编程习惯可以提高程序的执行效率，让应用开发事半功倍。程序员可以从程序结构模块化、命名规则化、注释简介明了化、文本格式易读化等方面让程序结构清晰、合理，使得程序代码易于读懂跟修改。
     4、加速程序启动跟响应时间
     大家日常中都使用过APP，APP的快速启动与响应往往会让我们改观它其他方面的不足，所以程序员应该在后台线程上花点功夫，将操作从主线移动到一个单独的线程中，缓存从磁盘存储中打开和阅读，客户端证书在后台加载。
     Cookies反序列化和解码放在后台，相信通过这些改变，UI将会更加快速的出现在屏幕上。主意，用Xcodedebug时watchdog并不运行，一定要把设备从Xcode断开来测试启动速度。
     5、使用最新版本的软件开发SDK、API
     随着安卓、iOS平台的不断发展与更新，软件开发平台的性能会得到不断的改进，可以帮助程序员编写出运行更稳定、响应更迅速的应用程序。
     6、使用SuperWebView，让APP支持动态更新
     对于已经上线的app面对更新新功能时， SuperWebView功能支持动态更新，这样的好处在于可以不通过应用商店的审核，用户无需重新下载APP，即可受到新功能的更新信息。
     7、使用StrictMode调解android性能
     StrictMode是用来检测程序中违规情况的开发者工具，意思是严格模式，程序员最常用它来检测主线程中本地磁盘和网络读写等耗时的操作，使用此模式，当系统检测出主线程违例的情况会将应用的违例细节暴露给程序员，方便程序员优化和改善程序。
     8、使用Hierarchy Viewer调试应用布局
     Hierarchy Viewer会让你选择设备或者模拟器上正在运行的进程，显示出它的layout的树型结构，模块上的交通灯代表了它在测量、布置和绘画时的性能，帮助你找到瓶颈部分，从而改善性能。
     9、优化应用耗电量
     当用户发现一个APP很耗电时，用户往往会选择卸载掉应用来保存手机电量，根据调查显示，当一个APP中有使用到GPS定位、网络传输、屏幕亮度、CPU频率等时就会非常耗电，所以程序员应该对应用优化这几点以降低耗电风险。
     10、优化应用布局，确保布局简单、浅层
     使用lint工具查看view层级有哪些地方可以优化，帮助你找到不必要对控件镶套以及所见布局资源对方法，尽量减少资源的使用，控件越少、布局层次越浅，性能就越好。
     11、规划应用的离线体验
     如果当用户连接不上Wi-Fi或者移动信号的时候，你的APP依然可以使用，那么一定会在用户心里添加不少的印象分，所以在规划APP应用时，可以考虑将这一设计规划其中。
     12、发布之前尽量少用调试跟诊断
     如果你的应用程序已经开发了一段时间，你的应用程序中有可能已经被嵌入了一些日志跟调试代码，这些可能会给系统的性能带来一定的影响，因此建议尽量少用或者禁止使用这些功能。
     13、缓存
     通常来说，一个APP是由多个组件构成的，在这些组件中都有缓存的影子，当缓存后的数据再次被调用时就可以直接提供数据，提高数据的响应速度。因此缓存是改善应用程序响应速度和降低CPU负载的有效方式。
     14、充分利用云移动
     充分利用云移动传输来传递服务器与数据中心的移动内容，因为服务器与数据中心与终端移动用户之间有绝对的地理优势，不过在做出选择之前一定要充分考虑到双方的负荷量及地理位置。
     15、整合资源
     对开发者来说，将Javascript代码和CSS样式放到公共的文件中供多个页面共享是一种标准的优化方法。这个方法能很简单的维护代码，并且提高客户端缓存的使用效率。
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
