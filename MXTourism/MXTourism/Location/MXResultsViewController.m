//
//  MXResultsViewController.m
//  MXTourism
//
//  Created by Yang on 2018/9/18.
//  Copyright © 2018年 YY. All rights reserved.
//

#import "MXFeaturedSpotsCell.h"
#import "MXResultsViewController.h"

@interface MXResultsViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MXResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self createTopView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [YYHttpRequest GET:@"https://120.76.205.241/sight/tuniu" parameters:@{@"kw":self.cityName,@"apikey":@"YNabLuqFkAjMeVKL8sRjrseTM4KEKhvpdkQimIFgjAyTQ6fbT5CHU0rKyTBOLozw"} HttpRequestCache:^(id responseCache) {
        self.dataArr=[responseCache objectForKey:@"data"];
        [self.tableView reloadData];
    } success:^(NSDictionary *responseObject) {
        self.dataArr=[responseObject objectForKey:@"data"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)createTopView{
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, 200)];
    imageView.image=[UIImage imageNamed:@"Photo"];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 200, MainScreenW, MainScreenH-200-TABBAR_FRAME) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MXFeaturedSpotsCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, 30)];
    UILabel *titleLB=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, MainScreenW-40, 30)];
    titleLB.text=@"特色景点";
    [headerView addSubview:titleLB];
    self.tableView.tableHeaderView=headerView;
    YYTableViewNoDataView *nodataView=[[YYTableViewNoDataView alloc] initWithFrame:self.tableView.bounds titleInfo:@"暂未搜索到结果" viewClick:^{
        
    } andTitleColor:[UIColor grayColor]];
    self.tableView.placeHolderView=nodataView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MXFeaturedSpotsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (![[self.dataArr[indexPath.row]objectForKey:@"imageUrls"]firstObject]) {
        cell.leftImgView.image=[UIImage imageNamed:@"mosike"];
    }else{
        [cell.leftImgView sd_setImageWithURL:[NSURL URLWithString:[[self.dataArr[indexPath.row]objectForKey:@"imageUrls"]firstObject]]];
    }
    cell.leftImgView.contentMode=UIViewContentModeScaleAspectFill;
    cell.leftImgView.layer.cornerRadius=10;
    cell.leftImgView.layer.masksToBounds=YES;
    cell.descriptionLB.text=[self.dataArr[indexPath.row] objectForKey:@"title"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MXDetailViewController *detailVC=[[MXDetailViewController alloc] init];
    detailVC.dataSources=self.dataArr[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
