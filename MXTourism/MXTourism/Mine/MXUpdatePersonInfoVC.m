//
//  MXUpdatePersonInfoVC.m
//  MXTourism
//
//  Created by Yang on 2018/9/18.
//  Copyright © 2018年 YY. All rights reserved.
//
#import "UIViewController+BackButtonHandler.h"
#import "MXUpdatePersonInfoVC.h"

@interface MXUpdatePersonInfoVC ()<BackButtonHandlerProtocol>
@property (weak, nonatomic) IBOutlet UITextField *contentTextfield;

@property (nonatomic,strong)YYSQLiteManager *manager;
@end

@implementation MXUpdatePersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title=self.navigationItemTitle;
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(clickedRightButton:)];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    self.contentTextfield.placeholder=self.contentPlaceHolder;
    self.manager=[YYSQLiteManager shareBaseDB];
    NSString *paths=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo1.db"];
    [self.manager createDB:paths];
}
-(BOOL)navigationShouldPopOnBackButton{
    UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否放弃修改" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertCon addAction:sureAction];
    UIAlertAction *cannelAction=[UIAlertAction actionWithTitle:@"继续修改" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCon addAction:cannelAction];
    [self presentViewController:alertCon animated:YES completion:nil];
    return NO;
}
-(void)clickedRightButton:(UIButton *)btn{
    
    if (self.contentTextfield.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"内容不能为空"];
    }else if ([self.contentPlaceHolder isEqualToString:self.contentTextfield.text]){
        [SVProgressHUD showErrorWithStatus:@"未做任何修改"];
    }else{
        NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
        NSDictionary *personInfo= [defaults objectForKey:@"personInfo"];
        [self.manager updateDB:[NSString stringWithFormat:@"UPDATE loginInfo SET '%@' = '%@' WHERE userName = '%@'",self.fieldStr,self.contentTextfield.text,[personInfo objectForKey:@"userName"]]];
        NSString *sqlStr=[NSString stringWithFormat:@"select * from loginInfo where userName = '%@' ",[personInfo objectForKey:@"userName"]];
        NSArray *dataArr= [self.manager selectDB:sqlStr];
        [defaults setObject:[dataArr firstObject] forKey:@"personInfo"];
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
