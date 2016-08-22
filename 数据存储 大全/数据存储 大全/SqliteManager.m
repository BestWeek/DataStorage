//
//  SqliteManager.m
//  数据存储 大全
//
//  Created by Zen on 16/1/25.
//  Copyright © 2016年 Zen. All rights reserved.
//

#import "SqliteManager.h"
#import "QSYSingle.h"
#import "QSYSingle.h"
#import "QSYAppConfig.h"
#ifndef kDatabaseName
#define kDatabaseName @"myDatabase.db"
#endif
@implementation SqliteManager
//实现数据库管理者对象的方法
singleton_implementation(SqliteManager)
#pragma mark 重写初始化方法
-(instancetype)init{
    SqliteManager *manager;
    if((manager=[super init]))
    {
        [manager openDb:kDatabaseName];
    }
    return manager;
}

-(void)openDb:(NSString *)dbname{
    //取得数据库保存路径，通常保存沙盒Documents目录
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"%@",directory);
    NSString *addFile = [directory stringByAppendingPathComponent:@"DataBase"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:addFile]) {
        if (![[NSFileManager defaultManager]createDirectoryAtPath:addFile withIntermediateDirectories:YES attributes:nil error:nil]) {
            NSLog(@"创建文件夹失败");
        }
    }
      NSString *filePath=[addFile stringByAppendingPathComponent:dbname];
    //如果有数据库则直接打开，否则创建并打开（注意filePath是ObjC中的字符串，需要转化为C语言字符串类型）
    if (SQLITE_OK ==sqlite3_open(filePath.UTF8String, &_database)) {
        NSLog(@"数据库打开成功!");
    }else{
        NSLog(@"数据库打开失败!");
    }
}

-(void)executeNonQuery:(NSString *)sql{
    char *error;
    //单步执行sql语句，用于插入、修改、删除
    if (SQLITE_OK!=sqlite3_exec(_database, sql.UTF8String, NULL, NULL,&error)) {
        NSLog(@"执行SQL语句过程中发生错误！错误信息：%s",error);
    }
}

-(NSArray *)executeQuery:(NSString *)sql{
    NSMutableArray *rows=[NSMutableArray array];//数据行
    
    //评估语法正确性
    sqlite3_stmt *stmt;
    //检查语法正确性
    if (SQLITE_OK==sqlite3_prepare_v2(_database, sql.UTF8String, -1, &stmt, NULL)) {
        //单步执行sql语句
        while (SQLITE_ROW==sqlite3_step(stmt)) {
            int columnCount= sqlite3_column_count(stmt);
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            for (int i=0; i<columnCount; i++) {
                const char *name= sqlite3_column_name(stmt, i);//取得列名
                const unsigned char *value= sqlite3_column_text(stmt, i);//取得某列的值
                dic[[NSString stringWithUTF8String:name]]=[NSString stringWithUTF8String:(const char *)value];
            }
            [rows addObject:dic];
        }

    }
    
    //释放句柄
    sqlite3_finalize(stmt);
    
    return rows;
}

@end
