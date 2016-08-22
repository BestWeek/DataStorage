//
//  KCStatusService.h
//  DataAccess
//
//  Created by Kenshin Cui on 14-3-29.
//  Copyright (c) 2014年 Kenshin Cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KCSingleton.h"
@class KCStatus;

@interface KCStatusService : NSObject
singleton_interface(KCStatusService)

/**
 *  添加微博信息
 *
 *  @param status 微博对象
 */
-(void)addStatus:(KCStatus *)status;

/**
 *  删除微博
 *
 *  @param status 微博对象
 */
-(void)removeStatus:(KCStatus *)status;

/**
 *  修改微博内容
 *
 *  @param status 微博对象
 */
-(void)modifyStatus:(KCStatus *)status;

/**
 *  根据编号取得微博
 *
 *  @param Id 微博编号
 *
 *  @return 微博对象
 */
-(KCStatus *)getStatusById:(int)Id;

/**
 *  取得所有微博对象
 *
 *  @return 所有微博对象
 */
-(NSArray *)getAllStatus;
@end
