//
//  User.m
//  豆瓣
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "User.h"

@implementation User

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password mail:(NSString *)mail telephone:(NSString *)telephone userRowid:(NSInteger)userRowid {
    self = [super init];
    if (self) {
        self.username = username;
        self.telephone = telephone;
        self.mail = mail;
        self.password = password;
        self.userRowid = userRowid;
    }
    return self;
}

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password mail:(NSString *)mail telephone:(NSString *)telephone {
    
    self = [super init];
    if (self) {
        self.username = username;
        self.telephone = telephone;
        self.mail = mail;
        self.password = password;
    }
    return self;
}

@end
