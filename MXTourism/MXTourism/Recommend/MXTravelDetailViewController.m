//
//  MXTravelDetailViewController.m
//  MXTourism
//
//  Created by Yang on 2018/9/19.
//  Copyright © 2018年 YY. All rights reserved.
//
#import "NSString+Category.h"
#import "MXTravelDetailViewController.h"

@interface MXTravelDetailViewController ()

@property (nonatomic,strong)UIScrollView *contentScrollView;

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MXTravelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUpUI];
}

-(void)setUpUI{
     NSArray *imageUrls=[self.dataSources objectForKey:@"imageUrls"];
    CGFloat margin=20;
    CGFloat height=200;
    NSString *contentText=[[self.dataSources objectForKey:@"content"] stringByReplacingOccurrencesOfString:@"\n" withString:@"\r\n      "];
    CGFloat contentH=[NSString getLengthWithString:contentText andWithRangeSize:CGSizeMake(MainScreenW-40, CGFLOAT_MAX) andFont:15].height;
    CGFloat scrollViewH=contentH+height*imageUrls.count+(imageUrls.count+1)*margin;
    if (@available(iOS 11.0, *)) {
        self.contentScrollView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    UIImageView *topImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, 200)];
    topImageView.contentMode=UIViewContentModeScaleToFill;
    [topImageView sd_setImageWithURL:[NSURL URLWithString:[[self.dataSources objectForKey:@"imageUrls"] firstObject]]];
    [self.view addSubview:topImageView];
    _contentScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, topImageView.height, MainScreenW, MainScreenH-200-TABBAR_FRAME)];
    _contentScrollView.contentSize=CGSizeMake(MainScreenW-40, scrollViewH+60);
    [self.view addSubview:self.contentScrollView];
    UILabel *titleLB=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, MainScreenW-40, 20)];
    titleLB.text=[self.dataSources objectForKey:@"title"];
    [self.contentScrollView addSubview:titleLB];
    UILabel *contentLB=[[UILabel alloc] initWithFrame:CGRectMake(20, 50, MainScreenW-40, contentH+5)];
    contentLB.text=[NSString stringWithFormat:@"        %@",contentText];
    contentLB.numberOfLines=0;
    contentLB.font=[UIFont systemFontOfSize:15];
    [self.contentScrollView addSubview:contentLB];
    for (NSInteger i=0 ; i<imageUrls.count; i++) {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, contentH+60+(margin+height)*i, MainScreenW-40, height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrls[i]]];
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        [self.contentScrollView addSubview:imageView];
        imageView.layer.cornerRadius=10;
        imageView.layer.masksToBounds=YES;
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
