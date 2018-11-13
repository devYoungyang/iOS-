//
//  RetainCountViewController.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/11/12.
//  Copyright © 2018年 Yang. All rights reserved.
//
#import "Person.h"
#import "RetainCountViewController.h"

@interface RetainCountViewController ()

@property (nonatomic,strong)NSString *str1;

@property (nonatomic,strong)NSString *str2;

@property (nonatomic,retain)NSString *str3;

@property (nonatomic,copy)NSString *str4;

@property (nonatomic,strong)Person *p1;

@end

@implementation RetainCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    /*
    NSLog(@"----1   str1=%p str2=%p str3=%p str4=%p p1=%p",self.str1,self.str2,self.str3,self.str4,self.p1);
    NSLog(@"----2   str1RetainCount=%li str2RetainCount=%li str3RetainCount=%li str4RetainCount=%li P1RetainCount=%li",[self.str1 retainCount],[self.str2 retainCount],[self.str3 retainCount],[self.str4 retainCount],[self.p1 retainCount]);
//    NSString *tempStr=[NSString stringWithFormat:@"Hello World !"];
    NSString *tempStr=@"Hello World !";
    NSLog(@"----3   tempStr=%p retainCount=%li",tempStr,[tempStr retainCount]);
    self.str1=tempStr;
    NSLog(@"----4   str1RetainCount=%li",[self.str1 retainCount]);
    self.str2 = self.str1;
    NSLog(@"----5   str2RetainCount=%li",[self.str2 retainCount]);
    self.str1 = nil;
    NSLog(@"---6    str1=%@,str2=%@",self.str1,self.str2);
    NSLog(@"----7   str1--->%p,str2--->%p",self.str1,self.str2);
    NSLog(@"----8   str1RetainCount=%li str2RetainCount=%li",[self.str1 retainCount],[self.str2 retainCount]);
    int a=10;
    Person *p1=[[Person alloc] init];
    p1.age=22;
    p1.height=179;
    p1.name=@"TOM";
    NSLog(@"--%i--",a);
    **/
    /**
    NSString* str5=[NSString stringWithFormat:@"HAHA中国333"];
//    self.str2=str5;
    self.str2=[NSString stringWithFormat:@"二十年代"];
    NSLog(@"==%p == %li  == %li ",str5,[str5 retainCount],[self.str2 retainCount]);
    */
    /**
    NSMutableArray *ary = [[NSMutableArray array] retain];
    NSString *str = [NSString stringWithFormat:@"123456789"];
    NSString *longStr = [NSString stringWithFormat:@"1234567890"];
    
    [str retain];
    [longStr retain];
    [ary addObject:str];
    [ary addObject:longStr];
    
    NSLog(@"str = %ld", (unsigned long)[str retainCount]);
    NSLog(@"longStr = %ld", (unsigned long)[longStr retainCount]);
    
    [str retain];
    [str release];
    [str release];
    [longStr retain];
    [longStr release];
    [longStr release];
    
    NSLog(@"str = %ld", (unsigned long)[str retainCount]);
    NSLog(@"longStr = %ld", (unsigned long)[longStr retainCount]);
    [ary removeAllObjects];
    NSLog(@"str = %ld", (unsigned long)[str retainCount]);
    NSLog(@"longStr = %ld", (unsigned long)[longStr retainCount]);
     **/

    UIView *subview=[[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    subview.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:subview];
   
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
