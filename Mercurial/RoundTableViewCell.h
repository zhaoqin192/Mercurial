//
//  RoundTableViewCell.h
//  Mercurial
//
//  Created by zhaoqin on 3/10/16.
//  Copyright © 2016 muggins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundCollectionViewCell.h"
#import "Constant.h"

@interface RoundTableViewCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSTimer *timer;
@end
