//
//  UserService.m
//  数据存储 大全
//
//  Created by qsyMac on 16/1/25.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "UserService.h"
#import "SqliteManager.h"
#import "User.h"
@implementation UserService
singleton_implementation(UserService)

//添加用户:到数据库sqlite里
-(void)addUser:(User *)user{
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO User (name,screenName, profileImageUrl,mbtype,city) VALUES('%@','%@','%@','%@','%@')",user.name,user.screenName, user.profileImageUrl,user.mbtype,user.city];
    [[SqliteManager sharedSqliteManager] executeNonQuery:sql];
}
//根据用户的id移除user
-(void)removeUser:(User *)user{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM User WHERE Id='%@'",user.Id];
    [[SqliteManager sharedSqliteManager] executeNonQuery:sql];
}
//通过name移除user
-(void)removeUserByName:(NSString *)name{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM User WHERE name='%@'",name];
    [[SqliteManager sharedSqliteManager] executeNonQuery:sql];
}
//修改用户
-(void)modifyUser:(User *)user{
    NSString *sql=[NSString stringWithFormat:@"UPDATE User SET name='%@',screenName='%@',profileImageUrl='%@',mbtype='%@',city='%@' WHERE Id='%@'",user.name,user.screenName,user.profileImageUrl,user.mbtype,user.city,user.Id];
    [[SqliteManager sharedSqliteManager] executeNonQuery:sql];
}

//通过id获取到user
-(User *)getUserById:(int)Id{
    User *user=[[User alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT name,screenName,profileImageUrl,mbtype,city FROM User WHERE Id='%i'", Id];
    NSArray *rows= [[SqliteManager sharedSqliteManager] executeQuery:sql];
    if (rows&&rows.count>0) {
        [user setValuesForKeysWithDictionary:rows[0]];
    }
    return user;
}

-(User *)getUserByName:(NSString *)name{
    User *user=[[User alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT Id, name,screenName,profileImageUrl,mbtype,city FROM User WHERE name='%@'", name];
    NSArray *rows= [[SqliteManager sharedSqliteManager] executeQuery:sql];
    if (rows&&rows.count>0) {
        [user setValuesForKeysWithDictionary:rows[0]];
    }
    return user;
}
@end
