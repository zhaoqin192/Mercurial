//
//  NewsCell.m
//  Mercurial
//
//  Created by 王霄 on 16/3/28.
//  Copyright © 2016年 muggins. All rights reserved.
//

#import "NewsCell.h"
#import "News.h"
#import "Sales.h"
#import "ProductType.h"
#import "Product.h"
@interface NewsCell()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *myTextLabel;

@end

@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMynews:(News *)mynews{
    _mynews = mynews;
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:_mynews.imageURL] placeholderImage:[UIImage imageNamed:@"placehold"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    self.myTextLabel.text = mynews.title;
}

- (void)setSale:(Sales *)sale{
    _sale = sale;
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:_sale.imageURL] placeholderImage:[UIImage imageNamed:@"placehold"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    self.myTextLabel.text = _sale.title;
}

- (void)setProductKind:(ProductKind *)productKind{
    _productKind = productKind;
    NSLog(@"%@",_productKind.imageURL);
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:_productKind.imageURL] placeholderImage:[UIImage imageNamed:@"placehold"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    self.myTextLabel.text = _productKind.name;
}

- (void)setProductType:(ProductType *)productType{
    _productType = productType;
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:_productType.imageURL] placeholderImage:[UIImage imageNamed:@"placehold"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    self.myTextLabel.text = _productType.name;
}

- (void)setProduct:(Product *)product{
    _product = product;
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:_product.imageURL] placeholderImage:[UIImage imageNamed:@"placehold"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    self.myTextLabel.text = _product.name;
}

@end
