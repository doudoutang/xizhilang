//
//  ImageDownloader.m
//  豆瓣
//
//  Created by lanou3g on 15/7/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

- (instancetype)initWithImageUrl:(NSString *)urlString Delegate:(id<ImageDownloaderDelegate>)delegate {
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
           
            UIImage *image = [UIImage imageWithData:data];
            
            [delegate downloader:self didFinishLoading:image];
            
        }];
    }
    return self;
}

@end
