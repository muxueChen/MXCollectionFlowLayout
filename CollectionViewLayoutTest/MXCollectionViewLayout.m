//
//  MXCollectionViewLayout.m
//  CollectionViewLayoutTest
//
//  Created by muxue on 2019/1/3.
//  Copyright © 2019 暮雪. All rights reserved.
//

#import "MXCollectionViewLayout.h"

@interface MXCollectionViewLayout ()
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributes;
@property (nonatomic, assign) CGRect lastItemRect;
@end

@implementation MXCollectionViewLayout

- (void)initData{
    [self.attributes removeAllObjects];
    self.lastItemRect = CGRectMake(10 , 10, 0, 0);
}

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attributes{
    if (_attributes == nil) {
        _attributes = [NSMutableArray array];
    }
    return _attributes;
}

- (void)prepareLayout {
    [super prepareLayout];
    [self initData];
    ///1.首先被调用
    NSInteger cout = [self.collectionView numberOfSections];
    for (int i=0; i < cout; i++){
        [self.attributes addObject:[self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]]];
        for (int  j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++) {
            UICollectionViewLayoutAttributes * attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            [self.attributes addObject:attribute];
        }
    }
}

//
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributes;
}

//返回指定indexPath的item的布局信息。子类必须重载该方法,该方法只能为cell提供布局信息，不能为补充视图和装饰视图提供。
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //x位置
    CGFloat orx = 0;
    //y位置
    CGFloat ory = 0;
    //行间距
    CGFloat isRowDs = 0;
    //列间距
    CGFloat isColumnDs = 0;
    //第一行
    if (CGRectGetMaxX(self.lastItemRect) != 10) {
        isColumnDs = 10;
    }
    //第一列
    if (CGRectGetMaxY(self.lastItemRect) != 10) {
        isRowDs = 10;
    }
    CGSize size = [self.delegate collectionViewItemForIndexPath:indexPath];
    CGFloat maxDistance = self.collectionView.frame.size.width - CGRectGetMaxX(self.lastItemRect) - isColumnDs - 10;
    if (size.width > maxDistance) {
        orx = 10;
        ory = CGRectGetMaxY(self.lastItemRect) + isRowDs;
    } else {
        orx = CGRectGetMaxX(self.lastItemRect) + isColumnDs;
        ory = self.lastItemRect.origin.y;
    }
    attributes.frame =  CGRectMake(orx,ory,size.width, size.height);
    self.lastItemRect = attributes.frame;
    return attributes;
}

//如果你的布局支持追加视图的话，必须重载该方法，该方法返回的是追加视图的布局信息，kind这个参数区分段头还是段尾的，在collectionview注册的时候回用到该参数。
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if (![elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
    }
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
    attributes.frame = CGRectMake(10, CGRectGetMaxY(self.lastItemRect) + 10, self.collectionView.frame.size.width, 50);
    self.lastItemRect = attributes.frame;
    return attributes;
}
//
////如果你的布局支持装饰视图的话，必须重载该方法，该方法返回的是装饰视图的布局信息，ecorationViewKind这个参数在collectionview注册的时候回用到
//- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
//    return nil;
//}
// 返回 collectionView 内容的高度
- (CGSize)collectionViewContentSize{
    CGFloat maxContentHeight = self.lastItemRect.origin.y + self.lastItemRect.size.height + 10;
    return CGSizeMake(0, maxContentHeight);
}
//更新布局信息
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
@end
