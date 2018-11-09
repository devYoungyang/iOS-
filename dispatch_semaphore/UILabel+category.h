//
//  UILabel+category.h
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/23.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (category)

@property (nonatomic,assign)NSInteger lineSpace;

-(void)setTextLineSpace:(NSInteger)space;
@end
