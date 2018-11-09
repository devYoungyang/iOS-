//
//  MXLoginAlertView.m
//  MXTourism
//
//  Created by Yang on 2018/9/12.
//  Copyright © 2018年 YY. All rights reserved.
//

#import "MXLoginAlertView.h"
@interface MXLoginAlertView ()
@property (nonatomic,copy)NSString* title;
@property (nonatomic,copy)NSArray *icons;
@property (nonatomic,copy)NSString *buttonTitle;
@property (nonatomic,copy)NSArray *placeHolers;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UIButton *bgView;
@property (nonatomic,strong)YYSQLiteManager *manager;

@end
@implementation MXLoginAlertView

-(instancetype)initWithTitle:(NSString *)title iconImgs:(NSArray *)icons buttonTitle:(NSString *)buttonTitle placeHolders:(NSArray *)placeHolders{
    if (self=[super init]) {
        self.title=title;
        self.icons=icons;
        self.buttonTitle=buttonTitle;
        self.placeHolers=placeHolders;
        [self createSubViews];
        [self initWithSQLite];
    }
    return self;
}
-(void)initWithSQLite{
    self.manager=[YYSQLiteManager shareBaseDB];
    NSString *paths=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo1.db"];
    [self.manager createDB:paths];
    [self.manager createTable:@"CREATE TABLE IF NOT EXISTS loginInfo (id INTEGER PRIMARY KEY,userName text,password text,email text,nickName text,city text)"];
}
-(void)createSubViews{
    self.frame=CGRectMake(0, 0, MainScreenW, MainScreenH);
    self.bgView=[UIButton buttonWithType:UIButtonTypeCustom];
    self.bgView.frame=CGRectMake(0, 0, MainScreenW, MainScreenH);
    self.bgView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.bgView addTarget:self action:@selector(tapClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.bgView];
    self.bgView.userInteractionEnabled=YES;
    CGFloat selfH=130+50*self.icons.count;
    self.contentView=[[UIView alloc] initWithFrame:CGRectMake(20, (MainScreenH-selfH)/2, MainScreenW-40, selfH)];
    self.contentView.backgroundColor=[UIColor whiteColor];
    self.contentView.layer.cornerRadius=10;
    self.contentView.layer.masksToBounds=YES;
    self.contentView.userInteractionEnabled=YES;
    [self.bgView addSubview:self.contentView];
    UILabel *titleLB=[[UILabel alloc] init];
    [self.contentView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(self.contentView.width-40);
        make.height.mas_equalTo(18);
    }];
    titleLB.text=self.title;
    titleLB.textAlignment=NSTextAlignmentCenter;
    CGFloat H=40, margin=15;
    for (NSInteger i=0; i<self.icons.count; i++) {
        UIView *boderView=[[UIView alloc] init];
        [self.contentView addSubview:boderView];
        [boderView setTag:10000+i];
        [boderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLB.mas_bottom).mas_offset(20+(H+margin)*i);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(H);
        }];
        boderView.layer.borderWidth=0.5;
        boderView.layer.cornerRadius=5;
        boderView.layer.borderColor=[UIColor lightGrayColor].CGColor;

        UIImageView *iconImgv=[[UIImageView alloc] init];
        [boderView addSubview:iconImgv];
        [iconImgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.width.mas_equalTo(20);
        }];
        iconImgv.image=[UIImage imageNamed:self.icons[i]];

        UITextField *textField=[[UITextField alloc] init];
        [boderView addSubview:textField];
        [textField setTag:1000+i];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(40);
            make.top.mas_equalTo(@10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(20);
        }];
        textField.placeholder=self.placeHolers[i];
    }
    UIButton *loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    loginBtn.layer.cornerRadius=5;
    [loginBtn setTitle:self.buttonTitle forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.backgroundColor=[UIColor redColor];
}
-(void)tapClicked:(UIButton *)tap{
    [self hide];
}
-(void)buttonClicked:(UIButton *)btn{
    if ([[btn titleForState:UIControlStateNormal] isEqualToString:@"登录"]) {
        UIView *boderView=[self.contentView viewWithTag:10000];
        UITextField *userName=[boderView viewWithTag:1000];
        UIView *boderView1=[self.contentView viewWithTag:10001];
        UITextField *password=[boderView1 viewWithTag:1001];
        NSString *sqlStr=[NSString stringWithFormat:@"select * from loginInfo where userName = '%@' ",userName.text];
        NSArray *dataArr= [self.manager selectDB:sqlStr];
        YANGLog(@"=====%@======",dataArr);
        if (dataArr.count==0) {
            [SVProgressHUD showErrorWithStatus:@"账号不存在"];
        }else if (userName.text.length==0) {
            [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        }else if (password.text.length==0){
            [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        }else if ([[[dataArr firstObject] objectForKey:@"password"] isEqualToString:password.text]) {
            NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:@"isLogin"];
            [defaults setObject:[dataArr firstObject] forKey:@"personInfo"];
             MXTabBarController*tabBarVC=[[MXTabBarController alloc] init];
            self.window.rootViewController=tabBarVC;
            [self.window makeKeyAndVisible];
        }else{
            [SVProgressHUD showErrorWithStatus:@"账号或密码错误"];
        }
    }else if([[btn titleForState:UIControlStateNormal] isEqualToString:@"注册"]){
        NSString *sqlStr=@"INSERT INTO loginInfo(userName,password,email,nickName,city) VALUES (?,?,?,?,?)";
        UIView *boderView=[self.contentView viewWithTag:10000];
        UITextField *userName=[boderView viewWithTag:1000];
        UIView *boderView1=[self.contentView viewWithTag:10001];
        UITextField *password=[boderView1 viewWithTag:1001];
        UIView *boderView2=[self.contentView viewWithTag:10002];
        UITextField *oncePassword=[boderView2 viewWithTag:1002];
        UIView *boderView3=[self.contentView viewWithTag:10003];
        UITextField *email=[boderView3 viewWithTag:1003];
        NSString *SQLStr=[NSString stringWithFormat:@"select * from loginInfo where userName = '%@' ",userName.text];
        NSArray *dataArr= [self.manager selectDB:SQLStr];
        if (userName.text.length==0) {
            [SVProgressHUD showErrorWithStatus:@"账号不能为空"];
        }else if (userName.text.length!=11){
            [SVProgressHUD showErrorWithStatus:@"账号格式不正确"];
        }else if (password.text.length==0||oncePassword.text.length==0){
            [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        }else if (![oncePassword.text isEqualToString:password.text]){
            [SVProgressHUD showErrorWithStatus:@"两次密码不一致"];
        }else if (oncePassword.text.length<6||password.text.length<6){
            [SVProgressHUD showErrorWithStatus:@"密码过于简单"];
        }else if (email.text.length==0){
            [SVProgressHUD showErrorWithStatus:@"邮箱不能为空"];
        }else if (email.text.length<=4||![[email.text substringWithRange:NSMakeRange(email.text.length-4, 4)] isEqualToString:@".com"]){
            [SVProgressHUD showErrorWithStatus:@"邮箱格式不正确"];
        }else if (dataArr.count>0){
            [SVProgressHUD showErrorWithStatus:@"账号已被注册"];
        }else{
            [self.manager InserSQL:sqlStr datasource:@[userName.text,password.text,email.text,@"Tom",@"上海"]];
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            [self hide];
        }
    }
}
-(void)show{
//    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}
-(void)hide{
    [self removeFromSuperview];
}
@end
