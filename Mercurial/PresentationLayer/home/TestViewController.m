//
//  TestViewController.m
//  Mercurial
//
//  Created by zhaoqin on 3/17/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "TestViewController.h"
#import "NetworkRequest.h"
#import "AssetsLibrary/AssetsLibrary.h"
#import "Order.h"
#import "MJExtension.h"
#import "DatabaseManager.h"

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
        
    } failure:^(NSString *error){
        
    }];
}

- (IBAction)logout:(id)sender {
//    [NetworkRequest userLogoutWithSuccess:^{
//        
//    } failure:^{
//        
//    }];
}

- (IBAction)registerButton:(id)sender {
    [NetworkRequest userRegisterWithName:@"muggins" password:@"123456" phone:@"18845678901" sex:@"男" age:11 Email:@"12345678@qq.com" success:^{
        
    } failure:^(NSString *error){
        
    }];
    
//    NetworkRequest userRegisterWithName:(NSString *) password:(NSString *) phone:(NSString *) sex:(NSString *) age:(NSInteger) Email:(NSString *) success:^{
//        
//    } failure:^(NSString *) {
//        
//    }
}

- (IBAction)news:(id)sender {
   [NetworkRequest requestNewsWithSuccess:^{
       
   } failure:^(NSString *error){
       
   }];
}

- (IBAction)introduce:(id)sender {
   [NetworkRequest requestIntroduceWithSuccess:^(NSString *webUrl) {
       NSLog(@"%@", webUrl);
   } failure:^(NSString *error){
       
   }];
}

- (IBAction)userinform:(id)sender {
//    NSString *token = [[[DatabaseManager sharedAccount] getAccount] token];
    
//    [NetworkRequest requestUserInformationWithToken:token success:^{
//        
//    } failure:^{
//        
//    }];
    
    [NetworkRequest requestCommendItem:@"41c4520320814d4321a130a451f6af3679e8db5b47d75053d3d2c6b79407b177" success:^{
        
    } failure:^{
        
    }];
}

- (IBAction)productKind:(id)sender {
    
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

- (IBAction)uploadAvatar:(id)sender {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToUse;
    // Handle a still image picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToUse = editedImage;
        } else {
            imageToUse = originalImage;
        }
        // Do something with imageToUse
        self.pickImage.image = imageToUse;
        
    }
    [picker dismissViewControllerAnimated:YES completion:^{
       [NetworkRequest uploadAvatar:imageToUse success:^{
           
       } failure:^{
           
       }];
    }];
}

- (IBAction)orderList:(id)sender {
    [NetworkRequest requestOrderListWithSuccess:^{
        
    } failure:^{
        
    }];
}

- (IBAction)addOrder:(id)sender {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(int i = 0; i < 4; i++){
        Order *order = [[Order alloc] init];
        order.product_usage = @"1";
        order.product_name = @"2";
        order.product_level = @"3";
        order.product_price = [NSNumber numberWithInteger:4];
        order.product_amount = [NSNumber numberWithInteger:5];
        [array addObject:order];
    }
    
    [NetworkRequest requestAddOrderWithID:@"201603312123" name:@"sd" province:@"asdf" city:@"asdf" district:@"asdf" address:@"sdfds" phone:@"18810541555" date:@"2015-10-20" item:array success:^{
        
    } failure:^(NSString *error){
        
    }];
    
}

- (IBAction)recommendList:(id)sender {
    [NetworkRequest requestCommendList:^{
        
    } failure:^{
        
    }];
}
@end
