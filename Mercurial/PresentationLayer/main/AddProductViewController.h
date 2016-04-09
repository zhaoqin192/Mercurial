//
//  AddProductViewController.h
//  Mercurial
//
//  Created by 王霄 on 16/4/9.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Order;

@interface AddProductViewController : UIViewController
@property (nonatomic, copy) NSString *identify;
@property (nonatomic, copy) void(^addOrder)(Order *order);
@end
