//
//  UILabel+category.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/23.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "UILabel+category.h"
#import <objc/runtime.h>
static void * lineSpaceKey =@"lineSpaceKey";
@implementation UILabel (category)

-(NSInteger)lineSpace{
   return [objc_getAssociatedObject(self, lineSpaceKey) integerValue];
}
-(void)setLineSpace:(NSInteger)lineSpace{
    [self setTextLineSpace:lineSpace];
    objc_setAssociatedObject(self, lineSpaceKey, @(lineSpace), OBJC_ASSOCIATION_ASSIGN);
}
-(void)setTextLineSpace:(NSInteger)space{
    NSMutableAttributedString *string=[[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:space];
    [string addAttribute:NSAttachmentAttributeName value:style range:NSMakeRange(0, self.text.length)];
    [self setAttributedText:string];
}
@end
