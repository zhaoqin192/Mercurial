//
//  SubjectDelegate.h
//  MoliStudy
//
//  Created by zhaoqin on 4/10/16.
//  Copyright © 2016 MoliStudy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SubjectDelegate <NSObject>

@required
- (void) clickCardSuccess:(NSString *)number;

@end
