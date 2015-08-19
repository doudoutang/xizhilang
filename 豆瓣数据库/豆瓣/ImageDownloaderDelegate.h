//
//  ImageDownloaderDelegate.h
//  豆瓣
//
//  Created by lanou3g on 15/7/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ImageDownloader;
@protocol ImageDownloaderDelegate <NSObject>

- (void)downloader:(ImageDownloader *)downloader didFinishLoading:(UIImage *)image;

@end
