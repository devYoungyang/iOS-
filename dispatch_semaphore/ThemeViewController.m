//
//  ThemeViewController.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/18.
//  Copyright © 2018年 Yang. All rights reserved.
//
#import "Person.h"

#import "ThemeViewController.h"

@interface ThemeViewController ()
{
    NSString *path;
}
@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Person *p=[[Person alloc] init];
    p.name=@"TOM";
    p.age=22;
    p.sex=YES;
    p.height=178.5;
    path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"info.plist"];
    NSError *error=nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"error=%@",error.description);
        } else {
            NSLog(@"文件夹创建成功");
        }
    }
    if ([NSKeyedArchiver archiveRootObject:p toFile:path]) {
        NSLog(@"归档成功");
    }else{
        NSLog(@"归档失败");
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"---%@---",path);
    Person *p=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"===%@===",p);
    
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
