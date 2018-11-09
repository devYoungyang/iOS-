//
//  MXMineViewController.m
//  MXTourism
//
//  Created by Yang on 2018/9/12.
//  Copyright © 2018年 YY. All rights reserved.
//
#import "MXAboutViewController.h"
#import "MXUpdatePersonInfoVC.h"
#import "AlertControllerMaker.h"
@interface MXMineViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UIImageView *headerImgView;

@property (nonatomic,strong)NSString *imagePaths;
@end

@implementation MXMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"个人中心";
    
    UIView *topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, 160)];
    [self.view addSubview:topView];
    UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BluredPhoto"]];
    imageView.contentMode=UIViewContentModeScaleToFill;
    imageView.frame=CGRectMake(0, 0, MainScreenW, 160);
    [topView addSubview:imageView];
    
    _headerImgView=[[UIImageView alloc] initWithFrame:CGRectMake((MainScreenW-90)/2, 115, 90, 90)];
    _headerImgView.layer.cornerRadius=45;
    _headerImgView.layer.masksToBounds=YES;
    UIImage *image=[[UIImage alloc] initWithContentsOfFile:self.imagePaths];
    [self.view addSubview:self.headerImgView];
    _headerImgView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
    [_headerImgView addGestureRecognizer:tap];
    
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    NSDictionary *personInfo= [defaults objectForKey:@"personInfo"];
    if ([[defaults objectForKey:@"isLogin"] boolValue]==YES) {
        NSString *paths=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        self.imagePaths=[paths stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[personInfo objectForKey:@"userName"]]];
        [self setUpUI];
        if (image) {
            _headerImgView.image=image;
        }else{
            _headerImgView.image=[UIImage imageNamed:@"Avatar"];
        }
    }else{
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, 0, MainScreenW-40, 100);
        button.center=self.view.center;
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitle:@"是否前往登录" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickedLoginButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        _headerImgView.image=[UIImage imageNamed:@"headimg"];
    }
}
-(void)clickedLoginButton{
    MainViewController *mainVC=[[MainViewController alloc] init];
    mainVC.hideBackButton=NO;
    [self presentViewController:mainVC animated:YES completion:nil];
}
-(void)setUpUI{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 220, MainScreenW, MainScreenH-220-TABBAR_FRAME-TABBAR_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    UIView *footerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, 80)];
    UIButton *loginOutButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [loginOutButton setTitle:@"退出" forState:UIControlStateNormal];
    [loginOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginOutButton.frame=CGRectMake(40, 20, MainScreenW-80, 50);
    loginOutButton.layer.cornerRadius=5;
    loginOutButton.layer.masksToBounds=YES;
    [footerView addSubview:loginOutButton];
    footerView.userInteractionEnabled=YES;
    loginOutButton.backgroundColor=[UIColor redColor];
    [loginOutButton addTarget:self action:@selector(clickedLoginOutButton:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView=footerView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
-(void)clickedLoginOutButton:(UIButton *)btn{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"isLogin"];
    [SVProgressHUD showSuccessWithStatus:@"退出成功"];
    MainViewController *mainVC=[[MainViewController alloc] init];
    mainVC.hideBackButton=YES;
    [self presentViewController:mainVC animated:YES completion:nil];
}
-(void)tapClicked:(UITapGestureRecognizer *)tap{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"isLogin"] boolValue]==YES) {
        [[AlertControllerMaker new] showImagePickerSourceTypeSelectionOverViewController:[self navigationController] allowEditing:YES completionHandler:^(UIImage *image) {
            self.headerImgView.image=image;
            [UIImagePNGRepresentation(image) writeToFile:self.imagePaths atomically:YES];
        }];
    }else{
        [self clickedLoginButton];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    NSDictionary *personInfo= [defaults objectForKey:@"personInfo"];
    for (UIView *view in [[cell contentView] subviews]) {
        [view removeFromSuperview];
    }
    if (indexPath.row!=3) {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.row) {
        case 0:
        {
            UILabel *titleLB=[[UILabel alloc] initWithFrame:CGRectMake(20, 15, 120, 18)];
            titleLB.text=@"昵称";
            titleLB.textColor=[UIColor lightGrayColor];
            [[cell contentView] addSubview:titleLB];
            UILabel *contentLB=[[UILabel alloc] initWithFrame:CGRectMake(20, 45, MainScreenW-40, 20)];
            contentLB.text=[personInfo objectForKey:@"nickName"];
            contentLB.textColor=[UIColor lightGrayColor];
            [[cell contentView] addSubview:contentLB];
        }
            break;
        case 1:
        {
            UILabel *titleLB=[[UILabel alloc] initWithFrame:CGRectMake(20, 15, 120, 18)];
            titleLB.text=@"城市";
            titleLB.textColor=[UIColor lightGrayColor];
            [[cell contentView] addSubview:titleLB];
            UILabel *contentLB=[[UILabel alloc] initWithFrame:CGRectMake(20, 45, MainScreenW-40, 20)];
            contentLB.text=[personInfo objectForKey:@"city"];
            contentLB.textColor=[UIColor lightGrayColor];
            [[cell contentView] addSubview:contentLB];
        }
            break;
        case 2:
        {
            UILabel *titleLB=[[UILabel alloc] initWithFrame:CGRectMake(20, 15, 120, 18)];
            titleLB.text=@"邮箱";
            titleLB.textColor=[UIColor lightGrayColor];
            [[cell contentView] addSubview:titleLB];
            UILabel *contentLB=[[UILabel alloc] initWithFrame:CGRectMake(20, 45, MainScreenW-40, 20)];
            contentLB.text=[personInfo objectForKey:@"email"];
            contentLB.textColor=[UIColor lightGrayColor];
            [[cell contentView] addSubview:contentLB];
        }
            break;
        case 3:
        {
            UILabel *titleLB1=[[UILabel alloc] initWithFrame:CGRectMake(20, 25, 120, 18)];
            titleLB1.text=@"显示照片";
            titleLB1.textColor=[UIColor lightGrayColor];
            [[cell contentView] addSubview:titleLB1];
            UISwitch *switch1=[[UISwitch alloc] initWithFrame:CGRectMake(MainScreenW-60, 20, 40, 20)];
            switch1.onTintColor=[UIColor redColor];
            [switch1 setOn:YES];
            [[cell contentView] addSubview:switch1];
            UILabel *titleLB2=[[UILabel alloc] initWithFrame:CGRectMake(20, 80, 120, 18)];
            titleLB2.text=@"显示旅行";
            titleLB2.textColor=[UIColor lightGrayColor];
            [[cell contentView] addSubview:titleLB2];
            UISwitch *switch2=[[UISwitch alloc] initWithFrame:CGRectMake(MainScreenW-60, 75, 40, 20)];
            switch2.onTintColor=[UIColor redColor];
            [switch2 setOn:YES];
            [[cell contentView] addSubview:switch2];
        }
            break;
        case 4:{
            UILabel *titleLB=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 20)];
            titleLB.text=@"关于";
            titleLB.textColor=[UIColor lightGrayColor];
            [cell.contentView addSubview:titleLB];
        }
        default:
            break;
    }
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    NSDictionary *personInfo= [defaults objectForKey:@"personInfo"];
    NSArray *titleArr=@[@"nickName",@"city",@"email"];
    MXUpdatePersonInfoVC *updateVC=[[MXUpdatePersonInfoVC alloc] init];
    updateVC.contentPlaceHolder=[personInfo objectForKey:titleArr[indexPath.row]];
    if (indexPath.row<3) {
        [self.navigationController pushViewController:updateVC animated:YES];
    }else{
        MXAboutViewController *aboutVC=[[MXAboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    switch (indexPath.row) {
        case 0:
            updateVC.navigationItemTitle=@"昵称";
            updateVC.fieldStr=@"nickName";
            break;
        case 1:
            updateVC.navigationItemTitle=@"城市";
            updateVC.fieldStr=@"city";
            break;
        case 2:
            updateVC.navigationItemTitle=@"邮箱";
            updateVC.fieldStr=@"email";
            break;
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<3) {
        return 80;
    }else if (indexPath.row==4){
        return 40;
    }else{
        return 125;
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
