//
//  MovieList.h
//  豆瓣
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageDownloaderDelegate.h"
#import "ImageDownloader.h"
@interface MovieList : NSObject<ImageDownloaderDelegate>

@property (nonatomic, retain) NSString *movieName;

@property (nonatomic, retain) NSString *pic_url;

@property (nonatomic, retain) UIImage *image;

@property (nonatomic, retain) ImageDownloader *downloader;

@property (nonatomic, retain) NSString *movieId;

- (void)loadImage;

@end
