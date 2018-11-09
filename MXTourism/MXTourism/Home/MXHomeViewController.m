//
//  MXHomeViewController.m
//  MXTourism
//
//  Created by Yang on 2018/9/12.
//  Copyright © 2018年 YY. All rights reserved.
//
#import "NSDictionary+Category.h"
#import "Person.h"
#import "MXSubHomeVC.h"
#import "MXBannerCell.h"
#import "WLScrollView.h"
@interface MXHomeViewController ()
<WLScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray *imageArrs;
@property (nonatomic,strong)dispatch_semaphore_t semaphore;
@property (nonatomic,strong)WLScrollView *wlScrView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation MXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self setBackgroundWithImgName:@"BG1"];
    self.semaphore=dispatch_semaphore_create(0);
    [self requestWithNetWorkData];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUpUI];
        });
    });
    [[YYSQLiteManager shareBaseDB] createSQLiteName:@"user123"];
    Person *p=[[Person alloc] init];
    p.userName=@"TOM";
    p.age=@"24";
    p.sex=@"1";
    p.address=@"shanghai";
    [[YYSQLiteManager shareBaseDB] createTableWithName:@"login123" andModel:p];
    [[YYSQLiteManager shareBaseDB] InserDatasourceWithModel:p];
//    YANGLog(@"=======%@=========",[[YYSQLiteManager shareBaseDB] selectSQLiteWithKeyWord:@"sex" andValue:@"1"]);
}
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f,0.0f, 1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)setUpUI{
    for (UIView *view in [self.bgImgView subviews]) {
        [view removeFromSuperview];
    }
    
    UILabel *titleLB=[[UILabel alloc] initWithFrame:CGRectMake(20, STATUS_HEIGHT+30, 100, 24)];
    titleLB.text=@"探索";
    titleLB.font=[UIFont systemFontOfSize:22];
    titleLB.textColor=[UIColor whiteColor];
    [self.bgImgView addSubview:titleLB];
    UILabel *subTitle=[[UILabel alloc] initWithFrame:CGRectMake(20, STATUS_HEIGHT+65, 200, 15)];
    subTitle.textColor=[UIColor whiteColor];
    subTitle.text=@"一个神秘的国度";
    subTitle.font=[UIFont systemFontOfSize:14];
    [self.bgImgView addSubview:subTitle];
    _wlScrView = [[WLScrollView alloc]initWithFrame:CGRectMake(0, STATUS_HEIGHT+70, WLScreen_width, MainScreenH-TABBAR_HEIGHT-TABBAR_FRAME-STATUS_HEIGHT-100)];
    _wlScrView.delegate = self;
    _wlScrView.isAnimation = YES;
    _wlScrView.backgroundColor=[UIColor orangeColor];
    //是否轮播。轮播设置为NO 或者不设置
    _wlScrView.isEnableMargin = YES;
    _wlScrView.scale = 0.8;
    _wlScrView.marginX = -20;
    _wlScrView.maxAnimationScale = 0.8;
    _wlScrView.minAnimationScale = 0.8;
    _wlScrView.backgroundColor = [UIColor clearColor];
    //设置起始位置 默认 0
    //    [wlScrView setIndex:2];
    [_wlScrView starRender];
    [self.bgImgView addSubview:self.wlScrView];
    
    self.pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(60, MainScreenH-TABBAR_HEIGHT-TABBAR_FRAME-30, self.bgImgView.width-120, 20)];
    self.pageControl.numberOfPages=6;
    self.pageControl.currentPage=0;
    [self.pageControl setValue:[UIImage imageNamed:@"line_selected"] forKeyPath:@"_currentPageImage"];
    [self.pageControl setValue:[UIImage imageNamed:@"line_unselected"] forKeyPath:@"_pageImage"];
    [self.bgImgView addSubview:self.pageControl];
}
-(NSMutableArray *)imageArrs{
    if (!_imageArrs) {
        _imageArrs=[NSMutableArray array];
    }
    return _imageArrs;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}
