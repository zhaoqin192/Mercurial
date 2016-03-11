//
//  FuncTableViewCell.h
//  Mercurial
//
//  Created by zhaoqin on 3/10/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FuncCollectionViewCell.h"
#import "Constant.h"

@interface FuncTableViewCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
