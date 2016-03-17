//
//  News.h
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* imageURL;
@property (nonatomic, strong) NSString* webURL;
@property (nonatomic, strong) NSString* date;

@end