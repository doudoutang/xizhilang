//
//  DataBaseHandle.h
//  豆瓣
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "User.h"
#import "ActivityList.h"
#import "MovieDetail.h"
@interface DataBaseHandle : NSObject

@property (nonatomic, assign) sqlite3 *db;

@property (nonatomic, retain) NSMutableArray *dataArray;

+ (instancetype)sharedInstance;

#pragma mark  ------ 创建(连接)数据库
- (void)open;

#pragma mark ------ 创建数据库中的表
- (void)creatSql;
#pragma mark ------ 电影 ---- 创建数据库中的表
- (void)creatMovieSql;

#pragma mark ------ 用户信息 ------ 创建数据库中的表
- (void)creatUserinfoSql;

#pragma mark ------ 活动信息 ------ 创建数据库中的表
- (void)creatActivityInfo;

#pragma mark ------ 统一操作数据库信息的方法
- (void)escutesql :(NSString *)sql message:(NSString *)message;

#pragma mark ------ 向数据库中添加一条数据
- (void)addDataWithTitle:(NSString *)title userRowid:(NSInteger)userRowid content:(NSString *)content begin_time:(NSString *)begin_time end_time:(NSString *)end_time address:(NSString *)address name:(NSString *)name category_name:(NSString *)category_name image:(NSString *)image;
#pragma mark ------  电影 -----向数据库中添加一条数据
- (void)addMovieDataWithTitle:(NSString *)title userRowid:(NSInteger)userRowid movieId:(NSString *)movieId pic_url:(NSString *)pic_url;

#pragma mark ------ 用户信息 -----向数据库中添加一条数据
- (void)addUserWithUser:(User *)user;

#pragma mark ------ 删除一条数据
- (void)deleteActivityByRowid:(NSInteger)rowid;
#pragma mark ------ 电影 ------ 删除一条数据
- (void)deleteMovieByRowid:(NSInteger)rowid;

#pragma mark ------ 用户信息 ------ 删除一条数据
- (void)deleteUserDataByRowid:(NSInteger)rowid;

#pragma mark ------ 获取数据库中所有活动的信息
- (NSArray *)getAllUserActivity:(NSInteger)userRowid;
#pragma mark ------ 电影 ------ 获取数据库中所有电影的信息
- (NSArray *)getAllUserMovie:(NSInteger)userRowid;

#pragma mark ------ 删除数据
- (void)deleteAllActivityByuserRowid:(NSInteger)userRowid;

#pragma mark ------ 关闭数据库
- (void)colseDB;

#pragma mark ------ 删除电影数据
- (void)deleteAllMovieByUserRowid:(NSInteger)userRowid;

#pragma mark ------ 查询
- (User *)queryUserByUsername:(NSString *)username;

#pragma mark ------ 查询用户收藏的活动
- (ActivityList *)queryUserActivity:(NSInteger)userRowid title:(NSString *)title;

#pragma mark ------ 查询用户收藏的电影
- (MovieDetail *)queryUserMovie:(NSInteger)userRowid title:(NSString *)title;









@end
