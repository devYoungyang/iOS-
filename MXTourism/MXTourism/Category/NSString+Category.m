//
//  NSString+Category.m
//  MXTourism
//
//  Created by Yang on 2018/9/17.
//  Copyright © 2018年 YY. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

+(CGSize)getLengthWithString:(NSString *)str andWithRangeSize:(CGSize) rangeSize andFont:(NSInteger) font{
    CGSize size=[str boundingRectWithSize:rangeSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:font]} context:nil].size;
    return size;
}

@end
