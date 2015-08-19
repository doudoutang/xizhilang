//
//  CinemaListTableViewCell.m
//  豆瓣
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CinemaListTableViewCell.h"

@implementation CinemaListTableViewCell

- (void)setCinemaList:(CinemaList *)cinemaList {
    
    _addressLable.text = cinemaList.address;
    _cinemaNameLable.text = cinemaList.cinemaName;
    _telephoneLable.text = cinemaList.telephone;
    
}

- (CGFloat)getHeightWithText:(NSString *)text
{
    CGSize size = CGSizeMake(150, 1000);
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat height = rect.size.height;
    return height;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
