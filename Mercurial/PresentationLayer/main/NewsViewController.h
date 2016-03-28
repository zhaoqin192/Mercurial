//
//  NewsViewController.h
//  Mercurial
//
//  Created by 王霄 on 16/3/14.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UITableViewController
@property (nonatomic, copy) NSArray *news;
@property (nonatomic, copy) NSString *mytitle;
@property (nonatomic, assign) BOOL isNews;
@end
