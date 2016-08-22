//
//  Engineer.m
//  数据存储 大全
//
//  Created by qsyMac on 16/1/24.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "Engineer.h"

@implementation Engineer
-(NSString *)description{
    return [NSString stringWithFormat:@"name=%@,height=%f",_name,_height];
}
//实现copy方法
- (instancetype)copyWithZone:(NSZone *)zone {
    //注意zone是系统已经分配好的用于存储当前对象的内存
    //注意下面创建对象最好不要用[[Engineer allocWithZone:zone]init]，因为子类如果没有实现该方法copy时会调用父类的copy方法，此时需要使用子类对象初始化如果此时用self就可以表示子类对象，还有就是如果子类调用了父类的这个方法进行重写copy也需要调用子类对象而不是父类Engineer
    Engineer *engineer = [[[self class] allocWithZone:zone]init];
    engineer.name = _name;
    engineer.height = _height;
    return engineer;
}
@end
