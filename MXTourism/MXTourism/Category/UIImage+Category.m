

#import "UIImage+Category.h"
#import <UIImage+GIF.h>

@implementation UIImage (Category)

/** 获取纯色图片 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
// 圆形图片
+ (UIImage *)getCircleImageWithImageName:(NSString *)imageName size:(CGSize)size {
    
    UIImage *oldImage = [UIImage imageNamed:imageName];
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);// 开启图形上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();// 获取上下文
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);// 设置圆形
    CGContextAddEllipseInRect(ctr, rect);
    
    CGContextClip(ctr);// 裁剪
    [oldImage drawInRect:rect];// 将图片画上去
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();// 获取新的图片
    UIGraphicsEndImageContext();// 关闭图形上下文
    return newImage;
}
//图片剪切
+ (UIImage*)cutImage:(UIImage *)orImage withRadius:(int)radius {
    UIGraphicsBeginImageContext(orImage.size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    float x1 = 0.;
    float y1 = 0.;
    float x2 = x1+orImage.size.width;
    float y2 = y1;
    float x3 = x2;
    float y3 = y1+orImage.size.height;
    float x4 = x1;
    float y4 = y3;
    
    CGContextMoveToPoint(gc, x1, y1+radius);
    CGContextAddArcToPoint(gc, x1, y1, x1+radius, y1, radius);
    CGContextAddArcToPoint(gc, x2, y2, x2, y2+radius, radius);
    CGContextAddArcToPoint(gc, x3, y3, x3-radius, y3, radius);
    CGContextAddArcToPoint(gc, x4, y4, x4, y4-radius, radius);
    
    
    CGContextClosePath(gc);
    CGContextClip(gc);
    
    CGContextTranslateCTM(gc, 0, orImage.size.height);
    CGContextScaleCTM(gc, 1, -1);
    CGContextDrawImage(gc, CGRectMake(0, 0, orImage.size.width, orImage.size.height), orImage.CGImage);
    
    
    
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimage;
}

// 任意圆角图片
+ (UIImage *)imageWithImageName:(NSString *)imageName size:(CGSize)size radius:(CGFloat)radius {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIImage *oldImage = [UIImage imageNamed:imageName];
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    [oldImage drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 *  自由拉伸一张图片
 *
 *  @param name 图片名字
 *  @param left 左边开始位置比例  值范围0-1
 *  @param top  上边开始位置比例  值范围0-1
 *
 *  @return 拉伸后的Image
 */
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}


/**
 *  根据图片和颜色返回一张加深颜色以后的图片
 */
+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor {
    
    UIGraphicsBeginImageContext(CGSizeMake(baseImage.size.width*2, baseImage.size.height*2));
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, baseImage.size.width * 2, baseImage.size.height * 2);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, baseImage.CGImage);
    
    [theColor set];
    CGContextFillRect(ctx, area);
    
    CGContextRestoreGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextDrawImage(ctx, area, baseImage.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  自由改变Image的大小
 *
 *  @param size 目的大小
 *
 *  @return 修改后的Image
 */
- (UIImage *)turnImageWithSize:(CGSize)size {
    
    float scale = self.size.width/self.size.height;
    CGRect rect = CGRectMake(0, 0, 0, 0);
    
    if (scale > size.width/size.height) {
        
        rect.origin.x = (self.size.width - self.size.height * size.width/size.height)/2;
        rect.size.width  = self.size.height * size.width/size.height;
        rect.size.height = self.size.height;
        
    }else {
        
        rect.origin.y = (self.size.height - self.size.width/size.width * size.height)/2;
        rect.size.width  = self.size.width;
        rect.size.height = self.size.width/size.width * size.height;
        
    }
    
    CGImageRef imageRef   = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

- (UIImage *)getImageFromUrl: (NSString *)url{
    UIImage *image = nil;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    image = [UIImage imageWithData:data];
    if (image == nil) {
        image = [UIImage imageNamed:@"bannerPlace"];
    }
    return image;
}

+ (UIImage *)getImageFromUrl: (NSString *)url{
    UIImage *image = nil;
    if ([url containsString:@"gif"]) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        image = [UIImage sd_animatedGIFWithData:data];
    }else{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        image = [UIImage imageWithData:data];
        if (image == nil) {
            image = [UIImage imageNamed:@"bannerPlace"];
        }
    }
    return image;
}

- (UIImage *)resizeImage:(CGFloat)width{
//    if (self.size.width < width) {
//        return self;
//    }
    CGFloat height = width * self.size.height / self.size.width;
    
    if (height <= 0 || width <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)barrageImageScaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
@end
