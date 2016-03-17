//
//  TestViewController.m
//  Mercurial
//
//  Created by zhaoqin on 3/17/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "TestViewController.h"
#import "NetworkRequest.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)register:(id)sender {
}
- (IBAction)login:(id)sender {
    [NetworkRequest userLoginWithName:@"muggins" password:@"123456" success:^{
        
    } failure:^{
        
    }];
}

- (IBAction)logout:(id)sender {
    [NetworkRequest userLogoutWithSuccess:^{
        
    } failure:^{
        
    }];
}

- (IBAction)registerButton:(id)sender {
    [NetworkRequest userRegisterWithName:@"muggins" password:@"123456" phone:@"18845678901" sex:@"男" age:11 Email:@"12345678@qq.com" success:^{
        
    } failure:^{
        
    }];
}

- (IBAction)news:(id)sender {
   [NetworkRequest requestNewsWithSuccess:^{
       
   } failure:^{
       
   }];
}

- (IBAction)introduce:(id)sender {
   [NetworkRequest requestIntroduceWithSuccess:^(NSString *webUrl) {
       NSLog(@"%@", webUrl);
   } failure:^{
       
   }];
}

- (IBAction)userinform:(id)sender {
//    NSString *token = [[[DatabaseManager sharedAccount] getAccount] token];
    
//    [NetworkRequest requestUserInformationWithToken:token success:^{
//        
//    } failure:^{
//        
//    }];
    
}

- (IBAction)productKind:(id)sender {
    [NetworkRequest requestProductKindSuccess:^{
        
    } failure:^{
        
    }];
}

- (IBAction)productType:(id)sender {
    ProductManager *manager = [ProductManager sharedManager];
    manager.productKind = [manager.productKindArray objectAtIndex:0];
    [NetworkRequest requestProductTypeWithKind:manager.productKind.identifier success:^{
        
    } failure:^{
        
    }];
}

- (IBAction)productDetail:(id)sender {
    ProductManager *manager = [ProductManager sharedManager];
    ProductType *productType = [manager.productTypeArray objectAtIndex:0];
    [NetworkRequest requestProductListWithKind:manager.productKind.identifier type:productType.identifier success:^{
        
    } failure:^{
        
    }];
}

- (IBAction)searchProduct:(id)sender {
    
    [NetworkRequest searchProductWithName:@"驰骋" success:^{
        
    } failure:^{
        
    }];
    
}

- (IBAction)requestMall:(id)sender {
    [NetworkRequest requestMallWithName:@"天猫" success:^(NSString *webURL) {
        NSLog(@"%@", webURL);
    } failure:^{
        
    }];
    
}
- (IBAction)setProduct:(id)sender {
    
    ProductManager *manager = [ProductManager sharedManager];
    manager.product = [manager.productArray objectAtIndex:0];
    NSString *productID = [[manager.productArray objectAtIndex:0] identifier];
    [NetworkRequest requestProductDetailWithID:productID success:^{
        
    } failure:^{
        
    }];
    
}
@end
