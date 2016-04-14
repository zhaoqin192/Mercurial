//
//  NetworkRequest+Product.m
//  Mercurial
//
//  Created by zhaoqin on 4/14/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "NetworkRequest+Product.h"
#import "NetworkManager.h"
#import "ProductManager.h"
#import "ProductKind.h"
#import "ProductType.h"
#import "Product.h"

@implementation NetworkRequest (Product)

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


@end
