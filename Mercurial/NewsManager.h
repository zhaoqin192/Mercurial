//
//  NewsManager.h
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "News.h"

@interface NewsManager : NSObject

@property (nonatomic, strong) NSMutableArray *newsArray;

+ (NewsManager *) sharedManager;

- (NSMutableArray *) fetchArray;

@end