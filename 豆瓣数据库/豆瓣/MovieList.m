//
//  MovieList.m
//  豆瓣
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieList.h"

@implementation MovieList

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)loadImage {
    
    self.downloader = [[ImageDownloader alloc] initWithImageUrl:_pic_url Delegate:self];
    
}

- (void)downloader:(ImageDownloader *)downloader didFinishLoading:(UIImage *)image {
    
    self.image = image;
    
}

@end
