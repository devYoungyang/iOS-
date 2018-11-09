//
//  MXUpdatePersonInfoVC.m
//  MXTourism
//
//  Created by Yang on 2018/9/18.
//  Copyright © 2018年 YY. All rights reserved.
//

#import "MXUpdatePersonInfoVC.h"

@interface MXUpdatePersonInfoVC ()
@property (weak, nonatomic) IBOutlet UITextField *contentTextfield;

@end

@implementation MXUpdatePersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title=@"";
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
