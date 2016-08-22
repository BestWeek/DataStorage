//
//  KeyedArchiverViewController.m
//  数据存储 大全
//
//  Created by Zen on 16/1/22.
//  Copyright © 2016年 Zen. All rights reserved.
//

#import "KeyedArchiverViewController.h"
#import "Person.h"
//适用对象： NSKeyedArchiver适合所有ObjC对象。自定义对象的也可以用，只要遵守了NSCoding协议，实现了编码和解码方法。

@interface KeyedArchiverViewController ()

@end

@implementation KeyedArchiverViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 200, 30);
    [button setTitle:@"归档" forState:UIControlStateNormal ];
    [button addTarget:self action:@selector(getArchiver:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)getArchiver:(UIButton *)btn {
// 测试1：字符串
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [filePath lastObject];
    NSLog(@"%@",path);
    NSString *pathStr = [path stringByAppendingPathComponent:@"Test"];
//    在document下创建test文件夹
    if (![[NSFileManager defaultManager] fileExistsAtPath:pathStr]) {
        if ([[NSFileManager defaultManager] createDirectoryAtPath:pathStr withIntermediateDirectories:YES attributes:nil error:nil]) {
            NSLog(@"新的文件夹创建成功");
        }
    }
//    在该文件夹下拼接一个arc类型文件
    NSString *string = [pathStr stringByAppendingPathComponent:@"1字符串.arc"];
    
    NSString *contentStr = @"hello,world";
//    归档数据
    [NSKeyedArchiver archiveRootObject:contentStr toFile:string];
    
    if (![NSKeyedArchiver archiveRootObject:contentStr toFile:string]) {
        NSLog(@"归档失败");
    } else NSLog(@"归档成功");
//    解档
    NSString *getString = [NSKeyedUnarchiver unarchiveObjectWithFile:string];
    NSLog(@"少1：getString=%@",getString);
    
 // 测试2 数组
    
    NSString *arrayStr = [pathStr stringByAppendingPathComponent:@"2数组.arc"];
    NSArray *array = [NSArray arrayWithObjects:@"tianxia", @"zhida",@"wodingshengtian",nil];
    [NSKeyedArchiver archiveRootObject:array toFile:arrayStr];
    if (! [NSKeyedArchiver archiveRootObject:array toFile:arrayStr]) {
        NSLog(@"归档失败");
    } else NSLog(@"归档成功");
    
//    解档
    NSArray *getArray = [NSKeyedUnarchiver unarchiveObjectWithFile:arrayStr];
    [getArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"少2：getArray[%lu] = %@",(long)idx,obj);
    }];
    
//   测试3：非自定义的不同类型的复杂对象
    NSString *mulitObjectStr = [pathStr stringByAppendingPathComponent:@"3非自定义复杂对象.arc"];
    int int1 = 23;
    float float1 = 56.0f;
    CGSize size1 = {15,16};
    NSNumber *number = @60.6;
    NSString *str11 = @"salaanghaiyou";
    NSArray *array111 =@[@"tianxia",@"wushuang"];
    NSDictionary *dic1111 = @{@"name":@"goushegnzi",@"agge":@28};
    
//  同时对多对象归档：临时存放数据的data
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//   给每个对象制定的key值，方便读取
    [archiver encodeInt64:int1 forKey:@"int"];
    [archiver encodeFloat:float1 forKey:@"float"];
    [archiver encodeCGSize:size1 forKey:@"size"];
    [archiver encodeObject:number forKey:@"number"];
    [archiver encodeObject:str11 forKey:@"string"];
    [archiver encodeObject:array111 forKey:@"array"];
    [archiver encodeObject:dic1111 forKey:@"dictionary"];
    
    [archiver finishEncoding];
    [data writeToFile:mulitObjectStr atomically:YES];
    /*
     *解档
     */
    int int2;
    float float2;
    CGSize size2;
    NSNumber *number2;
    NSString *str22;
    NSArray *array222;
    NSDictionary *dic2222;
//    读取数据
    NSData *getData = [[NSData alloc]initWithContentsOfFile:mulitObjectStr];

    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:getData];
   int2 = (int)[unarchiver decodeInt64ForKey:@"int"];
   float2 = [unarchiver decodeFloatForKey:@"float"];
   size2 = [unarchiver decodeCGSizeForKey:@"size"];
   number2 = [unarchiver decodeObjectForKey:@"number"];
    str22 = [unarchiver decodeObjectForKey:@"string"];
    array222 = [unarchiver decodeObjectForKey:@"array"];
    dic2222 = [unarchiver decodeObjectForKey:@"dictionary"];
    [unarchiver finishDecoding];
    NSLog(@"少3： int2=%i,float2=%f,size=%@,number2=%@,str2=%@,array2=%@,dic2=%@",int2,float2,NSStringFromCGSize(size2),number2,str22,array222,dic2222);
    
    
    
//    测试4：自定义的复杂对象
    Person *per1 = [[Person alloc] init];
    per1.name = @"笑话";
    per1.age = 17;
    per1.height = 179.f;
//    nsdate和dateFormatter绑定使用的
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    per1.birthday = [dateFormatter dateFromString:@"1990-10-10"];
    
    Person *per2 = [[Person alloc] init];
    per2.name = @"woqu";
    per2.age = 18;
    per2.height = 109.f;
    per2.birthday = [dateFormatter dateFromString:@"1998-03-9"];
    NSMutableArray *peraArray = [NSMutableArray arrayWithObjects:per1,per2, nil];
    
//    存储路径
    NSString *personStr = [pathStr stringByAppendingPathComponent:@"personStr.arc"];
//    归档
    [NSKeyedArchiver archiveRootObject:peraArray toFile:personStr];
//    解档
    NSMutableArray *personGetArray = [NSKeyedUnarchiver unarchiveObjectWithFile:personStr];
    [personGetArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"4:person[%lu]: %@",idx,obj);
    }];
   
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
