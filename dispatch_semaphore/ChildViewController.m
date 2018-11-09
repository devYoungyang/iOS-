//
//  ChildViewController.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/19.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "ChildViewController.h"

@interface ChildViewController ()

@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
//    __weak typeof(self) WeakSelf=self;
    [self setNavigationBarTitle:@"导航栏导航栏" leftNavigationItemTitle:@"  " leftNavigationItemImage:@"" andClickedLeftNavigationItemCallBack:^{
        NSLog(@"---点击了左边按钮---");
        
    } rightNavigationItemTitle:@"右边1" rightNavigationItemImage:@"" andClickedNavigationItemCallBack:^{
        NSLog(@"---点击了右边按钮---");
    }];
    
//    self.hideNavigationBar=YES;
//    NSArray *arr=@[@"1",@"2",@"3",@"4",@"5",@"6"];
//    NSLog(@"---%@----",[arr objectAtIndex:8]);
    NSLog(@"BBBB-视图已经加载");
//    self.navigationController.navigationBar.translucent=YES;
//    self.navigationController.edgesForExtendedLayout=UIRectEdgeAll;//默认
}
-(void)viewWillAppear:(BOOL)animated{
    [self setLeftAndRightNavigationItemTitleColor:[UIColor cyanColor]];
    [self setNavigationBarWithColor:[UIColor purpleColor]];
    [self setNavigationItemTitleColor:[UIColor greenColor]];
    NSLog(@"BBBB-视图即将显示");
}
-(void)viewWillLayoutSubviews{
    NSLog(@"BBBB-视图即将重新布局");
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"BBBB-视图已经显示");
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController popViewControllerAnimated:YES];
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
