//
//  OrderManager.h
//  Mercurial
//
//  Created by zhaoqin on 3/30/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Order;
@class SearchOrder;

@interface OrderManager : NSObject

@property (nonatomic, strong) NSMutableArray *orderArray;
@property (nonatomic, strong) SearchOrder *searchOrder;

+ (OrderManager *) sharedManager;

@end
