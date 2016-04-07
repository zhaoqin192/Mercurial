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
                      failure:(void (^)(NSString *error))failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/register"]];
    NSDictionary *parameters = @{@"name":name, @"passwd":[Utility md5:password], @"phone":phone, @"sex":sex, @"age":[NSNumber numberWithInteger:age], @"mail":email};
    
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        if([[dic objectForKey:@"status"] isEqualToString:@"200"]){
            success();
        }else{
            failure([dic objectForKey:@"error"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"Network Error");
    }];
    
}

+ (void) userLoginWithName:(NSString *)accountName
                  password:(NSString *)password
                   success:(void (^)())success
                   failure:(void (^)(NSString *error))failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/login"]];
    NSDictionary *parameters = @{@"name":accountName, @"passwd":[Utility md5:password]};
    
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        if([[responseObject objectForKey:@"status"] isEqualToString:@"200"]){
            NSString *token = [dic objectForKey:@"sid"];
            [[DatabaseManager sharedAccount] insertWithAccountName:accountName password:password token:token success:^{
                success();
            }];
        }else{
            [[DatabaseManager sharedAccount] insertWithAccountName:accountName password:password token:nil success:^{
                failure([dic objectForKey:@"error"]);
            }];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"Network Error");
    }];
}

+ (void) userLogoutWithSuccess:(void (^)())success
                       failure:(void (^)(NSString *error))failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/logout"]];

    Account *acount = [[DatabaseManager sharedAccount] getAccount];
    
    NSString *token = acount.token;
    
    NSDictionary *parameters = @{@"sid": token};
    
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        if([[dic objectForKey:@"status"] isEqualToString:@"200"]){
            [[DatabaseManager sharedAccount] deleteAccountSuccess:^{
                success();
            } failure:^{
                failure(@"Database Error");
            }];
        }else{
            failure([dic objectForKey:@"error"]);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"Network Error");
    }];
}

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

+ (void) requestUserInformationWithToken:(void (^)())success
                                 failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *url = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/get_user_info"]];
    
    NSDictionary *parameters = @{@"sid": [[[DatabaseManager sharedAccount] getAccount] token]};
    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *array = responseObject;
        NSDictionary *dic = [array objectAtIndex:0];
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        
        [[DatabaseManager sharedAccount] insertWithAccountName:[dic objectForKey:@"name"] phone:[dic objectForKey:@"phone"] sex:[dic objectForKey:@"sex"] age:[[dic objectForKey:@"age"] intValue] Email:[dic objectForKey:@"mail"] fixedTel:[dic objectForKey:@"fix_phone"] avatar:[dic objectForKey:@"photo"] name:[dic objectForKey:@"realname"] birth:[dic objectForKey:@"birth"] cardID:[dic objectForKey:@"card_number"] degree:[dic objectForKey:@"degree"] job:[dic objectForKey:@"job"] province:[dic objectForKey:@"province"] city:[dic objectForKey:@"city"] district:[dic objectForKey:@"district"] address:[dic objectForKey:@"address"] isBought:[[dic objectForKey:@"has_bought"] intValue] brand:[dic objectForKey:@"bought_brand"] way:[dic objectForKey:@"know_way"] experience:[dic objectForKey:@"decro_experience"] recommendName:[dic objectForKey:@"recomm_name"] recommendPhone:[dic objectForKey:@"recomm_phone"] success:success];
        
        success();
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];

}

