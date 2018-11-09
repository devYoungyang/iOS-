//
//  MXTabBarController.m
//  MXFootBall
//
//  Created by zt on 2018/3/5.
//  Copyright © 2018年 zt. All rights reserved.
//
#import "MXNavigationController.h"
#import "MXTabBarController.h"
#import "AppDelegate.h"

@interface MXTabBarController ()
@property (nonatomic,strong)UILabel *selectLine;
@end

@implementation MXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self addAllVCs];
    
//    self.selectLine= [[UILabel alloc] initWithFrame:CGRectMake(MainScreenW/12, MainScreenH-2-TABBAR_FRAME, MainScreenW/12, 2)];
//    self.selectLine.backgroundColor=[UIColor redColor];
//    [self.view addSubview:self.selectLine];
    self.tabBar.shadowImage = [UIImage new];//去线
    YANGLog(@"==========%@=========",self.viewControllers);
}

- (void)addAllVCs {
    MXHomeViewController *homeVC=[[MXHomeViewController alloc] init];
    [self addChildVc:homeVC selectedImage:@"Home" withTitleSelectColor:[UIColor blackColor] unselectedImage:@"Home_unselected" tag:1];
    
    MXLocationViewController *locationVC = [[MXLocationViewController alloc]init];
    [self addChildVc:locationVC  selectedImage:@"Explore_selected" withTitleSelectColor:[UIColor blackColor] unselectedImage:@"Explore_selected" tag:2];
    
    MXRecommendViewController *recommendVC = [[MXRecommendViewController alloc]init];
    [self addChildVc:recommendVC selectedImage:@"Profile_unselected" withTitleSelectColor:[UIColor blackColor] unselectedImage:@"Profile_unselected" tag:3];

    MXMineViewController *mineVC = [[MXMineViewController alloc]init];
     [self addChildVc:mineVC  selectedImage:@"Feed_selected" withTitleSelectColor:[UIColor blackColor] unselectedImage:@"Feed_selected" tag:4];
}

- (void)addChildVc:(UIViewController *)childVc selectedImage:(NSString *)selectedImage
    withTitleSelectColor:(UIColor *)selectColor
   unselectedImage:(NSString *)unselectedImage
         tag:(NSInteger)tag{
    //设置图片
    childVc.tabBarItem  = [childVc.tabBarItem initWithTitle:@"" image:[[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    childVc.tabBarItem.tag = tag;//设置
    childVc.tabBarController.selectedIndex = tag;
    MXNavigationController *nav=[[MXNavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    CGFloat x=(3*viewController.tabBarItem.tag-2) * MainScreenW/12;
//    [UIView animateWithDuration:0.5 animations:^{
//       self.selectLine.frame=CGRectMake(x, MainScreenH-2-TABBAR_FRAME,MainScreenW/12, 2);
//    }];
    
//    if (self.selectedIndex==3) {
//        NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
//        if ([[defaults objectForKey:@"isLogin"] boolValue]!=YES) {
//            MainViewController *mainVC=[[MainViewController alloc] init];
//            mainVC.hideBackButton=NO;
//            [self presentViewController:mainVC animated:YES completion:nil];
//        }
//    }
}

@end
