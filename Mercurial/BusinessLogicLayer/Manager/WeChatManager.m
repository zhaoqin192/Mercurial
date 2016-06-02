//
//  WeChatManager.m
//  Mercurial
//
//  Created by zhaoqin on 6/2/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "WeChatManager.h"
#import "WXApiObject.h"
#import "WXApi.h"

@interface WeChatManager ()

@property (nonatomic) enum WXScene currentScene;

@end

@implementation WeChatManager

static WeChatManager *sharedManager;

@synthesize currentScene = _currentScene;


- (void)onSelectSessionScene {
    _currentScene = WXSceneSession;
}

- (void)onSelectTimelineScene {
    _currentScene = WXSceneTimeline;
}

- (BOOL)sendLinkContent {
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"唯美集团";
    message.description = @"我在这里发现了一款不错的装修产品，快来看看吧！";
    
    UIImage *image = [self compressImage:[UIImage imageNamed:@"introduction"] toTargetWidth:200];
    [message setThumbImage:image];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"http://yyzwt.cn:12345/tools/index/weixin_share";
    message.mediaObject = ext;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.scene = _currentScene;
    req.message = message;
    
    return [WXApi sendReq:req];
}

- (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}



@end
