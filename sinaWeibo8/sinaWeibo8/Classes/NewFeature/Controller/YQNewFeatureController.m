//
//  YQNewFeatureController.m
//  sinaWeibo8
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQNewFeatureCell.h"
#import "YQNewFeatureController.h"

#define count 4

@interface YQNewFeatureController ()

@end

@implementation YQNewFeatureController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.minimumLineSpacing = 0; // 列间距
//    flowLayout.minimumInteritemSpacing = 0;  // 行间距
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal; // 水平滚动
    
    return [super initWithCollectionViewLayout:flowLayout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES; //  分页效果
    self.collectionView.bounces = NO; // 取消弹簧效果
    
    // Register cell classes
    [self.collectionView registerClass:[YQNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

#pragma mark - UICollectionViewDelegate 数据源方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YQNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
    
    cell.image = [UIImage imageNamed:imageName];
    if (indexPath.row != count -1) {
        [cell isShow:YES];
    }
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int index = scrollView.contentOffset.x / scrollView.width;
    
    YQNewFeatureCell *cell = (YQNewFeatureCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    if (index == count - 1) {
        [cell showStartButton];
    }
}

@end
