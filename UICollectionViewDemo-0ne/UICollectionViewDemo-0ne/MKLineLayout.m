//
//  MKLineLayout.m
//  UICollectionViewDemo-0ne
//
//  Created by 穆康 on 15/3/20.
//  Copyright (c) 2015年 穆康. All rights reserved.
//

#define MKCollectionViewWidth self.collectionView.frame.size.width

#define MKCollectionViewHeight self.collectionView.frame.size.height

#define MKCollectionViewSize self.collectionView.frame.size

#import "MKLineLayout.h"

@implementation MKLineLayout

///  准备操作：一般在这里设置一些初始化参数
- (void)prepareLayout {
    
    // 必须要调用父类(父类也有一些准备操作)
    [super prepareLayout];
    
    // 设置滚动方向（只有流水布局才有这个属性）
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置cell的大小
    CGFloat itemWH = MKCollectionViewHeight * 0.6;
    
    self.itemSize = CGSizeMake(itemWH, itemWH);
    
    // 设置内边距
    CGFloat insetM = (MKCollectionViewWidth - itemWH) * 0.5;
    
    self.sectionInset = UIEdgeInsetsMake(0, insetM, 0, insetM);
}

///  返回collectionView上面所有元素（比如cell）的布局属性:这个方法决定了cell怎么排布
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    // 调用父类方法，拿到默认的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 获得 collectionView 最中间的 x 值
    CGFloat centerX = self.collectionView.contentOffset.x + MKCollectionViewWidth * 0.5;
    
    // 在默认布局的基础上进行微调
    for (UICollectionViewLayoutAttributes *attrs in array) {
        
        // 计算cell中点x值和collectionView最中间x值的差距
        CGFloat margin = ABS(centerX - attrs.center.x);
        
        CGFloat scale = 1 - margin / (MKCollectionViewWidth + attrs.frame.size.width);
        
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
}

///  当collectionView的bounds发生改变时，是否要刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}


///  使用此方法实现 cell 自动滚动到正中
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    // 计算最终的可见范围
    CGRect rect;
    
    rect.origin = proposedContentOffset;
    
    rect.size = MKCollectionViewSize;
    
    // 计算collectionView最终中间的x
    CGFloat centerX = proposedContentOffset.x + MKCollectionViewWidth * 0.5;
    
    // 取得 cell 的布局属性
    NSArray *array = [self layoutAttributesForElementsInRect:rect];
    
    // 计算最小的间距值
    CGFloat minMargin = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        
        CGFloat margin = attrs.center.x - centerX;
        
        if (ABS(minMargin) > ABS(margin)) {
            
            minMargin = margin;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + minMargin, proposedContentOffset.y);
}



@end
