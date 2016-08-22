//
//  SqliteManager.h
//  数据存储 大全
//
//  Created by Zen on 16/1/25.
//  Copyright © 2016年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "QSYSingle.h"

@interface SqliteManager : NSObject
//声明数据库管理者为单利
singleton_interface(SqliteManager);
//数据库引用，使用它进行数据库操作
@property (nonatomic) sqlite3 *database;

#pragma mark - 共有方法
/**
 *  打开数据库
 *
 *  @param dbname 数据库名称
 */
- (void)openDb:(NSString *)dbName;

/**
 *  执行无返回值的sql
 *
 *  @param sql sql语句
 */
-(void)executeNonQuery:(NSString *)sql;

/**
 *  执行有返回值的sql
 *
 *  @param sql sql语句
 *
 *  @return 查询结果
 */
-(NSArray *)executeQuery:(NSString *)sql;

@end
