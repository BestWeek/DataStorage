//
//  StatusService.m
//  数据存储 大全
//
//  Created by qsyMac on 16/1/25.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "StatusService.h"
#import "Status.h"
#import "User.h"
#import "UserService.h"
#import "SqliteManager.h"
@implementation StatusService

singleton_implementation(StatusService)

-(void)addStatus:(Status *)status{
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO Status (source,createdAt,\"text\" ,user) VALUES('%@','%@','%@','%@')",status.source,status.createdAt,status.text,status.user.Id];
    [[SqliteManager sharedSqliteManager] executeNonQuery:sql];
}

-(void)removeStatus:(Status *)status{
    NSString *sql=[NSString stringWithFormat:@"DELETE FROM Status WHERE Id='%@'",status.Id];
    [[SqliteManager sharedSqliteManager] executeNonQuery:sql];
}

-(void)modifyStatus:(Status *)status{
    NSString *sql=[NSString stringWithFormat:@"UPDATE Status SET source='%@',createdAt='%@',\"text\"='%@' ,user='%@' WHERE Id='%@'",status.source,status.createdAt,status.text,status.user, status.Id];
    [[SqliteManager sharedSqliteManager] executeNonQuery:sql];
}

-(Status *)getStatusById:(int)Id{
    Status *status=[[Status alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT Id, source,createdAt,\"text\" ,user FROM Status WHERE Id='%i'", Id];
    NSArray *rows= [[SqliteManager sharedSqliteManager] executeQuery:sql];
    if (rows&&rows.count>0) {
        [status setValuesForKeysWithDictionary:rows[0]];
        status.user=[[UserService sharedUserService] getUserById:[(NSNumber *)rows[0][@"user"] intValue]] ;
    }
    return status;
}

-(NSArray *)getAllStatus{
    NSMutableArray *array=[NSMutableArray array];
    NSString *sql=@"SELECT Id, source,createdAt,\"text\" ,user FROM Status ORDER BY Id";
    NSArray *rows= [[SqliteManager sharedSqliteManager] executeQuery:sql];
    for (NSDictionary *dic in rows) {
        Status *status=[self getStatusById:[(NSNumber *)dic[@"Id"] intValue]];
        [array addObject:status];
    }
    return array;
}

@end
