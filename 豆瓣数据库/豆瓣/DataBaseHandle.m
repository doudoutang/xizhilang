//
//  DataBaseHandle.m
//  豆瓣
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DataBaseHandle.h"
@implementation DataBaseHandle

+ (instancetype)sharedInstance {
    static DataBaseHandle *DBHandle = nil;
    @synchronized(self) {
        if (nil == DBHandle) {
            DBHandle = [[DataBaseHandle alloc] init];
        }
        return DBHandle;
    }
    
}

#pragma mark  ------ 创建(连接)数据库
- (void)open {
    //生成存放在沙盒中的数据库的路径
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *strPath = [documentsPath stringByAppendingPathComponent:@"native.db"];
    NSLog(@"%@",strPath);
    //创建一个数据库并连接
    int result = sqlite3_open(strPath.UTF8String, &_db);
    if (result == SQLITE_OK) {
        NSLog(@"创建成功");
    }else {
        NSLog(@"创建失败  %d",result);
    }
    
}

#pragma mark ------ 创建数据库中的表
- (void)creatSql {
    
    //1.准备创建表的SQL语句
    NSString *createSql = @"CREATE TABLE activityCollect (title TEXT, userRowid NSINTEGER, content text, begin_time text, end_time text, address text, name text, category_name text, image text)";
    //2.执行sql语句
    char *errmsg = NULL;
    int result = sqlite3_exec(_db, createSql.UTF8String, NULL, NULL, &errmsg);
    if (result == SQLITE_OK) {
        NSLog(@"创建表成功");
    }else {
        NSLog(@"创建表失败 %s",errmsg);
    }
    
}

#pragma mark ------ 电影 ---- 创建数据库中的表
- (void)creatMovieSql {
    
    //1.准备创建表的SQL语句
    NSString *createSql = @"CREATE TABLE movieCollect (title TEXT, userRowid NSINTEGER, movieId TEXT, pic_url TEXT)";
    //2.执行sql语句
    char *errmsg = NULL;
    int result = sqlite3_exec(_db, createSql.UTF8String, NULL, NULL, &errmsg);
    if (result == SQLITE_OK) {
        NSLog(@"创建表成功");
    }else {
        NSLog(@"创建表失败 %s",errmsg);
    }
    
}

#pragma mark ------ 用户信息 ------ 创建数据库中的表
- (void)creatUserinfoSql {
    
    //1.准备创建表的SQL语句
    NSString *createSql = @"CREATE TABLE userinfo (username TEXT, password TEXT, mail TEXT, telephone TEXT)";
    //2.执行sql语句
    char *errmsg = NULL;
    int result = sqlite3_exec(_db, createSql.UTF8String, NULL, NULL, &errmsg);
    if (result == SQLITE_OK) {
        NSLog(@"创建表成功");
    }else {
        NSLog(@"创建表失败 %s",errmsg);
    }
    
}

#pragma mark ------ 活动信息 ------ 创建数据库中的表
- (void)creatActivityInfo {
    
    NSString *sql = @"creat table activityInfo (title text, content text, begin_time text, end_time text, address text, name text, category_name text, image text)";
    
    char *errmsg = NULL;
    int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errmsg);
    if (result == SQLITE_OK) {
        NSLog(@"创建活动表成功");
    }else {
        NSLog(@"创建活动表失败 %s",errmsg);
    }
}

#pragma mark ------ 统一操作数据库信息的方法
- (void)escutesql :(NSString *)sql message:(NSString *)message {
    char *errmsg = NULL;
    int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errmsg);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"%@成功",message);
    }else {
        NSLog(@"%@失败 %s",message,errmsg);
    }
    
}

#pragma mark ------ 向数据库中添加一条数据
- (void)addDataWithTitle:(NSString *)title userRowid:(NSInteger)userRowid content:(NSString *)content begin_time:(NSString *)begin_time end_time:(NSString *)end_time address:(NSString *)address name:(NSString *)name category_name:(NSString *)category_name image:(NSString *)image {
    //1.准备sql语句
    NSString *insertSql = [NSString stringWithFormat:@"insert into activityCollect(title, userRowid, content, begin_time, end_time, address, name, category_name, image)values('%@','%ld','%@','%@','%@','%@','%@','%@','%@')",title,userRowid,content,begin_time,end_time,address,name,category_name,image];
    //2.执行sql语句
    [self escutesql:insertSql message:@"添加一条活动数据"];
    
}

