//
//  User.h
//  豆瓣
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, retain) NSString *username;

@property (nonatomic, retain) NSString *password;

@property (nonatomic, retain) NSString *confirmPassword;

@property (nonatomic, retain) NSString *mail;

@property (nonatomic, retain) NSString *telephone;

@property (nonatomic, assign) NSInteger userRowid;

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password mail:(NSString *)mail telephone:(NSString *)telephone userRowid:(NSInteger)userRowid;
- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password mail:(NSString *)mail telephone:(NSString *)telephone;
@end
