//
//  CityPickView.h
//  CitypickerView
//
//  Created by 安浩 on 15/12/29.
//  Copyright © 2015年 www.swfitnews.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CityPickView;
@protocol CityPickViewDelegate <NSObject>

- (void)selectCity:(NSString *)city;
- (void)fetchDetail:(NSString *)province city:(NSString *)city district:(NSString *)district;

@end


@interface CityPickView : UIView

@property (nonatomic,assign) id<CityPickViewDelegate>delegate;

@end
