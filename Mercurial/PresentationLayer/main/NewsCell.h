//
//  NewsCell.h
//  Mercurial
//
//  Created by 王霄 on 16/3/28.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;
@class Sales;
@class ProductKind;
@class ProductType;
@class Product;
@interface NewsCell : UITableViewCell
@property (nonatomic, strong) News *mynews;
@property (nonatomic, strong) Sales *sale;
@property (nonatomic, strong) ProductKind *productKind;
@property (nonatomic, strong) ProductType *productType;
@property (nonatomic, strong) Product *product;
@end
