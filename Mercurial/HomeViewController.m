//
//  HomeViewController.m
//  Mercurial
//
//  Created by zhaoqin on 3/14/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

static NSString * const reuseIdentifier = @"funcCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collectionView registerClass:[FuncViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    self.collectionView registerClass:[FuncViewCell class]  forCellWithReuseIdentifier:<#(nonnull NSString *)#>
//    [self.collectionView registerNib:[UINib nibWithNibName:@"FuncViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FuncViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    [self.collectionView registerClass:[FuncViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
//    FuncViewCell *cell = [collectionView ]
    
//    [cell.imageView setImage:[UIImage imageNamed:@"balance"]];
//    [cell.imageView setBackgroundColor:[UIColor yellowColor]];
//    cell.backgroundColor = [UIColor redColor];
//    if (cell.imageView == nil) {
//        NSLog(@"null");
//    }
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
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200.0 / 600 * ScreenHeight)];
        [imageView setImage:[UIImage imageNamed:@"introduce"]];
        [footView addSubview:imageView];
        return footView;
    }
    return nil;
    
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGSize size = (60,60);
//    return size;

//    return CGSizeMake(60, 60);
//    NSLog(@"%f--%f", self.collectionView.frame.size.width, self.collectionView.frame.size.height);
//    return self.collectionView.frame.size;
//}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", (long)indexPath.row);
}

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
