//
//  Student.m
//  数据存储 大全
//
//  Created by Zen on 16/1/22.
//  Copyright © 2016年 Zen. All rights reserved.
//

#import "Student.h"

@implementation Student
// 自定义类型转变为NSData类型
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.number forKey:@"number"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.number = [aDecoder decodeObjectForKey:@"number"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
    }
    return self;
}
@end