#pragma mark ------  电影 -----向数据库中添加一条数据
- (void)addMovieDataWithTitle:(NSString *)title userRowid:(NSInteger)userRowid movieId:(NSString *)movieId pic_url:(NSString *)pic_url {
    //1.准备sql语句
    NSString *insertSql = [NSString stringWithFormat:@"insert into movieCollect(title,userRowid,movieId,pic_url)values('%@','%ld','%@','%@')",title,userRowid,movieId,pic_url];
    
    //2.执行sql语句
    [self escutesql:insertSql message:@"添加一条电影数据"];
}


#pragma mark ------  用户信息 -----向数据库中添加一条数据
- (void)addUserWithUser:(User *)user
{
    
    NSString *insertSql = [NSString stringWithFormat:@"insert into userinfo(username,password,mail,telephone)values('%@','%@','%@','%@')",user.username,user.password,user.mail,user.telephone];
    
    [self escutesql:insertSql message:@"增加用户信息"];
}

#pragma mark ------ 删除一条数据
- (void)deleteActivityByRowid:(NSInteger)rowid {
    //1.准备sql语句
    NSString *deleteSql = [NSString stringWithFormat:@"delete from activityCollect where rowid = '%ld'",rowid];
    //2.执行sql语句
    [self escutesql:deleteSql message:@"删除活动数据"];
}

#pragma mark ------ 电影 ------ 删除一条数据
- (void)deleteMovieByRowid:(NSInteger)rowid {
    //1.准备sql语句
    NSString *deleteSql = [NSString stringWithFormat:@"delete from movieCollect where rowid = '%ld'",rowid];
    //2.执行sql语句
    [self escutesql:deleteSql message:@"删除电影数据"];
}

#pragma mark ------ 用户信息 ------ 删除一条数据
- (void)deleteUserDataByRowid:(NSInteger)rowid {
    //1.准备sql语句
    NSString *deleteSql = [NSString stringWithFormat:@"delete from userinfo where rowid = '%ld'",rowid];
    //2.执行sql语句
    [self escutesql:deleteSql message:@"删除数据"];
}

#pragma mark ------ 删除活动数据
- (void)deleteAllActivityByuserRowid:(NSInteger)userRowid {
    NSString *deleteSql = [NSString stringWithFormat:@"delete from activityCollect where userRowid = '%ld'",userRowid];
    [self escutesql:deleteSql message:@"删除用户收藏的活动"];
}

#pragma mark ------ 删除电影数据
- (void)deleteAllMovieByUserRowid:(NSInteger)userRowid {
    NSString *deleteSql = [NSString stringWithFormat:@"delete from movieCollect where userRowid = '%ld'",userRowid];
    [self escutesql:deleteSql message:@"删除用户收藏的电影"];
}

#pragma mark ------ 关闭数据库
- (void)colseDB {
    int result = sqlite3_close(_db);
    if (result == SQLITE_OK) {
        NSLog(@"关闭成功");
    }else {
        NSLog(@"关闭失败");
    }
}

#pragma mark ------ 取出所有数据
- (NSArray *)queryDataBySql:(NSString *)sql {
    
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare(_db, sql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        self.dataArray = [NSMutableArray array];
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            [_dataArray addObject:title];
        }
    }
    sqlite3_finalize(stmt);
    return _dataArray;
}

