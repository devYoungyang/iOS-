//
//  MainViewController.m
//  MXTourism
//
//  Created by Yang on 2018/9/11.
//  Copyright © 2018年 YY. All rights reserved.
//
#import "MXLoginAlertView.h"
#import "MainViewController.h"

@interface MainViewController ()
@property (nonatomic,strong)UIImageView *bgImgView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackgroundImg];
    [self setUpUI];
    if (self.hideBackButton==NO) {
      [self setBackButton];
    }
}
-(void)setBackButton{
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(15, STATUS_HEIGHT+10, 20, 15);
    [backBtn addTarget:self action:@selector(clickedBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImgView addSubview:backBtn];
}
-(void)clickedBackButton:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setBackgroundImg{
    _bgImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,MainScreenW, MainScreenH)];
    _bgImgView.image=[UIImage imageNamed:@"Bitmap"];
    _bgImgView.userInteractionEnabled=YES;
    _bgImgView.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.bgImgView];
}
-(void)setUpUI{
    
    CGFloat margin =20;
    CGFloat w= (MainScreenW-3*margin)/2;
    for (NSInteger i=0; i<2; i++) {
        UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView=[[UIVisualEffectView alloc] initWithEffect:blurEffect];
        effectView.frame=CGRectMake(margin+(w+margin)*i, MainScreenH-100-TABBAR_FRAME, w, 50);
        effectView.alpha=0.5;
        effectView.layer.cornerRadius=8;
        effectView.layer.masksToBounds=YES;
        [self.bgImgView addSubview:effectView];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(margin+(w+margin)*i, MainScreenH-100-TABBAR_FRAME, w, 50);
        switch (i) {
            case 0:
                [button setTitle:@"登录" forState:UIControlStateNormal];
                break;
            case 1:
                [button setTitle:@"注册" forState:UIControlStateNormal];
            default:
                break;
        }
        [button setTag:100+i];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgImgView addSubview:button];
    }
    
}
-(void)buttonClicked:(UIButton *)btn{
    if (btn.tag==100) {
        MXLoginAlertView *alertView=[[MXLoginAlertView alloc] initWithTitle:@"登录" iconImgs:@[@"userIcon",@"password"] buttonTitle:@"登录" placeHolders:@[@"请输入用户名",@"请输入密码"]];
        [self.view addSubview:alertView];
    }else
    {
        MXLoginAlertView *alertView=[[MXLoginAlertView alloc] initWithTitle:@"注册" iconImgs:@[@"userIcon",@"password",@"password",@"email"] buttonTitle:@"注册" placeHolders:@[@"请输入用户名",@"请输入密码",@"请再次输入密码",@"请输入邮箱"]];
        [self.view addSubview:alertView];
    }
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
