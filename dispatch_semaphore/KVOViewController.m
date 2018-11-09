//
//  KVOViewController.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/29.
//  Copyright © 2018年 Yang. All rights reserved.
//
#import "Person.h"
#import "KVOViewController.h"

@interface KVOViewController ()

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    Person *p1=[[Person alloc] init];
    p1.age=11;
    p1.name=@"Tom";
    Person *p2=[[Person alloc] init];
    p1.age=22;
    p2.name=@"Apple";
    NSLog(@"添加KVO监听之前 - p1 = %p, p2 = %p", [p1 methodForSelector: @selector(setAge:)],[p2 methodForSelector: @selector(setAge:)]);
    [p1 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    NSLog(@"添加KVO监听之后 - p1 = %p, p2 = %p", [p1 methodForSelector: @selector(setAge:)],[p2 methodForSelector: @selector(setAge:)]);
    p1.age=20;
    [p1 removeObserver:self forKeyPath:@"age"];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"age"]) {
        NSLog(@"===%@==",change);
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
