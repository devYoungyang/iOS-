//
//  YYAlertViewController.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/11/9.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "YYAlertViewController.h"

@interface YYAlertViewController ()

@end

@implementation YYAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self AlertWithTitle:@"HAHA" message:@"WAWA" andOthers:@[@"1",@"2",@"3"] animated:YES action:^(NSInteger index) {
//        NSLog(@"=====%li=====",index);
//    }];
//    [self ActionSheetWithTitle:@"HAHA" message:@"WAWA" destructive:@"" destructiveAction:^(NSInteger index) {
//
//    } andOthers:@[@"1",@"2",@"3"] animated:YES action:^(NSInteger index) {
//
//    }];
    [self AlertWithTitle:@"HAHA222" message:@"WAWAWA" buttons:@[@"1",@"2",@"3"] textFieldNumber:2 configuration:^(UITextField *field, NSInteger index) {
        
    } animated:YES action:^(NSArray<UITextField *> *fields, NSInteger index) {
        
    }];
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
