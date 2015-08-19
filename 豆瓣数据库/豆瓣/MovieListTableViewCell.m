//
//  MovieListTableViewCell.m
//  豆瓣
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieListTableViewCell.h"

@implementation MovieListTableViewCell


- (void)setMovieList:(MovieList *)movieList {
   
    _movieNameLable.text = movieList.movieName;
    _imgView.image = movieList.image;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
