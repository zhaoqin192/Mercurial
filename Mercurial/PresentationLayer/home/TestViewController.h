//
//  TestViewController.h
//  Mercurial
//
//  Created by zhaoqin on 3/17/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
- (IBAction)register:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)registerButton:(id)sender;
- (IBAction)news:(id)sender;
- (IBAction)introduce:(id)sender;
- (IBAction)userinform:(id)sender;
- (IBAction)productKind:(id)sender;
- (IBAction)productType:(id)sender;
- (IBAction)productDetail:(id)sender;
- (IBAction)searchProduct:(id)sender;
- (IBAction)requestMall:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getProduct;
- (IBAction)setProduct:(id)sender;
- (IBAction)uploadAvatar:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *pickImage;
- (IBAction)orderList:(id)sender;
- (IBAction)addOrder:(id)sender;
- (IBAction)recommendList:(id)sender;

@end
