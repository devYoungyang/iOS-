//
//  MXBannerCell.m
//  MXTourism
//
//  Created by Yang on 2018/9/14.
//  Copyright © 2018年 YY. All rights reserved.
//

#import "MXBannerCell.h"

@implementation MXBannerCell


- (void)createUI{
    self.layer.cornerRadius=10;
    self.layer.masksToBounds=YES;
    self.bgImageView=[[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.bgImageView];
    
    self.locationLB=[[UILabel alloc] initWithFrame:CGRectMake(20, self.height-100, self.width-40, 20)];
    [self.bgImageView addSubview:self.locationLB];
    self.locationLB.textColor=[UIColor whiteColor];
    
    self.detailLB=[[UILabel alloc] initWithFrame:CGRectMake(20, self.height-70, self.width-40, 50)];
    [self.bgImageView addSubview:self.detailLB];
    self.detailLB.textColor=[UIColor whiteColor];
    self.detailLB.numberOfLines=0;
}

@end
