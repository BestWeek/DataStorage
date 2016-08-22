//
//  DatabaseCreator.h
//  数据存储 大全
//
//  Created by Zen on 16/1/25.
//  Copyright © 2016年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseCreator : NSObject

/*
 * 初始化数据库：若没有数据，执行sqlite查询语句
 */
+ (void)initDatabase;
@end
