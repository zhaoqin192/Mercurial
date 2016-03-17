//
//  HomeViewController.m
//  Mercurial
//
//  Created by zhaoqin on 3/14/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "HomeViewController.h"
#import "NewsViewController.h"
#import "PromoteViewController.h"
#import "ScanViewController.h"
#import "ShoppingViewController.h"
#import "KxMenu.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

static NSString * const reuseIdentifier = @"funcCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // 此处不应该注册collectionViewCell,否则会覆盖storyboard中的cell
    
    // Do any additional setup after loading the view.
    
    NSString *string = [Utility md5:@"123456"];
    NSLog(@"%@", string);
}

#pragma mark <MenuController>

- (IBAction)barButtonClicked:(UIBarButtonItem *)sender {
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"注册"
                     image:nil
                    target:self
                    action:@selector(registerButtonClicked)],
      
      [KxMenuItem menuItem:@"登录"
                     image:nil
                    target:self
                    action:@selector(loginButtonClicked)],
      ];
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(KScreen_width-40, 44, 20, 20)
                 menuItems:menuItems];
}


- (void)loginButtonClicked{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
    LoginViewController *vc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)registerButtonClicked{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RegisterStoryBoard" bundle:nil];
    RegisterViewController *vc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FuncViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}


//显示header和footer的回调方法
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    //如果想要自定义header，只需要定义UICollectionReusableView的子类A，然后在该处使用，注意Identifier要设为注册的字符串，此处为“header”
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"collectionHeader" forIndexPath:indexPath];
        NSArray *array = @[@"roundImage0", @"roundImage1", @"roundImage2"];
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 200.0) imageNamesGroup:array];
        [headView addSubview:cycleScrollView];
        return headView;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"collectionFooter" forIndexPath:indexPath];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 210.0 / 600 * ScreenHeight)];
        [imageView setImage:[UIImage imageNamed:@"introduce"]];
        [footView addSubview:imageView];
        return footView;
    }
    return nil;
    
}


#pragma mark <UICollectionViewDelegate>
//UICollectionView被选中时调用的方法

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            NSLog(@"公司简介");
            break;
        }
        case 1:{
            NewsViewController *vc = [[NewsViewController alloc] initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"公司新闻");
            break;
        }
        case 2:
            NSLog(@"产品介绍");
            break;
        case 3:
            NSLog(@"产品推荐");
            break;
        case 4:{
            PromoteViewController * vc = [[PromoteViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"促销信息");
            break;
        }
        case 5:{
            ShoppingViewController *vc = [[ShoppingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"商城");
            break;
        }
        case 6:
            NSLog(@"互动留言");
            break;
        case 7:{
            ScanViewController * vc = [[ScanViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"防伪查询");
            break;
        }
        case 8:{
            UITableViewController *vc = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateInitialViewController];
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"用户中心");
            break;
        }
        default:
            break;
    }
}

@end
