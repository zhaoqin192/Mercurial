//
//  OldFriendIntroduceViewController.h
//  Mercurial
//
//  Created by 王霄 on 16/4/11.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Account;

@interface OldFriendIntroduceViewController : UIViewController
@property (nonatomic ,strong) Account *myAccount;
@property (nonatomic ,copy) void(^returnString)(NSString *name, NSString*phone);
@end
