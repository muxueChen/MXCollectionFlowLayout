//
//  MXCollectionViewLayout.h
//  CollectionViewLayoutTest
//
//  Created by muxue on 2019/1/3.
//  Copyright © 2019 暮雪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MXCollectionViewLayoutDelegate;

@interface MXCollectionViewLayout : UICollectionViewLayout
@property (nonatomic, weak) id<MXCollectionViewLayoutDelegate> delegate;
@end

@protocol MXCollectionViewLayoutDelegate <NSObject>
- (CGSize)collectionViewItemForIndexPath:(NSIndexPath *)indexPath;
@end
NS_ASSUME_NONNULL_END
