//
//  NewsCell.h
//  Mercurial
//
//  Created by 王霄 on 16/3/28.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductKind.h"
@class News;
@class Sales;
@class ProductKind;
@interface NewsCell : UITableViewCell
@property (nonatomic, strong) News *mynews;
@property (nonatomic, strong) Sales *sale;
@property (nonatomic, strong) ProductKind *product;
@end
