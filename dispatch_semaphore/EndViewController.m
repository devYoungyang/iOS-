//
//  EndViewController.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/18.
//  Copyright © 2018年 Yang. All rights reserved.
//
#import "UIImage+Color.h"
#import "EndViewController.h"
#import "UINavigationBar+ChangeColor.h"
@interface EndViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation EndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"我是导航栏";
//    self.edgesForExtendedLayout=UIRectEdgeNone;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBgColor:[UIColor clearColor]];
    self.navigationController.navigationBar.hideNavigationBarUnderLine=YES;
    [self setStatusBarColor:[UIColor cyanColor]];
    self.view.backgroundColor=[UIColor redColor];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
//        self.automaticallyAdjustsScrollViewInsets=YES;
    }
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.tableView.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    UIView *bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130)];
    bannerView.backgroundColor = [UIColor grayColor];
    self.tableView.tableHeaderView = bannerView;
    [GCDHelper gcdAsyncWithConcurrentCallBack:^{
        NSLog(@"异步并发队列");
    } andBackMainQueue:^{
        NSLog(@"回到主线程刷新UI");
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellId"];
    UITextField*textField=[[UITextField alloc] initWithFrame:CGRectMake(20, 40, self.view.frame.size.width-40, 30)];
    textField.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [[cell contentView] addSubview:textField];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
