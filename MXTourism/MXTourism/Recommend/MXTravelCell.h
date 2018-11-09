//
//  MXTravelCell.h
//  MXTourism
//
//  Created by Yang on 2018/9/19.
//  Copyright © 2018年 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXTravelCell : UITableViewCell
@property (nonatomic,strong)NSMutableArray *imageUrls;
@property (nonatomic,strong)UINavigationController *nav;
@property (nonatomic,strong)NSMutableDictionary *sourceDict;
@end
