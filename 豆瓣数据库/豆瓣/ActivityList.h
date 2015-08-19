//
//  ActivityList.h
//  豆瓣
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageDownloaderDelegate.h"
#import "ImageDownloader.h"
@interface ActivityList : NSObject<ImageDownloaderDelegate>

@property (nonatomic, retain) NSString *end_time;

@property (nonatomic, retain) NSString *begin_time;

@property (nonatomic, retain) NSString *address;

@property (nonatomic, retain) NSString *category_name;

@property (nonatomic, assign) int wisher_count;

@property (nonatomic, assign) int participant_count;

@property (nonatomic, retain) NSString *title;

@property (nonatomic, retain) NSString *image;

@property (nonatomic, retain) UIImage *picture;

@property (nonatomic, retain) ImageDownloader *downLoader;

@property (nonatomic, retain) NSString *content;

@property (nonatomic, retain) NSString *name;

@property (nonatomic, strong) NSString *pic_url;

@property (nonatomic, assign) NSInteger userRowid;

@property (nonatomic, assign) NSInteger rowid;

- (instancetype)initWithTitle:(NSString *)title userRowid:(NSInteger)userRowid rowid:(NSInteger)rowid;

- (instancetype)initWithTitle:(NSString *)title userRowid:(NSInteger)userRowid rowid:(NSInteger)rowid content:(NSString *)content begin_time:(NSString *)begin_time end_time:(NSString *)end_time address:(NSString *)address name:(NSString *)name category_name:(NSString *)category_name image:(NSString *)image;

- (void)loadImage;

@end
