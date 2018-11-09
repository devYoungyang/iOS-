//
//  BaseViewController.m
//  MXTourism
//
//  Created by Yang on 2018/9/12.
//  Copyright © 2018年 YY. All rights reserved.
//


#import "UIImage+Category.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackButton];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
}
-(void)setBackgroundWithImgName:(NSString *)imageName{
    _bgImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,MainScreenW, MainScreenH)];
    _bgImgView.contentMode=UIViewContentModeScaleAspectFill;
    if ([imageName containsString:@"https"]) {
        [_bgImgView sd_setImageWithURL:[NSURL URLWithString:imageName]];
    }else{
      _bgImgView.image=[UIImage imageNamed:imageName];
    }
    _bgImgView.userInteractionEnabled=YES;
    [self.view addSubview:self.bgImgView];

    UIImage *image=[[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(void)setBackButtonTitle:(NSString *)title andImage:(NSString *)imageName{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = title;
    self.navigationItem.backBarButtonItem=backItem;
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:imageName];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:imageName];
    /**
     UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
     [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
     [backButton setTitle:title forState:UIControlStateNormal];
     [backButton addTarget:self action:@selector(backItemClicked) forControlEvents:UIControlEventTouchUpInside];
     UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
     self.navigationItem.leftBarButtonItem = backItem;
     //这个方法失去手势返回功能,当前页面设置
     **/
}
-(void)setBackButton{
    [self setBackButtonTitle:@" " andImage:@"back"];
}
-(void)backItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSDictionary *)dataSources{
    if (!_dataSources) {
        _dataSources=[NSDictionary dictionary];
    }
    return _dataSources;
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
