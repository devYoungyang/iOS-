//
//  BlockViewController(ARC).m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/17.
//  Copyright © 2018年 Yang. All rights reserved.
//
#import "UIButton+category.h"
typedef void (^GlobalBlock)(void);
#import "BlockViewController(ARC).h"

@interface BlockViewController_ARC_ ()

@end

@implementation BlockViewController_ARC_

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    __block int a=10;
//    int *p=&a;
//    GlobalBlock block=^{
////        *p=20;
//        a=30;
//        NSLog(@"====%i====",a);
//    };
//    NSLog(@">>>>>>%i<<<<<",a);
//    block();
//    NSLog(@"-----%i------",a);
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"click" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
//    button.frame=CGRectMake(100, 100, 80, 80);
    [button addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
//    [button addAction:^(UIButton *button) {
//        NSLog(@"----点击了按钮----");
//    }];
//    [self.view addSubview:button];
    [self setHideNavigationBar:YES];
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize=CGSizeMake(0, 2000);
    scrollView.userInteractionEnabled=YES;
    scrollView.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:scrollView];
    
    /**
//    NSTimer *timer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(show) userInfo:nil repeats:YES];//
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(show) userInfo:nil repeats:YES];//自动加入RunLoop
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
     **/
}

-(void)show{
//    NSLog(@"=====+++++++++++++++++++++++========");
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
