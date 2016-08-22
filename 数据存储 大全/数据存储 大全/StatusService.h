//
//  StatusService.h
//  数据存储 大全
//
//  Created by qsyMac on 16/1/25.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QSYSingle.h"
@class Status;
@interface StatusService : NSObject
singleton_interface(StatusService)

/**
 *  添加微博信息
 *
 *  @param status 微博对象
 */
-(void)addStatus:(Status *)status;

/**
 *  删除微博
 *
 *  @param status 微博对象
 */
-(void)removeStatus:(Status *)status;

/**
 *  修改微博内容
 *
 *  @param status 微博对象
 */
-(void)modifyStatus:(Status *)status;

/**
 *  根据编号取得微博
 *
 *  @param Id 微博编号
 *
 *  @return 微博对象
 */
-(Status *)getStatusById:(int)Id;

/**
 *  取得所有微博对象
 *
 *  @return 所有微博对象
 */
-(NSArray *)getAllStatus;

@end
