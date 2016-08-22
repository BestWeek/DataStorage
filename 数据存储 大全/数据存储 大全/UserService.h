//
//  UserService.h
//  数据存储 大全
//
//  Created by qsyMac on 16/1/25.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QSYSingle.h"
@class User;
@interface UserService : NSObject
singleton_interface(UserService)
/**
 *  添加用户信息
 *
 *  @param status 用户对象
 */
-(void)addUser:(User *)user;

/**
 *  删除用户
 *
 *  @param status 用户对象
 */
-(void)removeUser:(User *)user;

/**
 *  根据用户名删除用户
 *
 *  @param name 用户名
 */
-(void)removeUserByName:(NSString *)name;

/**
 *  修改用户内容
 *
 *  @param status 用户对象
 */
-(void)modifyUser:(User *)user;

/**
 *  根据用户编号取得用户
 *
 *  @param Id 用户编号
 *
 *  @return 用户对象
 */
-(User *)getUserById:(int)Id;

/**
 *  根据用户名取得用户
 *
 *  @param name 用户名
 *
 *  @return 用户对象
 */
-(User *)getUserByName:(NSString *)name;
@end
