//
//  OrderManager.h
//  Mercurial
//
//  Created by zhaoqin on 3/30/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"

@interface OrderManager : NSObject

@property (nonatomic, strong) NSMutableArray *orderArray;

+ (OrderManager *) sharedManager;

- (NSMutableArray *) fetchOrderArray;

- (void) addToOrderArray:(Order *)order;

- (void) cleanOrderArray;

@end
