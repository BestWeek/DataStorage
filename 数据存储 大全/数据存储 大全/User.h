//
//  User.h
//  数据存储 大全
//
//  Created by Zen on 16/1/25.
//  Copyright © 2016年 Zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
//Id，name，screenName，profileImageUrl，mbtype，city

#pragma mark 编号
@property (nonatomic,strong) NSNumber *Id;

#pragma mark 用户名
@property (nonatomic,copy) NSString *name;

#pragma mark 用户昵称
@property (nonatomic,copy) NSString *screenName;

#pragma mark 头像
@property (nonatomic,copy) NSString *profileImageUrl;

#pragma mark 会员类型
@property (nonatomic,copy) NSString *mbtype;

#pragma mark 城市
@property (nonatomic,copy) NSString *city;

// 创建User的便利构造器方法：附带了所有的参数
-(User *)initWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city;

// 创建User的便利构造器方法，含有dic参数
-(User *)initWithDictionary:(NSDictionary *)dic;

#pragma mark - 静态方法
// 创建User的便利构造器静态方法：附带了所有的参数
+(User *)userWithName:(NSString *)name screenName:(NSString *)screenName profileImageUrl:(NSString *)profileImageUrl mbtype:(NSString *)mbtype city:(NSString *)city;


@end