+ (void) requestProductKindSuccess:(BOOL)isCommand
                           success:(void (^)()) success
                           failure:(void (^)()) failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/get_product_kind"]];
    NSDictionary *parameters = nil;
    if (isCommand) {
        parameters = @{@"product_recommed": @"true"};
    }
    [manager POST:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
        manager.product.imageURLArray = [dic objectForKey:@"image"];
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

+ (void) updateUserInformationWithSex:(NSString *)sex
                                  age:(NSString *)age
                                Email:(NSString *)email
                                phone:(NSString *)phone
                                photo:(NSString *)photo
                                 name:(NSString *)name
                                birth:(NSString *)birth
                               cardID:(NSString *)cardID
                               degree:(NSString *)degree
                                  job:(NSString *)job
                             province:(NSString *)province
                                 city:(NSString *)city
                             district:(NSString *)district
                              address:(NSString *)address
                             isBought:(BOOL)isBought
                                brand:(NSString *)brand
                                  way:(NSString *)way
                           experience:(NSString *)experience
                        recommendName:(NSString *)recommendName
                       recommendPhone:(NSString *)recommendPhone
                              success:(void (^)())success
                              failure:(void (^)(NSString *error))failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/save_user_info"]];
    
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSString *has_bought = (isBought)? @"true":@"false";
    
    NSDictionary *parameters = @{@"sid": account.token, @"sex": sex,@"age":age,@"has_bought":isBought? @(1):@(0),@"mail": email, @"fix_phone": phone, @"photo": photo, @"realname": name, @"birth": birth, @"card_number": cardID, @"degree": degree, @"job": job, @"province": province, @"city": city, @"district": district, @"address": address, @"has_bought": has_bought, @"bought_brand": brand, @"know_way": way, @"decro_experience": experience, @"recomm_name": recommendName, @"recomm_phone": recommendPhone};
    
    [manager POST:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *dic = responseObject;
        if([[dic objectForKey:@"status"] isEqualToString:@"200"]){
            success();
        }else{
            failure([dic objectForKey:@"error"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure(@"Network Error");
    }];

}

+ (void) uploadAvatar:(UIImage *)image
              success:(void (^)())success
              failure:(void (^)())failure{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.001);
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    NSDictionary *parameters = @{@"sid": account.token};
    
    [manager POST:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/upload"] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
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

+ (void) requestOrderListWithSuccess:(void (^)())success
                             failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/search_order_list"]];
    
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    
    NSDictionary *parameters = @{@"sid": account.token};
    
    [manager POST:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSArray *array = responseObject;
        OrderManager *manager = [OrderManager sharedManager];
        for(NSDictionary *dic in array){
            [manager.orderArray addObject:[dic objectForKey:@"order_id"]];
        }
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        failure();
    }];
}

+ (void) requestAddOrderWithID:(NSString *)order_id
                          name:(NSString *)username
                      province:(NSString *)delivery_province
                          city:(NSString *)delivery_city
                      district:(NSString *)delivery_district
                       address:(NSString *)delivery_address
                         phone:(NSString *)phone
                          date:(NSString *)buy_date
                          item:(NSMutableArray *)items
                       success:(void (^)())success
                       failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/add_order"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    AddOrder *addOrder = [[AddOrder alloc] init];
    addOrder.order_id = order_id;
    addOrder.username = username;
    addOrder.delivery_province = delivery_province;
    addOrder.delivery_city = delivery_city;
    addOrder.delivery_district = delivery_district;
    addOrder.delivery_address = delivery_address;
    addOrder.phone = phone;
    addOrder.buy_date = buy_date;
    addOrder.items = items;
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:addOrder.mj_keyValues options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parames = @{@"sid": account.token, @"json": jsonString};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
    
}

+ (void) requestSearchOrder:(NSString *)orderID
                    success:(void (^)())success
                    failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/search_order"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token, @"order_id": orderID};
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *dic = responseObject;
        OrderManager *orderManager = [OrderManager sharedManager];
        orderManager.searchOrder = [SearchOrder mj_objectWithKeyValues:dic];

        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
    
    
}

+ (void) requestDeleteOrder:(NSString *)orderID
                    success:(void (^)())success
                    failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/delete_order"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token, @"order_id": orderID};
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
    
}

+ (void) requestAddCommend:(NSString *)recomm_name
                     phone:(NSString *)recomm_phone
                  province:(NSString *)province
                      city:(NSString *)city
                  district:(NSString *)district
                   address:(NSString *)address
               commendName:(NSString *)recomm_product_name
                      date:(NSString *)date
                    reason:(NSString *)recomm_reason
                   success:(void (^)())success
                   failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/add_user_recomm"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token, @"recomm_name": recomm_name, @"recomm_phone": recomm_phone, @"province": province, @"city": city, @"district": district, @"address": address, @"recomm_product_name": recomm_product_name, @"date": date, @"recomm_reason": recomm_reason};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];

}


+ (void) requestCommendList:(void (^)())success
                    failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/get_user_recomm_list"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        RecommendManager *manager = [RecommendManager sharedManager];
        manager.commendArray = [Recommend mj_objectArrayWithKeyValuesArray:responseObject];
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];

}

+ (void) requestCommendItem:(NSString *)commendID
                    success:(void (^)())success
                    failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/User/Index/get_user_recomm_item"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token, @"user_recomm_id": commendID};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        RecommendManager *manager = [RecommendManager sharedManager];
        manager.recommend = [Recommend mj_objectWithKeyValues:responseObject];
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];

}

+ (void) requestFakeSearch:(NSString *)productID
                   success:(void (^)())success
                   failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Product/Index/anti_fake_search"]];
    
    NSDictionary *parames = @{@"product_id": productID};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];

}

+ (void) requestTopicList:(NSString *)type
                       id:(NSString *)typeID
                  success:(void (^)())success
                  failure:(void (^)())failure{
    
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Forum/Index/topic_list"]];
    NSMutableDictionary *parames = nil;

    if(type != nil) {
        parames[type] = typeID;
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
                  success:(void (^)(NSString *, NSString *))success
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
                success:(void (^)())success
                failure:(void (^)())failure{
    AFHTTPSessionManager *manager = [[NetworkManager sharedInstance] getRequestQueue];
    NSURL *URL = [NSURL URLWithString:[URLPREFIX stringByAppendingString:@"/weimei_background/index.php/Forum/Index/upload"]];
    Account *account = [[DatabaseManager sharedAccount] getAccount];
    
    NSDictionary *parames = @{@"sid": account.token,
                              @"topic_id": topicID,
                              @"forum_answer_id": forumAnswerID};
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        if([[responseObject objectForKey:@"status"] isEqualToString:@"200"]){
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
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
    
    [manager POST:URL.absoluteString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        if([[responseObject objectForKey:@"status"] isEqualToString:@"200"]){
            success();
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        failure();
    }];
}

@end



























