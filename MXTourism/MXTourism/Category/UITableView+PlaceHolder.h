//
//  UITableView+PlaceHolder.h
//  UITableview
//
//  Created by YY on 2018/1/12.
//  Copyright © 2018年 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (PlaceHolder)

/* 占位图 */
@property (nonatomic, strong) UIView *placeHolderView;

@end

@interface YYTableViewNoDataView : UIView


- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)img viewClick:(void(^)(void))clickBlock;

- (instancetype)initWithFrame:(CGRect)frame titleInfo:(NSString *)info viewClick:(void(^)(void))clickBlock andTitleColor:(UIColor*)color;

@end
