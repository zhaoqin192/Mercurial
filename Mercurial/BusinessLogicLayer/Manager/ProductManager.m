//
//  ProductManager.m
//  Mercurial
//
//  Created by zhaoqin on 3/17/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "ProductManager.h"

@implementation ProductManager

static ProductManager *sharedManager;

- (id)init{
    self = [super init];
    self.productKindArray = [[NSMutableArray alloc] init];
    self.productTypeArray = [[NSMutableArray alloc] init];
    self.productArray = [[NSMutableArray alloc] init];
    self.productKind = [[ProductKind alloc] init];
    self.product = [[Product alloc] init];
    return self;
}

+ (ProductManager *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[ProductManager alloc] init];
    });
    return sharedManager;
}

- (NSMutableArray *)getProductKindArray{
    return self.productKindArray;
}

- (NSMutableArray *)getProductTypeArray{
    return self.productTypeArray;
}

- (NSMutableArray *)getProductArray{
    return self.productArray;
}


@end
