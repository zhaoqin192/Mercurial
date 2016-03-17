//
//  NetworkRequest.m
//  Mercurial
//
//  Created by zhaoqin on 3/16/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NetworkRequest.h"

@implementation NetworkRequest


+ (void) userRegisterWithName:(NSString *)name
                     password:(NSString *)password
                        phone:(NSString *)phone
                          sex:(NSString *)sex
                          age:(NSInteger)age
                        Email:(NSString *)email
                      success:(void (^)())success
                      failure:(void (^)())failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/register"]];
    NSDictionary *parameters = @{@"name":name, @"passwd":[Utility md5:password], @"phone":phone, @"sex":sex, @"age":[NSNumber numberWithInteger:age], @"mail":email};
    
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@"%@", manager.requestSerializer);
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
    
}

+ (void) userLoginWithName:(NSString *)accountName
                  password:(NSString *)password
                   success:(void (^)())success
                   failure:(void (^)())failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/login"]];
    NSDictionary *parameters = @{@"name":accountName, @"passwd":[Utility md5:password]};
    
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *dic = responseObject;
        NSString *token = [dic objectForKey:@"sid"];
//        [[DatabaseManager sharedAccount] insertWithAccountName:accountName password:password token:token success: success:^{
//             success();
//        }];
        [[DatabaseManager sharedAccount] insertWithAccountName:accountName password:password token:token success:^{
            success();
        }];
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
}

+ (void) userLogoutWithSuccess:(void (^)())success
                       failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/logout"]];
//    NSString *token = [[[DatabaseManager sharedAccount] getAccount] token];
    Account *acount = [[DatabaseManager sharedAccount] getAccount];
    
    NSString *token = acount.token;
    
    NSDictionary *parameters = @{@"sid": token};
    
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [[DatabaseManager sharedAccount] deleteAccountSuccess:^{
            success();
        } failure:^{
            
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
}

+ (void) requestNewsWithSuccess:(void (^)())success
                        failure:(void (^)())failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Company/Index/news"]];
    
    [manager POST:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
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
        NSLog(@"Error: %@", error);
        failure();
    }];
}

+ (void) requestIntroduceWithSuccess:(void (^)(NSString *))success
                             failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Company/Index/companyAbout"]];
    
    [manager POST:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *dic = responseObject;
        success([dic objectForKey:@"html_url"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
}

+ (void) requestUserInformationWithToken:(NSString *)token
                                 success:(void (^)())success
                                 failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/get_user_info"]];
    
    NSDictionary *parameters = @{@"sid": [[[DatabaseManager sharedAccount] getAccount] token]};
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);

        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];

}

+ (void) requestProductKindSuccess:(void (^)()) success
                           failure:(void (^)()) failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/get_product_kind"]];
    
    [manager POST:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *array = responseObject;
        ProductManager *manager = [ProductManager sharedManager];
        [manager.productKindArray removeAllObjects];
        for (NSDictionary *dic in array){
            ProductKind *productKind = [[ProductKind alloc] init];
            productKind.identifier = [dic objectForKey:@"product_kind_id"];
            productKind.imageURL = [dic objectForKey:@"product_kind_mini_image"];
            productKind.name = [dic objectForKey:@"product_kind_name"];
            [manager.productKindArray addObject:productKind];
        }
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
}

+ (void) requestProductTypeWithKind:(NSString *)productKindID
                            success:(void (^)())success
                            failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/get_product_type"]];
    
    NSDictionary *parameters = @{@"product_kind_id": productKindID};
    
    [manager POST:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *array = responseObject;
        ProductManager *manager = [ProductManager sharedManager];
        [manager.productTypeArray removeAllObjects];
        for (NSDictionary *dic in array){
            ProductType *productType = [[ProductType alloc] init];
            productType.identifier = [dic objectForKey:@"product_type_id"];
            productType.imageURL = [dic objectForKey:@"product_type_mini_image"];
            productType.name = [dic objectForKey:@"product_type_name"];
            [manager.productTypeArray addObject:productType];
        }
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        
        failure();
    }];

}

+ (void) requestProductListWithKind:(NSString *)productKindID
                               type:(NSString *)productTypeID
                            success:(void (^)())success
                            failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/get_product_list"]];
    
    NSDictionary *parameters = @{@"product_kind_id": productKindID, @"product_type_id": productTypeID};
    NSLog(@"");
    [manager POST:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *array = responseObject;
        ProductManager *manager = [ProductManager sharedManager];
        [manager.productArray removeAllObjects];
        for (NSDictionary *dic in array){
            Product *product = [[Product alloc] init];
            product.identifier = [dic objectForKey:@"product_id"];
            product.imageURL = [dic objectForKey:@"product_mini_image"];
            product.name = [dic objectForKey:@"product_name"];
            [manager.productArray addObject:product];
        }
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
}

+ (void) requestProductDetailWithID:(NSString *)productID
                            success:(void (^)())success
                            failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/get_product_detail"]];
    
    NSDictionary *parameters = @{@"product_id": productID};
    
    [manager POST:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *dic = responseObject;
        ProductManager *manager = [ProductManager sharedManager];
        manager.product.imageURL = [dic objectForKey:@"image"];
        manager.product.productInfo = [dic objectForKey:@"product_intro"];
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
}

+ (void) searchProductWithName:(NSString *)name
                       success:(void (^)())success
                       failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/search_product_list"]];
    
    NSDictionary *parameters = @{@"product_name": name};
    
    [manager POST:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *array = responseObject;
        ProductManager *manager = [ProductManager sharedManager];
        [manager.productArray removeAllObjects];
        for (NSDictionary *dic in array){
            Product *product = [[Product alloc] init];
            product.identifier = [dic objectForKey:@"product_id"];
            product.imageURL = [dic objectForKey:@"product_mini_image"];
            [manager.productArray addObject:product];
        }
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
}

+ (void) requestMallWithName:(NSString *)platform
                     success:(void (^)(NSString *))success
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
        SalesManager *manager = [[SalesManager alloc] init];
        if (type == 0) {
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

@end



























