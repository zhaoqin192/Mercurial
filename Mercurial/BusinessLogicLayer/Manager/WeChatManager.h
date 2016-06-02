//
//  WeChatManager.h
//  Mercurial
//
//  Created by zhaoqin on 6/2/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeChatManager : NSObject

//发送给好友
- (void)onSelectSessionScene;
//发送给朋友圈
- (void)onSelectTimelineScene;
//分享链接
- (BOOL)sendLinkContent;

@end
