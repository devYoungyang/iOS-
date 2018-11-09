//
//  MXLocationViewController.m
//  MXTourism
//
//  Created by Yang on 2018/9/12.
//  Copyright © 2018年 YY. All rights reserved.
//

#import "MXAttractionCell.h"
@interface MXLocationViewController ()
<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,strong)UISearchBar*searchBar;
@end

@implementation MXLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"搜索";
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,STATUS_AND_NAVIGATION_HEIGHT+70, MainScreenW, MainScreenH-STATUS_TABBAR_NAVIGATION_HEIGHT-70) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXAttractionCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, 30)];
    UILabel *titleLB=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, MainScreenW-40, 30)];
    titleLB.text=@"搜索结果";
    [headerView addSubview:titleLB];
    self.tableView.tableHeaderView=headerView;
    _searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(20, STATUS_AND_NAVIGATION_HEIGHT+10, MainScreenW-40, 40)];
    _searchBar.placeholder=@"城市";
    _searchBar.delegate=self;
    _searchBar.searchBarStyle=UISearchBarStyleMinimal;
    [self.view addSubview:self.searchBar];
}
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray arrayWithObjects:@{@"image":@"weinisi",@"cityName":@"威尼斯"},@{@"image":@"lundun",@"cityName":@"伦敦"},@{@"image":@"bolin",@"cityName":@"柏林"},@{@"image":@"luoma",@"cityName":@"罗马"},@{@"image":@"mosike",@"cityName":@"莫斯科"}, nil];
    }
    return _dataArr;
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if (searchBar.text.length!=0) {
        MXResultsViewController *resultVC=[[MXResultsViewController alloc] init];
        resultVC.cityName=searchBar.text;
        [self.navigationController pushViewController:resultVC animated:YES];
//        [self.navigationController pushViewController:resultVC animated:YES];
    }
    [self.searchBar resignFirstResponder];// 放弃第一响应者
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];// 放弃第一响应者
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MXAttractionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.bgImgView.image=[UIImage imageNamed:[self.dataArr[indexPath.row]objectForKey:@"image"]];
    cell.bgImgView.contentMode=UIViewContentModeScaleAspectFill;
    cell.bgImgView.layer.masksToBounds=YES;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.searchBar resignFirstResponder];// 放弃第一响应者
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MXResultsViewController *resultVC=[[MXResultsViewController alloc] init];
    resultVC.cityName=[self.dataArr[indexPath.row] objectForKey:@"cityName"];
    [self.navigationController pushViewController:resultVC animated:YES];
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
