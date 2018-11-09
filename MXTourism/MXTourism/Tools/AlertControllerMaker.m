//
//  ImagePickerControllerMaker.m
//  Multi_Targets_Project
//
//  Created by yosemite on 15/10/30.
//  Copyright © 2015年 yosemite. All rights reserved.
//

#import "AlertControllerMaker.h"

@interface AlertControllerMaker () <UIPopoverPresentationControllerDelegate, UIActionSheetDelegate, UIAlertViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic, nullable) UIViewController *viewController;

@property (nonatomic, strong, nullable) void (^completionHandler)(UIImage *image);

@property (nonatomic, strong, nullable) AlertControllerMaker *retainedObject;
//  继续
@property (nonatomic, strong, nullable) void (^continueHandler)(void);
//  取消
@property (nonatomic, strong, nullable) void (^cancelHandler)(void);
@end

@implementation AlertControllerMaker

- (void)showImagePickerSourceTypeSelectionOverViewController:(UIViewController *)viewController allowEditing:(BOOL)editMode completionHandler:(void (^)(UIImage *image))handler
{
    
    [self setViewController:viewController];
    [self setCompletionHandler:handler];
    typeof(self) __unsafe_unretained __block thisObject = self;
   
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *showCamera = [UIAlertAction actionWithTitle:NSLocalizedString(@"相机", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [thisObject showImagePickerWithSourceTypeCamera:editMode];
        }];
        [alertController addAction:showCamera];
        UIAlertAction *showPhotoGallery = [UIAlertAction actionWithTitle:NSLocalizedString(@"相册", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [thisObject showImagePickerWithSourceTypePhotoLibrary:editMode];
        }];
        [alertController addAction:showPhotoGallery];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [thisObject setRetainedObject:nil];
        }];
        [alertController addAction:cancel];
        UIPopoverPresentationController *poppController = [alertController popoverPresentationController];
        CGFloat viewWidth = [[viewController view] bounds].size.width, viewHeight = [[viewController view] bounds].size.height;
        [poppController setSourceView:[viewController view]];
        [poppController setSourceRect:CGRectMake(0.5 * viewWidth, viewHeight, 0, 0)];
        [poppController setPermittedArrowDirections:UIPopoverArrowDirectionDown];
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"相机", nil), NSLocalizedString(@"相册", nil), nil];
        [actionSheet setTag:0x5ac000 + editMode];
        [actionSheet showInView:[viewController view]];
    }
    [self setRetainedObject:self];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL allEditing = [actionSheet tag] - 0x5ac000;
    switch (buttonIndex)
    {
        case 0:
            [self showImagePickerWithSourceTypeCamera:allEditing];
            break;
        case 1:
            [self showImagePickerWithSourceTypePhotoLibrary:allEditing];
            break;
            
        default:
            [self setRetainedObject:nil];
            break;
    }
}

- (void)showImagePickerWithSourceTypeCamera:(BOOL)allowEditing
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setMediaTypes:@[@"public.image"]];
    [imagePicker setAllowsEditing:allowEditing];
    [imagePicker setDelegate:self];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePicker setCameraDevice:UIImagePickerControllerCameraDeviceFront];
        [[self viewController] presentViewController:imagePicker animated:YES completion:nil];
    }
    else {
        [[self class] showAlertViewOverViewController:_viewController withAlertMessage:NSLocalizedString(@"相机不可用", nil)];
        [self setRetainedObject:nil];
    }
}

- (void)showImagePickerWithSourceTypePhotoLibrary:(BOOL)allowEditing
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setMediaTypes:@[@"public.image"]];
    [imagePicker setAllowsEditing:allowEditing];
    [imagePicker setDelegate:self];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [[self viewController] presentViewController:imagePicker animated:YES completion:nil];
    }
    else {
        [[self class] showAlertViewOverViewController:_viewController withAlertMessage:NSLocalizedString(@"照片库不可用", nil)];
        [self setRetainedObject:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (!image) {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        if (image) {
            [self completionHandler](image);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self setRetainedObject:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self setRetainedObject:nil];
}

/* 
 typedef NS_ENUM(NSInteger, UIAlertActionStyle) {
 UIAlertActionStyleDefault = 0,蓝色中等字体
 UIAlertActionStyleCancel,蓝色加细字体
 UIAlertActionStyleDestructive红色字体
 } NS_ENUM_AVAILABLE_IOS(8_0);
 */
+ (void)showAlertViewOverViewController:(UIViewController *)viewController withAlertMessage:(NSString *)message {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        [alertController addAction:cancel];
        
        UIPopoverPresentationController *poppController = [alertController popoverPresentationController];
        [poppController setSourceView:[viewController view]];
        [poppController setSourceRect:[[viewController view] bounds]];
        
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil, nil];
        [alertView show];
    }
}

+ (void)showAlertViewOverViewController:(UIViewController *)viewController withAlertTitle:(NSString *)title message:(NSString *)message {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        [alertController addAction:cancel];
        
        UIPopoverPresentationController *poppController = [alertController popoverPresentationController];
        CGFloat viewWidth = [[viewController view] bounds].size.width, viewHeight = [[viewController view] bounds].size.height;
        [poppController setSourceView:[viewController view]];
        [poppController setSourceRect:CGRectMake(0.5 * viewWidth, viewHeight, 0, 0)];
        [poppController setPermittedArrowDirections:UIPopoverArrowDirectionDown];
        
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)showConfirmAlertViewOverViewController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle continueButtonTitle:(NSString *)continueTitle cancelHandler:(void(^)(void))cancelHandler continueHandler:(void (^)(void))continueHandler {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (cancelHandler) {
                cancelHandler();
            }
        }];
        [alertController addAction:cancel];
        
        UIAlertAction *doit = [UIAlertAction actionWithTitle:continueTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (continueHandler) {
                continueHandler();
            }
        }];
        [alertController addAction:doit];
        
        UIPopoverPresentationController *poppController = [alertController popoverPresentationController];
        CGFloat viewWidth = [[viewController view] bounds].size.width, viewHeight = [[viewController view] bounds].size.height;
        [poppController setSourceView:[viewController view]];
        [poppController setSourceRect:CGRectMake(0.5 * viewWidth, viewHeight, 0, 0)];
        [poppController setPermittedArrowDirections:UIPopoverArrowDirectionDown];
        
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else {
        [self setContinueHandler:continueHandler];
        [self setCancelHandler:cancelHandler];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:continueTitle, nil];
        [alertView show];
        [self setRetainedObject:self];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if (_cancelHandler) {
            _cancelHandler();
        }
    }
    else if (buttonIndex == 1) {
        if (_continueHandler) {
            _continueHandler();
        }
    }
    [self setRetainedObject:nil];
}

@end
