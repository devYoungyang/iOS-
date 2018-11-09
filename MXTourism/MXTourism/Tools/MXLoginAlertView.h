//
//  MXLoginAlertView.h
//  MXTourism
//
//  Created by Yang on 2018/9/12.
//  Copyright © 2018年 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXLoginAlertView : UIView


-(instancetype)initWithTitle:(NSString *)title iconImgs:(NSArray *)icons buttonTitle:(NSString *)buttonTitle placeHolders:(NSArray *)placeHolders;

-(void)show;

-(void)hide;

@end
