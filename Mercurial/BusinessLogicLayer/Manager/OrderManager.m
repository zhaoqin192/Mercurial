//
//  OrderManager.m
//  Mercurial
//
//  Created by zhaoqin on 3/30/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "OrderManager.h"
#import "Order.h"
#import "SearchOrder.h"

@implementation OrderManager

static OrderManager *sharedManager;

- (instancetype)init{
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



@end
