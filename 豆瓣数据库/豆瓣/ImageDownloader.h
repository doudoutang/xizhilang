//
//  ImageDownloader.h
//  豆瓣
//
//  Created by lanou3g on 15/7/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloaderDelegate.h"
#import <UIKit/UIKit.h>
@interface ImageDownloader : NSObject

- (instancetype)initWithImageUrl:(NSString *)urlString Delegate:(id<ImageDownloaderDelegate>)delegate;

@end