-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.backgroundImage = [self imageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];//透明
}
-(void)viewDidDisappear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden=NO;
    self.tabBarController.tabBar.backgroundImage=[self imageWithColor:[UIColor whiteColor]];
}
-(void)requestWithNetWorkData{
    mx_weakify(self);
    [YYHttpRequest GET:BaseUrl parameters:@{@"cityid":@"2",@"lon":@"113.9419963645788",@"lat":@"22.54091839235643",@"sort":@"1",@"apikey":@"YNabLuqFkAjMeVKL8sRjrseTM4KEKhvpdkQimIFgjAyTQ6fbT5CHU0rKyTBOLozw"} HttpRequestCache:^(id responseCache) {
        weakSelf.dataSource=[responseCache objectForKey:@"data"];
        for (NSInteger i=0; i<6; i++) {
            NSMutableDictionary *dict=[NSMutableDictionary dictionary];
            [dict setObject:[[[responseCache objectForKey:@"data"] objectAtIndex:i] objectForKey:@"title"] forKey:@"title"];
            [dict setObject:[[[[responseCache objectForKey:@"data"] objectAtIndex:i] objectForKey:@"imageUrls"] firstObject] forKey:@"imageUrls"];
            [dict setObject:[[[responseCache objectForKey:@"data"] objectAtIndex:i] objectForKey:@"subtitle"] forKey:@"description"];
            [weakSelf.imageArrs addObject:dict];
        }
        dispatch_semaphore_signal(self.semaphore);
    } success:^(NSDictionary *responseObject) {
        weakSelf.dataSource=[responseObject objectForKey:@"data"];
        for (NSInteger i=0; i<6; i++) {
            NSMutableDictionary *dict=[NSMutableDictionary dictionary];
            [dict setObject:[[[responseObject objectForKey:@"data"] objectAtIndex:i] objectForKey:@"title"] forKey:@"title"];
            [dict setObject:[[[[responseObject objectForKey:@"data"] objectAtIndex:i] objectForKey:@"imageUrls"] firstObject] forKey:@"imageUrls"];
            [dict setObject:[[[responseObject objectForKey:@"data"] objectAtIndex:i] objectForKey:@"subtitle"] forKey:@"description"];
            [weakSelf.imageArrs addObject:dict];
        }
        dispatch_semaphore_signal(self.semaphore);

    } failure:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - WLScrollViewDelegate

- (NSInteger)numOfContentViewScrollView:(WLScrollView *)scrollView{
    return 6;
}
- (WLSubView *)scrollView:(WLScrollView *)scrollView subViewFrame:(CGRect)frame cellAtIndex:(NSInteger)index{
    NSDictionary *dict=self.imageArrs[index];
    static NSString *cellID = @"123";
        MXBannerCell *sub = (MXBannerCell *)[scrollView dequeueReuseCellWithIdentifier:cellID];
        if (!sub) {
            sub = [[MXBannerCell alloc] initWithFrame:frame Identifier:cellID];
        }
    [sub.bgImageView sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"imageUrls"]]];
    sub.bgImageView.contentMode=UIViewContentModeScaleAspectFill;
    sub.locationLB.text=[dict objectForKey:@"title"];
    sub.detailLB.text=[dict objectForKey:@"description"];
    return sub;
}
- (void)scrollView:(WLScrollView *)scrollView didSelectedAtIndex:(NSInteger)index{
    MXSubHomeVC *subVC=[[MXSubHomeVC alloc] init];
    subVC.imageUrl=[self.imageArrs[index] objectForKey:@"imageUrls"];
    subVC.dataSources=self.dataSource[index];
    [self.navigationController pushViewController:subVC animated:YES];
//    [self presentViewController:subVC animated:YES completion:nil];
//    NSLog(@"点击 index %zd",index);
}
- (void)scrollView:(WLScrollView *)scrollView didCurrentCellAtIndex:(NSInteger)index{
//    NSLog(@"现在显示的 index %zd",index);
    self.pageControl.currentPage=index;
}


@end
