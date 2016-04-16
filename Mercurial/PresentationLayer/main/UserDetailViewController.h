//
//  UserDetailViewController.h
//  Mercurial
//
//  Created by 王霄 on 16/4/4.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Account;

@interface UserDetailViewController : UIViewController
@property (nonatomic ,copy) NSString *myTitle;
@property (nonatomic ,copy) void(^returnString)(NSString *text);
@property (nonatomic ,strong) Account *myAccount;
@property (nonatomic ,copy) NSString *originContent;
@end
