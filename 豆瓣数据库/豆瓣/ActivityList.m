//
//  ActivityList.m
//  豆瓣
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ActivityList.h"

@implementation ActivityList

- (instancetype)initWithTitle:(NSString *)title userRowid:(NSInteger)userRowid rowid:(NSInteger)rowid {
    
    self = [super init];
    if (self) {
        self.title = title;
        self.userRowid = userRowid;
        self.rowid = rowid;
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title userRowid:(NSInteger)userRowid rowid:(NSInteger)rowid content:(NSString *)content begin_time:(NSString *)begin_time end_time:(NSString *)end_time address:(NSString *)address name:(NSString *)name category_name:(NSString *)category_name image:(NSString *)image {
    
    self = [super init];
    if (self) {
        self.title = title;
        self.userRowid = userRowid;
        self.rowid = rowid;
        self.content = content;
        self.begin_time = begin_time;
        self.end_time = end_time;
        self.address = address;
        self.name = name;
        self.category_name = category_name;
        self.image = image;
    }
    
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description {
    NSString *str = [NSString stringWithFormat:@"%@",_title];
    return str;
}

- (void)loadImage {
    self.downLoader = [[ImageDownloader alloc] initWithImageUrl:self.image Delegate:self];
}

- (void)downloader:(ImageDownloader *)downloader didFinishLoading:(UIImage *)image {
    self.picture = image;
}

@end
