//
//  Recommend.h
//  Mercurial
//
//  Created by zhaoqin on 4/1/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recommend : NSObject

@property (nonatomic, strong) NSString *user_recomm_id;
@property (nonatomic, strong) NSString *recomm_name;
@property (nonatomic, strong) NSString *recomm_phone;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *recomm_product_name;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *recomm_reason;


@end
