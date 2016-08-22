//
//  Status.h
//  数据存储 大全
//
//  Created by Zen on 16/1/25.
//  Copyright © 2016年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface Status : NSObject
#pragma mark - 属性
@property (nonatomic,strong) NSNumber *Id;//微博id
@property (nonatomic,strong) User *user;//发送用户
@property (nonatomic,copy) NSString *createdAt;//创建时间
@property (nonatomic,copy) NSString *source;//设备来源
@property (nonatomic,copy) NSString *text;//微博内容

#pragma mark - 动态方法
//附带一部分参数的init方法
-(Status *)initWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text user:(User *)user;
//除了不含user参数的初始化方法
-(Status *)initWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text userId:(int)userId;
-(Status *)initWithDictionary:(NSDictionary *)dic;

#pragma mark - 静态方法

+(Status *)statusWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text user:(User *)user;

+(Status *)statusWithCreateAt:(NSString *)createAt source:(NSString *)source text:(NSString *)text userId:(int)userId;
@end
