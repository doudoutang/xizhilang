//
//  ActivityListTableViewCell.h
//  豆瓣
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityList.h"
@interface ActivityListTableViewCell : UITableViewCell

@property (nonatomic, retain)ActivityList *activityList;

@property (strong, nonatomic) IBOutlet UILabel *begin_timeLable;

@property (strong, nonatomic) IBOutlet UILabel *titleLable;

@property (strong, nonatomic) IBOutlet UILabel *addressLable;

@property (strong, nonatomic) IBOutlet UILabel *category_nameLable;

@property (strong, nonatomic) IBOutlet UILabel *wisher_countLable;

@property (strong, nonatomic) IBOutlet UILabel *participant_countLable;

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *end_timeLable;





@end
