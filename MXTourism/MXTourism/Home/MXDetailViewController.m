//
//  MXDetailViewController.m
//  MXTourism
//
//  Created by Yang on 2018/9/17.
//  Copyright © 2018年 YY. All rights reserved.
//
#import "MXPlaceViewCell.h"
#import "NSString+Category.h"

@interface MXDetailViewController ()
<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)UIScrollView *contentScrollView;

@end

@implementation MXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self setBackgroundWithImgName:@"CountryBlur"];
    [self setUpUI];
    if (@available(iOS 11.0, *)) {
        self.contentScrollView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    } else {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
}
-(void)setUpUI{
    NSString *contentText=[[self.dataSources objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"\n" withString:@"\r\n      "];
    CGFloat descriptionHeight=ceil([NSString getLengthWithString:contentText andWithRangeSize:CGSizeMake(MainScreenW-40, CGFLOAT_MAX) andFont:15].height);
    CGFloat Height=descriptionHeight+340;
    
    self.contentScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT, MainScreenW, MainScreenH-TABBAR_FRAME-STATUS_AND_NAVIGATION_HEIGHT)];
    self.contentScrollView.contentSize=CGSizeMake(MainScreenW, Height);
    self.contentScrollView.backgroundColor=[UIColor clearColor];
    [self.bgImgView addSubview:self.contentScrollView];
    self.flowLayout=[[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.itemSize=CGSizeMake(MainScreenW/3+20, 120);
    self.flowLayout.minimumLineSpacing=20;
    self.flowLayout.minimumInteritemSpacing=10;
    self.flowLayout.sectionInset=UIEdgeInsetsMake(0, 20, 0, 20);
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, descriptionHeight+120, MainScreenW, 240) collectionViewLayout:_flowLayout];
    self.flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    self.collectionView.backgroundColor=[UIColor clearColor];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.contentScrollView addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MXPlaceViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellId"];
    UILabel *titleLB=[[UILabel alloc] init];
    [self.contentScrollView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((MainScreenW-300)/2);
        make.width.mas_equalTo(300);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    titleLB.text=[self.dataSources objectForKey:@"title"];
    titleLB.textColor=[UIColor whiteColor];
    titleLB.textAlignment=NSTextAlignmentCenter;
    UILabel *subTitle=[[UILabel alloc] init];
    [self.contentScrollView addSubview:subTitle];
    subTitle.textColor=[UIColor whiteColor];
    subTitle.numberOfLines=0;
    subTitle.textAlignment=NSTextAlignmentCenter;
    subTitle.text=[self.dataSources objectForKey:@"subtitle"];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.width.mas_equalTo(MainScreenW-80);
        make.top.mas_equalTo(titleLB.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(50);
    }];
    UILabel *descriptionLB=[[UILabel alloc] init];
    [self.contentScrollView addSubview:descriptionLB];
    descriptionLB.text=contentText;
    descriptionLB.textColor=[UIColor whiteColor];
    descriptionLB.numberOfLines=0;
    descriptionLB.font=[UIFont systemFontOfSize:15];
    [descriptionLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(MainScreenW-40);
        make.top.equalTo(subTitle.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(descriptionHeight);
    }];
    UILabel *placeLB=[[UILabel alloc] init];
    [self.contentScrollView addSubview:placeLB];
    [placeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(descriptionLB.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    placeLB.text=@"地点";
    placeLB.textColor=[UIColor whiteColor];
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[self.dataSources objectForKey:@"imageUrls"] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MXPlaceViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    NSArray *images=[self.dataSources objectForKey:@"imageUrls"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:images[indexPath.row]]];
    cell.imageView.contentMode=UIViewContentModeScaleAspectFill;
    cell.layer.cornerRadius=10;
    cell.layer.masksToBounds=YES;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSArray *images=[self.dataSources objectForKey:@"imageUrls"];
    NSMutableArray *modelArr=[NSMutableArray array];
    for (NSString *imageUrlStr in images) {
        YBImageBrowserModel *model=[[YBImageBrowserModel alloc] init];
        [model setUrl:[NSURL URLWithString:imageUrlStr]];
        [modelArr addObject:model];
    }
    YBImageBrowser *brower=[[YBImageBrowser alloc] init];
    brower.dataArray=modelArr;
    brower.currentIndex=indexPath.row;
    [brower show];
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
