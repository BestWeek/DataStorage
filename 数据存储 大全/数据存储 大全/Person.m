//
//  Person.m
//  数据存储 大全
//
//  Created by Zen on 16/1/22.
//  Copyright © 2016年 Zen. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeInt64:_age forKey:@"age" ];
    [aCoder encodeFloat:_height forKey:@"height"];
    [aCoder encodeObject:_birthday forKey:@"birthday"];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = (int)[aDecoder decodeInt64ForKey:@"age"];
        self.height = [aDecoder decodeFloatForKey:@"heiht"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
    }
    return self;
}
//重写描述
- (NSString *)description {
//   nsdate 涉及到的格式必须得用日期格式来定义好，否则会显示默认的
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    dataFormatter.dateFormat = @"yyyy-MM-dd";
    return [NSString stringWithFormat:@"name = %@,age=%i,height=%.2f,birthday=%@",_name,_age,_height,[dataFormatter stringFromDate:_birthday]];
}
@end
