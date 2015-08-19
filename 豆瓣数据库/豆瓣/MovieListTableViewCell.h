//
//  MovieListTableViewCell.h
//  豆瓣
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieList.h"
@interface MovieListTableViewCell : UITableViewCell

@property (nonatomic, retain) MovieList *movieList;

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *movieNameLable;


@end
