//
//  MovieDetail.m
//  豆瓣
//
//  Created by lanou3g on 15/7/26.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieDetail.h"

@implementation MovieDetail

- (instancetype)initWithTitle:(NSString *)title userRowid:(NSInteger)userRowid rowid:(NSInteger)rowid {
    
    self = [super init];
    if (self) {
        self.title = title;
        self.userRowid = userRowid;
        self.rowid = rowid;
    }
    
    return self;
    
}

- (instancetype)initWithTitle:(NSString *)title userRowid:(NSInteger)userRowid rowid:(NSInteger)rowid movieId:(NSString *)movieId pic_url:(NSString *)pic_url {
    self = [super init];
    if (self) {
        self.title = title;
        self.userRowid = userRowid;
        self.rowid = rowid;
        self.movieId = movieId;
        self.pic_url = pic_url;
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@",_title];
}

@end
