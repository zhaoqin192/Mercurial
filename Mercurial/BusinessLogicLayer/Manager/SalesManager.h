//
//  SalesManager.h
//  Mercurial
//
//  Created by zhaoqin on 3/17/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalesManager : NSObject

//全部促销产品列表
@property (nonatomic, strong) NSMutableArray *salesArray;
//轮播产品列表
@property (nonatomic, strong) NSMutableArray *roundArray;

+ (SalesManager *) sharedManager;


@end
