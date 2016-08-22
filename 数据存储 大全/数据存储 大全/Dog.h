//
//  Dog.h
//  数据存储 大全
//
//  Created by qsyMac on 16/1/24.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dog : NSObject
@property (nonatomic, strong)NSString *name;
@property (nonatomic, assign)float weight;
- (void)executeSelector;
@end
