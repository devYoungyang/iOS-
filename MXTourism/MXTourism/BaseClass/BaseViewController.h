//
//  BaseViewController.h
//  MXTourism
//
//  Created by Yang on 2018/9/12.
//  Copyright © 2018年 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic,strong)NSDictionary *dataSources;

@property (nonatomic,strong)UIImageView *bgImgView;

-(void)setBackgroundWithImgName:(NSString*)imageName;

-(void)setBackButtonTitle:(NSString *)title andImage:(NSString *)imageName;

-(void)setBackButton; //这种方法在父控制器中设置好使

@end
