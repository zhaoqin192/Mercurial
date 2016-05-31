//
//  NetworkRequest+BBS.m
//  Mercurial
//
//  Created by zhaoqin on 4/14/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NetworkRequest+BBS.h"
#import "NetworkManager.h"
#import "TopicManager.h"
#import "Topic.h"
#import "AnswerManager.h"
#import "Answer.h"
#import "TypeManager.h"
#import "DatabaseManager.h"
#import "Account.h"
#import "AccountDao.h"
#import "MessageManager.h"
#import "MJExtension.h"
#import "Message.h"
#import "Type.h"


@implementation NetworkRequest (BBS)

+ (void) requestTopicList:(NSString *)type
                 identify:(NSString *)typeID
                  success:(void (^)())success
                  failure:(void (^)())failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Forum/Index/topic_list"]];
    NSMutableDictionary *parames = [NSMutableDictionary dictionaryWithCapacity:1];;
    
    if(type != nil) {
        [parames setObject:typeID forKey:type];
    }
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        if([[responseObject objectForKey:@"status"] isEqualToString:@"200"]){
            TopicManager *topicManager = [TopicManager sharedManager];
            topicManager.topicArray = [Topic mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"success"]];
        }
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
    
}

+ (void) requestTopicAnswerList:(NSString *)topicID
                        success:(void (^)())success
                        failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Forum/Index/topic_answer_list"]];
    NSDictionary *parames = @{@"topic_id": topicID};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        if([[responseObject objectForKey:@"status"] isEqualToString:@"200"]){
            AnswerManager *answerManager = [AnswerManager sharedManager];
            answerManager.answerArray = [Answer mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"success"]];
        }
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
}

+ (void) requestTopicCondition:(NSString *)type
                       success:(void (^)())success
                       failure:(void (^)())failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Forum/Index/topic_condition"]];
    NSDictionary *parames = @{@"type": type};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        if([[responseObject objectForKey:@"status"] isEqualToString:@"200"]){
            TypeManager *typeManager = [TypeManager sharedManager];
            typeManager.typeArray = [Type mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"success"]];
        }
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
}

+ (void) requestSendTopic:(NSString *)title
                     text:(NSString *)text
                     type:(NSString *)type
                   typeID:(NSString *)typeID
                  success:(void (^)(NSString *topic_id, NSString *forum_answer_id))success
                  failure:(void (^)())failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Forum/Index/topic_send_topic"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token,
                              @"main_title": title,
                              @"text": text,
                              type: typeID};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        if([[responseObject objectForKey:@"status"] isEqualToString:@"200"]){
            success([responseObject objectForKey:@"topic_id"], [responseObject objectForKey:@"forum_answer_id"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
    
}

+ (void) uploadTopicPic:(NSString *)topicID
          forumAnswerID:(NSString *)forumAnswerID
                  image:(UIImage *)image
                success:(void (^)())success
                failure:(void (^)())failure{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.001);
    NSLog(@"uploadTopicPic");
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    //    manager.responseSerializer = [AFJSONResponseSerializer
    //                                  serializerWithReadingOptions:NSJSONReadingAllowFragments];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parames = @{@"sid": account.token,
                              @"topic_id": topicID,
                              @"forum_answer_id": forumAnswerID};
    
    [manager POST:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Forum/Index/upload"] parameters:parames constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
        NSLog(@"Error: %@", error);
    }];
    
}

+ (void) requestReplyTopic:(NSString *)topicID
                      text:(NSString *)text
          answerToUsername:(NSString *)name
                   toFloor:(NSNumber *)floor
                   success:(void (^)(NSString *))success
                   failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Forum/Index/reply_topic"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token,
                              @"topic_id": topicID,
                              @"text": text,
                              @"answer_to_username": name,
                              @"to_floor": floor};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        if([[responseObject objectForKey:@"status"] isEqualToString:@"200"]){
            success([responseObject objectForKey:@"forum_answer_id"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
}

+ (void) requestMessageList:(void (^)())success
                    failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Forum/Index/get_message_list"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        if([[responseObject objectForKey:@"status"] isEqualToString:@"200"]){
            MessageManager *messageManager = [MessageManager sharedManager];
            messageManager.messageArray = [Message mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"success"]];
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
    
}

+ (void) requestReadMessage:(NSString *)topicID
                    success:(void (^)())success
                    failure:(void (^)())failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Forum/Index/read_message"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token, @"topic_id": topicID};
    NSLog(@"%@", parames);
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        if([[responseObject objectForKey:@"status"] isEqualToString:@"200"]){
            success();
        }
        else{
            failure();
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
}

+ (void)requestSearchWithTopic:(NSString *)topic success:(void (^)())success failure:(void (^)())failure {
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Forum/Index/search_topic"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    NSDictionary *parames = @{@"sid": account.token, @"main_title": topic};
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        if([[responseObject objectForKey:@"status"] isEqualToString:@"200"]){
            success();
        }
        else{
            failure();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
}

@end
