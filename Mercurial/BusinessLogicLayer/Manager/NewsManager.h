//
//  NewsManager.h
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsManager : NSObject

//新闻列表
@property (nonatomic, strong) NSMutableArray *newsArray;

+ (NewsManager *) sharedManager;

@end