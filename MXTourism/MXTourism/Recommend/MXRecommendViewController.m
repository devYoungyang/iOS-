//
//  MXRecommendViewController.m
//  MXTourism
//
//  Created by Yang on 2018/9/12.
//  Copyright © 2018年 YY. All rights reserved.
//


#import "MXTravelCell.h"
@interface MXRecommendViewController ()
<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UISearchBar *searchBar;

@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,strong)UITableView *tableView;


@end

@implementation MXRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"游记";
    
    _searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(20, STATUS_AND_NAVIGATION_HEIGHT+10, MainScreenW-40, 40)];
    _searchBar.placeholder=@"搜一搜";
    _searchBar.delegate=self;
    _searchBar.searchBarStyle=UISearchBarStyleMinimal;
    [self.view addSubview:self.searchBar];
    [self netWorkRequestWithCityName:@"上海"];
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT+70, MainScreenW, MainScreenH-STATUS_TABBAR_NAVIGATION_HEIGHT-70) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MXTravelCell class] forCellReuseIdentifier:@"cellId"];
    self.tableView.placeHolderView=[[YYTableViewNoDataView alloc] initWithFrame:self.tableView.bounds titleInfo:@"暂未搜索到结果" viewClick:^{
        
    } andTitleColor:[UIColor lightGrayColor]];
}
-(void)netWorkRequestWithCityName:(NSString *)cityName{
    [SVProgressHUD showWithStatus:@"正在加载中"];
    [self.dataArr removeAllObjects];
    [YYHttpRequest GET:@"https://120.76.205.241/post/tuniu?" parameters:@{@"kw":cityName,@"apikey":@"YNabLuqFkAjMeVKL8sRjrseTM4KEKhvpdkQimIFgjAyTQ6fbT5CHU0rKyTBOLozw",@"pageToken":@"2"} HttpRequestCache:^(id responseCache) {
        
    } success:^(NSDictionary *responseObject) {
//        YANGLog(@"=========%@======",responseObject);
        [SVProgressHUD dismiss];
        NSMutableArray *arr=[NSMutableArray array];
        arr=[responseObject objectForKey:@"data"];
        for (NSDictionary *dict in arr) {
            if ([dict objectForKey:@"imageUrls"]!=[NSNull null]) {
                [self.dataArr addObject:dict];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请检查当前网络"];
    }];
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if (searchBar.text.length!=0) {
        [self netWorkRequestWithCityName:searchBar.text];
    }
    [self.searchBar resignFirstResponder];// 放弃第一响应者
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];// 放弃第一响应者
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MXTravelCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.imageUrls=[self.dataArr[indexPath.section] objectForKey:@"imageUrls"];
    cell.layer.cornerRadius=10;
    cell.layer.masksToBounds=YES;
    cell.backgroundColor=[UIColor whiteColor];
    cell.userInteractionEnabled=YES;
    cell.nav=self.navigationController;
    cell.sourceDict=self.dataArr[indexPath.section];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, 40)];
    UILabel *titleLB=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, MainScreenW-40, 25)];
    titleLB.text=[self.dataArr[section] objectForKey:@"title"];
    [headerView addSubview:titleLB];
    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
