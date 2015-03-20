//
//  ViewController.m
//  UICollectionViewDemo-0ne
//
//  Created by 穆康 on 15/3/20.
//  Copyright (c) 2015年 穆康. All rights reserved.
//

#import "ViewController.h"
#import "MKLineLayout.h"
#import "MKCollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

///  所有的图片名
@property (nonatomic, strong) NSMutableArray *images;

@end


@implementation ViewController

static NSString *const ID = @"image";

#pragma mark 懒加载

- (NSMutableArray *)images {
    
    if (!_images) {
        
        _images = [[NSMutableArray alloc] init];
        
        for (int i=0; i<20; i++) {
            
            [_images addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建布局
    MKLineLayout *layout = [[MKLineLayout alloc] init];
    
    // 创建collectionView
    CGRect collectionViewFrame = CGRectMake(0, 100, self.view.frame.size.width, 200);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:layout];
    
    collectionView.dataSource = self;
    
    [collectionView registerNib:[UINib nibWithNibName:@"MKCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.images.count;
}

- (MKCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.image = self.images[indexPath.item];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>



@end
