//
//  NextViewController.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/19.
//  Copyright © 2018年 Yang. All rights reserved.
//
#import <objc/runtime.h>
#import "CommonTools.h"
#import "Person.h"
#import "NSObject+swizzled.h"
#import "ChildViewController.h"
#import "NSString+category.h"
#import "NextViewController.h"
#import "UIView+DSL.h"
//#import "UILabel+category.h"
@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"导航栏";
    UIView *redView=UIView.new
    .DSL_frame(CGRectMake(100, 100, 200, 400))
    .DSL_backgroundColor([UIColor redColor]);
    [self.view addSubview:redView];
    self.backGroundImageName=@"2";
    __weak typeof(self) WeakSelf=self;
    [self setNavigationBarTitle:@"导航栏导航栏" leftNavigationItemTitle:@"左边" leftNavigationItemImage:@"" andClickedLeftNavigationItemCallBack:^{
        NSLog(@"---点击了左边按钮---");
        [WeakSelf.navigationController pushViewController:[ChildViewController new] animated:YES];
    } rightNavigationItemTitle:@"右边" rightNavigationItemImage:@"" andClickedNavigationItemCallBack:^{
        NSLog(@"---点击了右边按钮---");
        [WeakSelf.navigationController pushViewController:[ChildViewController new] animated:YES];
    }];
    self.hideNavigationBarUnderLine=YES;
    [self setBackButtonWithDefaultImage];
    
    /**
    Person *p=[[Person alloc] init];
    p.age=22;
    p.name=@"TOM";
    p.sex=YES;
    p.height=178.0;
    unsigned int count;
    Ivar *varList=class_copyIvarList([Person class], &count);
    for (int i = 0; i<count; i++) {
       const char *name= ivar_getName(varList[i]);
        NSLog(@"---%s----",name);
    }
    free(varList);
    
    Ivar ivar =class_getInstanceVariable([p class], "weight");
    NSString*value= object_getIvar(p, ivar);
    NSLog(@"-----%@----",value);
    NSLog(@"=====%zd====",class_getInstanceSize([Person class]));
    */
    
}
-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"AAAA-视图即将消失");
}

-(void)viewWillLayoutSubviews{
    NSLog(@"AAAA-视图即将重新布局");
}
-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"AAAA-视图已经消失");
}
-(void)viewWillAppear:(BOOL)animated{
    [self setLeftAndRightNavigationItemTitleColor:[UIColor redColor]];
    [self setNavigationBarWithColor:[UIColor orangeColor]];
    [self setNavigationItemTitleColor:[UIColor whiteColor]];
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
