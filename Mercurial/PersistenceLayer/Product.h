//
//  Product.h
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, copy) NSArray *imageURLArray;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *productInfo;

@end
