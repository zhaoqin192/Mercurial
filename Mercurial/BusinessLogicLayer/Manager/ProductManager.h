//
//  ProductManager.h
//  Mercurial
//
//  Created by zhaoqin on 3/17/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Product;
@class ProductKind;

@interface ProductManager : NSObject

//产品种类列表
@property (nonatomic, strong) NSMutableArray *productKindArray;
//产品类型列表
@property (nonatomic, strong) NSMutableArray *productTypeArray;
//产品列表
@property (nonatomic, strong) NSMutableArray *productArray;
//当前选取的产品种类
@property (nonatomic, strong) ProductKind *productKind;
//当前选取的产品
@property (nonatomic, strong) Product *product;

+ (ProductManager *)sharedManager;

- (NSMutableArray *)fetchProductKindArray;

- (NSMutableArray *)fetchProductTypeArray;

- (NSMutableArray *)fetchProductArray;

@end
