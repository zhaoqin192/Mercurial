//
//  NetworkRequest+Others.m
//  Mercurial
//
//  Created by zhaoqin on 4/14/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NetworkRequest+Others.h"
#import "NetworkManager.h"
#import "NewsManager.h"
#import "News.h"
#import "SalesManager.h"
#import "Sales.h"
#import "DatabaseManager.h"
#import "AccountDao.h"
#import "Account.h"

@implementation NetworkRequest (Others)

+ (void) requestNewsWithSuccess:(void (^)())success
                        failure:(void (^)(NSString *error))failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Company/Index/news"]];
    
    [manager POST:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NewsManager *manager = [NewsManager sharedManager];
        [manager.newsArray removeAllObjects];
        NSArray *array = responseObject;
        for (NSDictionary *dic in array){
            News *news = [[News alloc] init];
            news.title = [dic objectForKey:@"title"];
            news.date = [dic objectForKey:@"news_date"];
            news.imageURL = [dic objectForKey:@"image_url"];
            news.webURL = [dic objectForKey:@"html_url"];
            [manager.newsArray addObject:news];
        }
        success();
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"Network Error");
    }];
}

+ (void) requestIntroduceWithSuccess:(void (^)(NSString *url))success
                             failure:(void (^)(NSString *error))failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Company/Index/companyAbout"]];
    
    [manager POST:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *dic = responseObject;
        success([dic objectForKey:@"html_url"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure(@"Network Error");
    }];
}



+ (void) requestMallWithName:(NSString *)platform
                     success:(void (^)(NSString *text))success
                     failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Company/Index/companyMall"]];
    
    NSDictionary *parameters = @{@"platform": platform};
    
    [manager POST:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *dic = responseObject;
        success([dic objectForKey:@"html_url"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
}

+ (void) requestSalesType:(NSNumber *)type
                  success:(void (^)())success
                  failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/sales"]];
    
    NSDictionary *parameters = @{@"type": type};
    
    [manager POST:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        SalesManager *manager = [SalesManager sharedManager];
        if ([type  isEqual: @(0)]) {
            [manager.roundArray removeAllObjects];
            NSArray *array = responseObject;
            for (NSDictionary *dic in array){
                Sales *sales = [[Sales alloc] init];
                sales.title = [dic objectForKey:@"title"];
                sales.imageURL = [dic objectForKey:@"image_url"];
                sales.webURL = [dic objectForKey:@"html_url"];
                sales.date = [dic objectForKey:@"news_date"];
                [manager.roundArray addObject:sales];
            }
        }else{
            [manager.salesArray removeAllObjects];
            NSArray *array = responseObject;
            for (NSDictionary *dic in array){
                Sales *sales = [[Sales alloc] init];
                sales.title = [dic objectForKey:@"title"];
                sales.imageURL = [dic objectForKey:@"image_url"];
                sales.webURL = [dic objectForKey:@"html_url"];
                sales.date = [dic objectForKey:@"news_date"];
                [manager.salesArray addObject:sales];
            }
        }
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
    
}





+ (void) requestFakeSearch:(NSString *)productID
                   success:(void (^)(NSString *successContent))success
                   failure:(void (^)(NSString *error,NSString *phone))failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/anti_fake_search"]];
    Account *acount = [[DatabaseManager sharedAccount] getAccount];
    NSString *token = acount.token;
    NSDictionary *parames = @{@"sid": token,@"anti_code": productID};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *dic = responseObject;
        if([[dic objectForKey:@"status"] isEqualToString:@"200"]){
            success(dic[@"success"]);
        }else if([[dic objectForKey:@"status"] isEqualToString:@"400"]){
            failure([dic objectForKey:@"error"],dic[@"phone"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure(@"Network Error",@"");
    }];
    
}


@end
