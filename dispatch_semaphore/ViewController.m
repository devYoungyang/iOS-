//
//  ViewController.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/9/13.
//  Copyright © 2018年 Yang. All rights reserved.
//

//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define kiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define KIsiPhoneX ((int)((SCREEN_HEIGHTL/SCREEN_WIDTHL)*100) == 216)?YES:NO
//判断是否为 iPhoneXS  Max，iPhoneXS，iPhoneXR，iPhoneX
#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)dispatch_semaphore_t semaphore;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (IS_IPHONE_X) {
        NSLog(@"-----iPHone X-----");
    }
    self.view.backgroundColor=[UIColor orangeColor];
    /**
    self.semaphore=dispatch_semaphore_create(0);
    [self requestWithData];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);//阻塞主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUpUI];
        });
    });
    */
    dispatch_queue_t queue=dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        dispatch_async(queue, ^{
            [self requestWithData];
        });
    });
    dispatch_group_async(group, queue, ^{
        dispatch_async(queue, ^{
            sleep(2);//模拟网络请求延迟
            NSLog(@"--请求到数据--222222");
        });
    });
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    [self setUpUI];
    dispatch_group_notify(group,queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUpUI];
        });
    });
}
-(void)requestWithData{
    
//    dispatch_async(dispatch_get_main_queue(), ^{
        sleep(3);//模拟网络请求延迟
        NSLog(@"--请求到数据--111111");
//        dispatch_semaphore_signal(self.semaphore);
//    });
}
-(void)setUpUI{
    UIView *redView=[[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    redView.layer.cornerRadius=100;
    redView.layer.masksToBounds=YES;
    redView.backgroundColor=[UIColor redColor];
    [self.view addSubview:redView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
