//
//  ImagePickerControllerMaker.h
//  Multi_Targets_Project
//
//  Created by yosemite on 15/10/30.
//  Copyright © 2015年 yosemite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertControllerMaker : NSObject

- (void)showImagePickerSourceTypeSelectionOverViewController:(UIViewController *)viewController allowEditing:(BOOL)editMode completionHandler:(void (^)(UIImage *image))handler;

+ (void)showAlertViewOverViewController:(UIViewController *)viewController withAlertMessage:(NSString *)message;

+ (void)showAlertViewOverViewController:(UIViewController *)viewController withAlertTitle:(NSString *)title message:(NSString *)message;

- (void)showConfirmAlertViewOverViewController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle continueButtonTitle:(NSString *)continueTitle cancelHandler:(void(^)(void))cancelHandler continueHandler:(void (^)(void))continueHandler;
@end
