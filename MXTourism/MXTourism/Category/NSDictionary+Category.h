//
//  NSDictionary+Category.h
//  MXTourism
//
//  Created by Yang on 2018/9/25.
//  Copyright © 2018年 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Category)

/*****************获取升序键值*********************/
- (NSArray *)yy_ascendingComparedAllKeys;

/*****************获取降序键值*********************/
- (NSArray *)yy_descendingComparedAllKeys;

@end
