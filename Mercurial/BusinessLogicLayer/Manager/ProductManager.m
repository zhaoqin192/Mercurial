//
//  ProductManager.m
//  Mercurial
//
//  Created by zhaoqin on 3/17/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "ProductManager.h"
#import "ProductKind.h"
#import "Product.h"

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

- (NSMutableArray *)fetchProductKindArray{
    return self.productKindArray;
}

- (NSMutableArray *)fetchProductTypeArray{
    return self.productTypeArray;
}

- (NSMutableArray *)fetchProductArray{
    return self.productArray;
}


@end
