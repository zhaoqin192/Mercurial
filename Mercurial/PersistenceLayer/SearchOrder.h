//
//  SearchOrder.h
//  Mercurial
//
//  Created by zhaoqin on 4/7/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchOrder : NSObject

@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *delivery_province;
@property (nonatomic, strong) NSString *delivery_city;
@property (nonatomic, strong) NSString *delivery_district;
@property (nonatomic, strong) NSString *delivery_address;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *buy_date;
@property (nonatomic, strong) NSMutableArray *items;

@end
