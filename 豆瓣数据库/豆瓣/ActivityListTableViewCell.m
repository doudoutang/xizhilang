//
//  ActivityListTableViewCell.m
//  豆瓣
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ActivityListTableViewCell.h"

@implementation ActivityListTableViewCell

- (void)setActivityList:(ActivityList *)activityList {
    _titleLable.text = activityList.title;
    _category_nameLable.text = activityList.category_name;
    _addressLable.text = activityList.address;
    _wisher_countLable.text = [NSString stringWithFormat:@"%d",activityList.wisher_count];
    _participant_countLable.text = [NSString stringWithFormat:@"%d",activityList.participant_count];
    
    NSString *beginStr = activityList.begin_time;
    NSRange range = NSMakeRange(5, 11);
    _begin_timeLable.text = [beginStr substringWithRange:range];
    
    NSString *endStr = activityList.end_time;
    _end_timeLable.text = [endStr substringWithRange:range];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
