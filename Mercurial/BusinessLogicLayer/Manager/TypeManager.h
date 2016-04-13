//
//  TypeManager.h
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Type;

@interface TypeManager : NSObject

@property (nonatomic, strong) NSMutableArray *typeArray;

+ (TypeManager *) sharedManager;

- (NSMutableArray *) fetchTypeArray;

- (void) addToTypeArray:(Type *) type;

- (void) cleanTypeArray;

@end
