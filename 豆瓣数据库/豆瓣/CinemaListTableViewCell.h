//
//  CinemaListTableViewCell.h
//  豆瓣
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinemaList.h"
@interface CinemaListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *cinemaNameLable;

@property (strong, nonatomic) IBOutlet UILabel *addressLable;

@property (strong, nonatomic) IBOutlet UILabel *telephoneLable;

@property (nonatomic, retain) CinemaList *cinemaList;

- (CGFloat)getHeightWithText:(NSString *)text;

@end
