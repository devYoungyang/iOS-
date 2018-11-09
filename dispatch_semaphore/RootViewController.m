//
//  RootViewController.m
//  dispatch_semaphore

//  Created by Yang on 2018/10/12.
//  Copyright © 2018年 Yang. All rights reserved.
//
#import "UIButton+category.h"
#import "MainViewController.h"
#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIResponder
//    UIApplication
//    UIWindow
//    UIView *redView=[[UIView alloc] initWithFrame:CGRectMake(120, 160, 80, 80)];
//    redView.layer.cornerRadius=40;
//    redView.backgroundColor=[UIColor redColor];
//    [self.view addSubview:redView];
    
    
    dispatch_semaphore_t semapore =dispatch_semaphore_create(0);
    dispatch_async(dispatch_queue_create("2121dsd", DISPATCH_QUEUE_CONCURRENT), ^{
        sleep(5);
        NSLog(@"----网络请求完成-----");
        dispatch_semaphore_signal(semapore);
    });
    dispatch_semaphore_wait(semapore, DISPATCH_TIME_FOREVER);
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"click" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor orangeColor]];
        button.frame=CGRectMake(100, 100, 80, 80);
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"=====%@=====",touches);
}
-(void)btnClicked:(UIButton *)btn{
     NSLog(@"----点击了-----");
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
