//
//  MovieTileCollectionViewCell.m
//  豆瓣
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieTileCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation MovieTileCollectionViewCell


- (void)setMovieList:(MovieList *)movieList {
    
    _titleLable.text = movieList.movieName;
//    _imgView.image = movieList.image;
    
    
    //_imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:movieList.pic_url]]];
}

@end
      