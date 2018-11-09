//
//  MXTravelCell.m
//  MXTourism
//
//  Created by Yang on 2018/9/19.
//  Copyright © 2018年 YY. All rights reserved.
//
#import "MXTravelDetailViewController.h"
#import "MXTravelCollectionViewCell.h"
#import "MXTravelCell.h"

@interface MXTravelCell ()
<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;

@property (nonatomic,strong)UICollectionView *collection;

@end
@implementation MXTravelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
-(void)createSubViews{
    self.flowLayout=[[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.itemSize=CGSizeMake(MainScreenW/3+20, 240);
    self.flowLayout.minimumLineSpacing=20;
    self.flowLayout.minimumInteritemSpacing=20;
    self.flowLayout.sectionInset=UIEdgeInsetsMake(20, 20, 0, 20);
    self.collection=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MainScreenW, 240) collectionViewLayout:self.flowLayout];
    self.collection.backgroundColor=[UIColor whiteColor];
    self.collection.delegate=self;
    self.collection.dataSource=self;
    [self addSubview:self.collection];
    self.collection.userInteractionEnabled=YES;
    [self.collection registerNib:[UINib nibWithNibName:@"MXTravelCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellID1"];
}
-(void)layoutSubviews{
    [self createSubViews];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MXTravelCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellID1" forIndexPath:indexPath];
    [cell.iconImgView sd_setImageWithURL:[NSURL URLWithString:[self.sourceDict objectForKey:@"imageUrls"][indexPath.row]]];
    cell.iconImgView.layer.cornerRadius=10;
    cell.iconImgView.contentMode=UIViewContentModeScaleAspectFill;
    cell.iconImgView.layer.masksToBounds=YES;
    cell.userInteractionEnabled=YES;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.sourceDict objectForKey:@"imageUrls"] count];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    MXTravelDetailViewController *detailVC=[[MXTravelDetailViewController alloc] init];
    detailVC.dataSources=self.sourceDict;
    [self.nav pushViewController:detailVC animated:YES];
}



@end
