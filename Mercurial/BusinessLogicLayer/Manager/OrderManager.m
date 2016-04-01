//
//  OrderManager.m
//  Mercurial
//
//  Created by zhaoqin on 3/30/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "OrderManager.h"

@implementation OrderManager

static OrderManager *sharedManager;

- (id)init{
    self = [super init];
    self.orderArray = [[NSMutableArray alloc] init];
    return self;
}

+ (OrderManager *) sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[OrderManager alloc] init];
    });
    return sharedManager;
}

- (NSMutableArray *) fetchOrderArray{
    return self.orderArray;
}

- (void) addToOrderArray:(Order *)order{
    [self.orderArray addObject:order];
}

- (void) cleanOrderArray{
    [self.orderArray removeAllObjects];
}

@end
