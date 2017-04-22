//
//  LCEventTableViewCell.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/7/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCEventTableViewCell.h"

@implementation LCEventTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _imageIcon.layer.cornerRadius = 20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
