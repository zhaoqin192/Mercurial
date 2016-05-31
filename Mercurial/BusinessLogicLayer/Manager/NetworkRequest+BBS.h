//
//  NetworkRequest+BBS.h
//  Mercurial
//
//  Created by zhaoqin on 4/14/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NetworkRequest.h"

@interface NetworkRequest (BBS)

/**
 *  帖子列表
 *
 *  @param type    type为nil，则返回所有帖子；参数为:区域id（type = product_area_id）、系列id（type = product_type_id）、价位id（type = product_price_id）、装修经验id（type = product_decro_experience_id）、其他id（type = product_other_id）；
 *  @param typeID  具体的id
 *  @param success
 *  @param failure
 */
+ (void) requestTopicList:(NSString *)type
                 identify:(NSString *)typeID
                  success:(void (^)())success
                  failure:(void (^)())failure;

/**
 *  帖子对应的楼层列表
 *
 *  @param topicID
 *  @param success
 *  @param failure
 */
+ (void) requestTopicAnswerList:(NSString *)topicID
                        success:(void (^)())success
                        failure:(void (^)())failure;

/**
 *  筛选选项
 *
 *  @param type    筛选条件包括区域（type = product_area）、系列（type = product_type）、价位（type = product_price）、装修经验（type = product_decro_experience）、其他（type = product_other）
 *  @param success
 *  @param failure
 */
+ (void) requestTopicCondition:(NSString *)type
                       success:(void (^)())success
                       failure:(void (^)())failure;

/**
 *  发帖（帖子中带有图片，方法是先上传文字内容，然后返回topic_id和forum_answer_id,再上传图片，上述过程完成后，显示发帖成功）
 *
 *  @param title
 *  @param text
 *  @param type
 *  @param typeID
 *  @param success
 *  @param failure
 */
+ (void) requestSendTopic:(NSString *)title
                     text:(NSString *)text
                     type:(NSString *)type
                   typeID:(NSString *)typeID
                  success:(void (^)(NSString *topic_id, NSString *forum_answer_id))success
                  failure:(void (^)())failure;

/**
 *  发帖中的图片
 *
 *  @param topicID
 *  @param formID
 *  @param success
 *  @param failure
 */
+ (void) uploadTopicPic:(NSString *)topicID
          forumAnswerID:(NSString *)forumAnswerID
                  image:(UIImage *)image
                success:(void (^)())success
                failure:(void (^)())failure;

/**
 *  楼层回复
 *
 *  @param topicID
 *  @param text
 *  @param name
 *  @param floor
 *  @param success
 *  @param failure
 */
+ (void) requestReplyTopic:(NSString *)topicID
                      text:(NSString *)text
          answerToUsername:(NSString *)name
                   toFloor:(NSNumber *)floor
                   success:(void (^)(NSString *))success
                   failure:(void (^)())failure;

/**
 *  获得消息列表
 *
 *  @param success
 *  @param failure
 */
+ (void) requestMessageList:(void (^)())success
                    failure:(void (^)())failure;

/**
 *  阅读消息，调用该接口，即表示阅读完这条消息
 *
 *  @param topicID
 *  @param success
 *  @param failure
 */
+ (void) requestReadMessage:(NSString *)topicID
                    success:(void (^)())success
                    failure:(void (^)())failure;

/**
 *  搜索帖子
 *
 *  @param topic   搜索关键字
 *  @param success
 *  @param failure 
 */
+ (void) requestSearchWithTopic:(NSString *)topic
                        success:(void(^)())success
                        failure:(void(^)())failure;

@end