#pragma mark ------ 获取数据库中所有活动的信息
- (NSArray *)getAllUserActivity:(NSInteger)userRowid {
    NSString *sql = [NSString stringWithFormat:@"select rowid, title, userRowid, content, begin_time, end_time, address, name, category_name, image from activityCollect where userRowid = '%ld'",userRowid];
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare(_db, sql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        self.dataArray = [NSMutableArray array];
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            NSInteger rowid = sqlite3_column_int(stmt, 0);
            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSInteger userRowid = sqlite3_column_int(stmt, 2);
            NSString *content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            NSString *begin_time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            NSString *end_time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            NSString *address = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
            NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
            NSString *category_name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 8)];
            NSString *image = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 9)];

            ActivityList * activityList = [[ActivityList alloc] initWithTitle:title userRowid:userRowid rowid:rowid content:content begin_time:begin_time end_time:end_time address:address name:name category_name:category_name image:image];
            [_dataArray addObject:activityList];
        }
    }
    return _dataArray;
}

#pragma mark ------ 电影 ------ 获取数据库中所有电影的信息
- (NSArray *)getAllUserMovie:(NSInteger)userRowid {
    
    NSString *sql = [NSString stringWithFormat:@"select rowid, title, userRowid, movieId, pic_url from movieCollect where userRowid = '%ld'",userRowid];
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare(_db, sql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        self.dataArray = [NSMutableArray array];
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            NSInteger rowid = sqlite3_column_int(stmt, 0);
            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSInteger userRowid = sqlite3_column_int(stmt, 2);
            NSString *movieId = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            NSString *pic_url = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            MovieDetail *movieDetail = [[MovieDetail alloc] initWithTitle:title userRowid:userRowid rowid:rowid movieId:movieId pic_url:pic_url];
            [_dataArray addObject:movieDetail];
        }
    }
    return _dataArray;
}
#pragma mark ------ 查询数据按照用户名
- (NSArray *)queryDataWithUsername:(NSString *)username {
    NSString *sql = [NSString stringWithFormat:@"select *from activityCollect where username = '%@'",username];
    NSArray *array = [self queryDataBySql:sql];
    return array;
}

#pragma mark ------ 查询
- (User *)queryUserByUsername:(NSString *)username {
    
    NSString *sql = [NSString stringWithFormat:@"select *,rowid from userinfo where username = '%@' limit 1",username];
    User *user = nil;
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare(_db, sql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
        if (SQLITE_ROW == sqlite3_step(stmt)) {
            NSString *username = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            NSString *password = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSString *mail = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            NSString *telephone = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            NSInteger userRowid = sqlite3_column_int(stmt, 4);
            user = [[User alloc] initWithUsername:username password:password mail:mail telephone:telephone userRowid:userRowid];
        }
    }
    sqlite3_finalize(stmt);
    
    return user;
    
}

#pragma mark ------ 查询用户收藏的活动
- (ActivityList *)queryUserActivity:(NSInteger)userRowid title:(NSString *)title {
    
    NSString *sql = [NSString stringWithFormat:@"select rowid,title,userRowid from activityCollect where title = '%@' and userRowid = '%ld'",title,userRowid];
    ActivityList *activityList = nil;
    
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare(_db, sql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
        if (SQLITE_ROW == sqlite3_step(stmt)) {
            NSInteger rowid = sqlite3_column_int(stmt, 0);
            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSInteger userRowid = sqlite3_column_int(stmt, 2);
            activityList = [[ActivityList alloc] initWithTitle:title userRowid:userRowid rowid:rowid];
        }
    }
    sqlite3_finalize(stmt);
    
    return activityList;
    
}

#pragma mark ------ 查询用户收藏的电影
- (MovieDetail *)queryUserMovie:(NSInteger)userRowid title:(NSString *)title {
    NSString *sql = [NSString stringWithFormat:@"select rowid,title,userRowid from movieCollect where title = '%@' and userRowid = '%ld'",title,userRowid];
    MovieDetail *movieDetail = nil;
    
    sqlite3_stmt *stmt = NULL;
    int result = sqlite3_prepare(_db, sql.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        if (SQLITE_ROW == sqlite3_step(stmt)) {
            NSInteger rowid = sqlite3_column_int(stmt, 0);
            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSInteger userRowid = sqlite3_column_int(stmt, 2);
            movieDetail = [[MovieDetail alloc] initWithTitle:title userRowid:userRowid rowid:rowid];
        }
    }
    sqlite3_finalize(stmt);
    return movieDetail;
}














@end
