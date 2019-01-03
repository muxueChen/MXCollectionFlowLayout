//
//  ViewController.m
//  CollectionViewLayoutTest
//
//  Created by muxue on 2019/1/3.
//  Copyright © 2019 暮雪. All rights reserved.
//

#import "ViewController.h"
#import "MXCollectionViewCell.h"
#import "MXCollectionViewLayout.h"
#import "MXCollectionView.h"
#import "MXCollectionReusableView.h"
static NSString * const kCellID = @"Cell";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, MXCollectionViewLayoutDelegate>
@property (nonatomic, strong) MXCollectionView *collectionView;
@property (nonatomic, strong) MXCollectionViewLayout *collectionViewLayout;
@property (nonatomic, strong) NSArray <NSString *>*dataArray;
@property (nonatomic, strong) NSArray <NSString *>*sectionArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sectionArray = @[@"历史搜索", @"热门搜索", @"好友搜索", @"商品搜索"];
    self.dataArray = @[@"你是傻逼", @"你才是大傻逼", @"我呸", @"曾经沧海难为水", @"除去巫山不是云", @"取次花丛懒回顾",@"哈哈 东零西碎哈哈哈 东零西碎哈哈哈 东零西碎哈哈哈 ", @"半缘修道半缘君", @"床前明月光", @"疑似地上霜", @"举头望明月", @"低头思故乡", @"人之初，性本善", @"性相近", @"习相远", @"摸摸哒，哈哈哈，嘻嘻嘻，哦哦哦，嘿嘿嘿，呀呀呀，啦啦啦，耶耶耶，呜呜呜"];
    [self.view addSubview:self.collectionView];
}

#pragma make - lazyLoader
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[MXCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
         [_collectionView registerClass:[MXCollectionViewCell class] forCellWithReuseIdentifier:kCellID];
        [_collectionView registerClass:[MXCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MXCollectionReusableView"];
    }
    return _collectionView;
}

- (MXCollectionViewLayout *)collectionViewLayout {
    if (!_collectionViewLayout) {
        _collectionViewLayout = [[MXCollectionViewLayout alloc] init];
        _collectionViewLayout.delegate = self;
    }
    return _collectionViewLayout;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    cell.textlabel.text = self.dataArray[indexPath.row];
    cell.backgroundColor = UIColor.redColor;
    return cell;
}
//
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if (![kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return nil;
    }
    MXCollectionReusableView *headerReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                      withReuseIdentifier:@"MXCollectionReusableView"
                                                                                                     forIndexPath:indexPath];
    headerReusableView.textLabel.text = self.sectionArray[indexPath.section];
    headerReusableView.backgroundColor = UIColor.greenColor;
    return headerReusableView;
}
//
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
//
- (CGSize)collectionViewItemForIndexPath:(NSIndexPath *)indexPath {
    return [self stringSize:self.dataArray[indexPath.row]];
}
//
- (CGSize)stringSize:(NSString *)string {
    if (string.length == 0) return CGSizeZero;
    UIFont * font = [UIFont systemFontOfSize:17];
    CGFloat yOffset = 3.0f;
    CGFloat width = self.collectionView.frame.size.width - 20;
    CGSize contentSize = [string boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    CGSize size = CGSizeMake(MIN(contentSize.width + 20,width) , MAX(22, contentSize.height + 2 * yOffset + 1));
    return size;
}
@end
