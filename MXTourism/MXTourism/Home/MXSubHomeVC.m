//
//  MXSubHomeVC.m
//  MXTourism
//
//  Created by Yang on 2018/9/17.
//  Copyright © 2018年 YY. All rights reserved.
//

#import "MXSubHomeVC.h"

@interface MXSubHomeVC ()

@end

@implementation MXSubHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackgroundWithImgName:self.imageUrl];
    [self setUpUI];
}
-(void)setUpUI{
    UILabel *locationLB=[[UILabel alloc] initWithFrame:CGRectMake(20, MainScreenH-TABBAR_FRAME-120, MainScreenW-40, 15)];
    locationLB.text=[self.dataSources objectForKey:@"title"];
    locationLB.textColor=[UIColor whiteColor];
    locationLB.font=[UIFont systemFontOfSize:15];
    [self.bgImgView addSubview:locationLB];
    UILabel *detailLB=[[UILabel alloc] initWithFrame:CGRectMake(20, MainScreenH-TABBAR_FRAME-100, MainScreenW-40, 40)];
    detailLB.numberOfLines=0;
    detailLB.textColor=[UIColor whiteColor];
    detailLB.font=[UIFont systemFontOfSize:15];
    detailLB.text=[self.dataSources objectForKey:@"subtitle"];
    [self.bgImgView addSubview:detailLB];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake((MainScreenW-100)/2, MainScreenH-TABBAR_FRAME-50, 100, 30);
//    [button setTitle:@"👆" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"slideUP"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImgView addSubview:button];
}

-(void)buttonClicked:(UIButton *)btn{
    MXDetailViewController *detailVC=[[MXDetailViewController alloc] init];
    detailVC.dataSources=self.dataSources;
    [self.navigationController pushViewController:detailVC animated:YES];
//    [self presentViewController:detailVC animated:YES completion:nil];
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
