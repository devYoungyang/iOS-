//
//  GCDViewController.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/17.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    dispatch_queue_t queue =dispatch_get_global_queue(0, 0);//全局并发队列
    /**
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"--->任务一%@",[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_async(queue, ^{
        sleep(2);
         NSLog(@"--->任务二%@",[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_async(queue, ^{
        sleep(2);
         NSLog(@"--->任务三%@",[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    **/
    
    
    dispatch_barrier_async(queue, ^{
        
    });
    
    
/**
    异步函数+并发队列 实现同步操作
    异步函数+串行队列 也能实现同步操作，更简单，但是有弊端的。异步串行队列只会开辟一个新的子线程，不能充分发挥CPU多线程的优势
 */
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
