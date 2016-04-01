//
//  Order.h
//  Mercurial
//
//  Created by zhaoqin on 3/31/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject

@property (nonatomic, strong) NSString *product_usage;
@property (nonatomic, strong) NSString *product_name;
@property (nonatomic, strong) NSString *product_level;
@property (nonatomic, strong) NSNumber *product_amount;
@property (nonatomic, strong) NSNumber *product_price;

@end
