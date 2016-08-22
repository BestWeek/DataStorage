//
//  DatabaseCreator.m
//  数据存储 大全
//
//  Created by Zen on 16/1/25.
//  Copyright © 2016年 Zen. All rights reserved.
//

#import "DatabaseCreator.h"
#import "SqliteManager.h"
@implementation DatabaseCreator
+ (void)initDatabase {
    NSString *key = @"IsCreatedDb";
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    if ([[defaults valueForKey:key] intValue] !=1) {//未创建数据库
        [self createUserTable];
        [self createStatusTable];
        [defaults setValue:@1 forKey:key];
    }
}

+(void)createUserTable{
//    sqlite 语句里参数：Id（NSNumber类型，其他的为字符串），name，screenName，profileImageUrl，mbtype，city。
    NSString *sql = @"CREATE TABLE User (Id integer PRIMARY KEY AUTOINCREMENT,name text,screenName text, profileImageUrl text,mbtype text,city text)";
    [[SqliteManager sharedSqliteManager] executeNonQuery:sql];
}

+(void)createStatusTable {
    //    sqlite 语句里参数：Id(NSNumber)，source，createdAt，\"text\"，user integer REFERENCES User (Id)。
    NSString *sql = @"CREATE TABLE Status (Id integer PRIMARY KEY AUTOINCREMENT,source text,createdAt date,\"text\" text,user integer REFERENCES User (Id))";
    [[SqliteManager sharedSqliteManager]executeNonQuery:sql];
}
@end
