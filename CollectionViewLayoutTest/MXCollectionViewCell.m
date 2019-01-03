//
//  MXCollectionViewCell.m
//  CollectionViewLayoutTest
//
//  Created by muxue on 2019/1/3.
//  Copyright © 2019 暮雪. All rights reserved.
//

#import "MXCollectionViewCell.h"

@implementation MXCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textlabel = [UILabel new];
        self.textlabel.frame = self.bounds;
        self.textlabel.font = [UIFont systemFontOfSize:17];
        self.textlabel.numberOfLines = 0;
        [self.contentView addSubview:self.textlabel];
        self.textlabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.textlabel.frame = self.bounds;
}
@end
