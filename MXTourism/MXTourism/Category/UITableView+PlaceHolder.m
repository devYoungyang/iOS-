//
//  UITableView+PlaceHolder.m
//  UITableview
//
//  Created by YY on 2018/1/12.
//  Copyright © 2018年 YY. All rights reserved.
//
#import <objc/runtime.h>
#import "UITableView+PlaceHolder.h"


@implementation NSObject (swizzle)

+ (void)swizzleInstanceSelector:(SEL)originalSel
           WithSwizzledSelector:(SEL)swizzledSel {
    
    Method originMethod = class_getInstanceMethod(self, originalSel);
    Method swizzedMehtod = class_getInstanceMethod(self, swizzledSel);
    BOOL methodAdded = class_addMethod(self, originalSel, method_getImplementation(swizzedMehtod), method_getTypeEncoding(swizzedMehtod));
    
    if (methodAdded) {
        class_replaceMethod(self, swizzledSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzedMehtod);
    }
}
+(void)swizzleClassSelector:(SEL)originalSel WithSwizzledSelector:(SEL)swizzledSel{
    Method originMethod = class_getClassMethod([self class], originalSel);
    Method swizzedMehtod = class_getInstanceMethod([self class], swizzledSel);
    BOOL methodAdded = class_addMethod(self, originalSel, method_getImplementation(swizzedMehtod), method_getTypeEncoding(swizzedMehtod));
    
    if (methodAdded) {
        class_replaceMethod(self, swizzledSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzedMehtod);
    }
}
@end
@implementation UITableView (PlaceHolder)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceSelector:@selector(reloadData) WithSwizzledSelector:@selector(yy_reloadData)];
    });
    
}
- (void)setPlaceHolderView:(UIView *)placeHolderView {
    objc_setAssociatedObject(self, @selector(placeHolderView), placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)placeHolderView {
    return objc_getAssociatedObject(self, @selector(placeHolderView));
}

- (void)yy_reloadData {
    [self yy_checkEmpty];
    [self yy_reloadData];
}


- (void)yy_checkEmpty {
    BOOL isEmpty = YES;
    id<UITableViewDataSource> src = self.dataSource;
    NSInteger sections = 1;
    if ([src respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [src numberOfSectionsInTableView:self];
    }
    for (int i = 0; i < sections; i++) {
        NSInteger rows = [src tableView:self numberOfRowsInSection:i];
        if (rows) {
            isEmpty = NO;
        }
    }
    if (isEmpty) {
        [self.placeHolderView removeFromSuperview];
        [self addSubview:self.placeHolderView];
    }else{
        [self.placeHolderView removeFromSuperview];
    }
    
}
@end





@interface YYTableViewNoDataView ()

@property (nonatomic, copy) void(^clickBlock)(void);
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImage *img;
@end


@implementation YYTableViewNoDataView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)img viewClick:(void(^)(void))clickBlock {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.clickBlock = clickBlock;
        self.img = img;
        [self setupSubViews];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setupSubViews {
    UIImageView *imgView = [[UIImageView alloc] initWithImage:self.img];
    
    [self addSubview:imgView];
    self.imgView = imgView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImgView:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.imgView.center = CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame)/2.0);
}

- (void)clickImgView:(UITapGestureRecognizer *)recognizer {
    self.clickBlock();
}

-(instancetype)initWithFrame:(CGRect)frame titleInfo:(NSString *)info viewClick:(void (^)(void))clickBlock andTitleColor:(UIColor*)color{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.clickBlock = clickBlock;
        self.clipsToBounds = YES;
        CGSize size=[info boundingRectWithSize:CGSizeMake(self.frame.size.width-40, self.frame.size.height-40) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
        UILabel *label=[UILabel new];
        label.frame=CGRectMake(0, 0, size.width+20, size.height+20);
        label.center=CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame)/2.0-30);
        label.textAlignment=NSTextAlignmentCenter;
        label.text=info;
        label.textColor=color;
        label.numberOfLines=0;
        label.font=[UIFont systemFontOfSize:12];
        [self addSubview:label];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImgView:)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}
@end
