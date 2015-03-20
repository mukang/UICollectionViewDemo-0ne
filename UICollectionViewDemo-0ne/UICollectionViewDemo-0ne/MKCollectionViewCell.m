//
//  MKCollectionViewCell.m
//  UICollectionViewDemo-0ne
//
//  Created by 穆康 on 15/3/20.
//  Copyright (c) 2015年 穆康. All rights reserved.
//

#import "MKCollectionViewCell.h"

@interface MKCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MKCollectionViewCell

- (void)awakeFromNib {
    
    self.imageView.layer.borderWidth = 2;
    
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.imageView.layer.cornerRadius = 15;
    
    self.imageView.clipsToBounds = YES;
}


- (void)setImage:(NSString *)image {
    
    _image = [image copy];
    
    self.imageView.image = [UIImage imageNamed:image];
}

@end
