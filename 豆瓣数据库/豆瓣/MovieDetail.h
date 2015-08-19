//
//  MovieDetail.h
//  豆瓣
//
//  Created by lanou3g on 15/7/26.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieDetail : NSObject

@property (nonatomic, retain) NSString *plot_simple;

@property (nonatomic, retain) NSString *title;

@property (nonatomic, retain) NSString *genres;

@property (nonatomic, retain) NSString *country;

@property (nonatomic, retain) NSString *runtime;

@property (nonatomic, retain) NSString *poster;

@property (nonatomic, retain) NSString *rating_count;

@property (nonatomic, retain) NSString *rating;

@property (nonatomic, retain) NSString *release_date;

@property (nonatomic, retain) NSString *actors;

@property (nonatomic, assign) NSInteger userRowid;

@property (nonatomic, assign) NSInteger rowid;

@property (nonatomic, retain) NSString *movieId;

@property (nonatomic, retain) NSString *pic_url;


- (instancetype)initWithTitle:(NSString *)title userRowid:(NSInteger)userRowid rowid:(NSInteger)rowid;

- (instancetype)initWithTitle:(NSString *)title userRowid:(NSInteger)userRowid rowid:(NSInteger)rowid movieId:(NSString *)movieId pic_url:(NSString *)pic_url;

@end
