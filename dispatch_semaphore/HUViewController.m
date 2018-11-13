//
//  HUViewController.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/11/12.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "HUViewController.h"
#define Random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define RandomColor Random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface HUViewController ()
@property (nonatomic,strong)UIView *radomColorView;
@end

@implementation HUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.radomColorView=[[UIView alloc] initWithFrame:CGRectMake(80, 100, 60, 60)];
    [self.view addSubview:self.radomColorView];
}
- (IBAction)buttonClicked:(id)sender {
    self.radomColorView.backgroundColor=RandomColor;
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
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
