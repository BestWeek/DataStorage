//
//  Engineer.h
//  数据存储 大全
//
//  Created by qsyMac on 16/1/24.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Dog;
@interface Engineer : NSObject<NSCopying>
@property (nonatomic, strong)Dog *dog;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) int workTime;
@property (nonatomic,assign) float height;
@end
