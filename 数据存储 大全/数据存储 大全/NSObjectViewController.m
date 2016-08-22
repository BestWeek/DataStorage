//
//  NSObjectViewController.m
//  数据存储 大全
//
//  Created by qsyMac on 16/1/24.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "NSObjectViewController.h"
#import "Engineer.h"
#import "Dog.h"
typedef struct getSize {//重定义：结构体
    CGFloat width;
    CGFloat height;
}QsyStruct;

// “=” 左边连着返回值，右边连着带参数的消息。

@interface NSObjectViewController ()

@end

@implementation NSObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 200, 30);
    [button setTitle:@"Foundation框架" forState:UIControlStateNormal ];
    [button addTarget:self action:@selector(getFoundation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)getFoundation:(UIButton *)btn {
    
    /*
     *测试1：结构体
     */
    [self structMany];
    /*
     *测试2：日期
     */
    [self date];
    /*
     *测试3：字符串
     */
    [self string];
    
    /*
     *测试4：可变字符串
     */
    [self mutableString];
    /*
     *测试5：数组
     */
    [self array];
    /*
     *测试6：可变数组
     */
    [self mutableArray];
    /*
     *测试7：字典
     */
    [self dictionary];
    /*
     *测试8：可变字典
     */
   // [self mutableDictionary];
    /*
     *测试9：基本数据类型和OC类型转化
     */
    [self transformBasicType];
    
    [self adKnowledge];//补充知识
    
}

- (void)adKnowledge {
      NSNull *null = [NSNull null];//单利空 等效于 0。加入数组或字典中时不会报错，当数组或字典碰到nil时才会终止。
    //获取狗类
    Class cls;
    cls = NSClassFromString(@"Dog");
    Dog *dog = [[cls alloc] init];
    // 执行狗类里面的方法
    SEL selector;
    selector = NSSelectorFromString(@"executeSelector");
    [dog performSelector:selector withObject:@"我去，这也行"];
    
}
- (void)transformBasicType {
//   装箱
    NSNumber *intNum = [NSNumber numberWithInt:1];
    NSNumber *BoolNum = [NSNumber numberWithBool:YES];
    NSNumber *intergerNum = [NSNumber numberWithInteger:12];
    NSNumber *charNum = [NSNumber numberWithChar:'a'];
    NSNumber *longlongNum = [NSNumber numberWithLongLong:1345];
   
    
    NSValue *rectValue = [NSValue valueWithCGRect:CGRectMake(12, 213, 234, 7)];
    NSValue *rangeValue = [NSValue valueWithRange:NSMakeRange(2, 6)];
    NSValue *pointValue = [NSValue valueWithUIOffset:UIOffsetMake(23, 34)];
    //自定义结构体
    QsyStruct structwh = {2014,28};
    char *type = @encode(QsyStruct);//自定义的类型转化为char类型的指针。
    NSValue *redefineValue = [NSValue valueWithBytes:&structwh objCType:type];//如果函数的参数可以是任意类型指针，那么应声明其参数为void * 和 id 任意类型的数据。
    
//   拆箱
    int a = [intNum intValue];
    BOOL b = [BoolNum boolValue];
    NSInteger inter = [intergerNum integerValue];
    char cha = [charNum charValue];
    long long longNum = [longlongNum longLongValue];
    
    CGRect rect = [rectValue CGRectValue];
    NSRange range = [rangeValue rangeValue];
    CGPoint point = [pointValue CGPointValue];
    QsyStruct newStruct;
    [redefineValue getValue:&newStruct];
    
    NSLog(@"NSInteger = %ld, CGRect=%@，NSRange=%@,QsyStructw = %f",(long)inter,NSStringFromCGRect(rect), NSStringFromRange(range),newStruct.width);
    [self encodeUseDes];//@encode 的使用描述
    
}

//判断字典里的value是哪种基本数据类型转换为NSNumber的
- (void)encodeUseDes {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],@"key1",[NSNumber numberWithDouble:1.00f],@"key2",[NSNumber numberWithInt:1],@"key3",[NSNumber numberWithFloat:33.0f], @"key4", nil];
    for(NSString *key in dic){
        id value = [dic valueForKey:key];
        if([value isKindOfClass:[NSNumber class]]){
            const char * pObjCType = [((NSNumber*)value) objCType];
            if (strcmp(pObjCType, @encode(int))  == 0) {
                NSLog(@"字典中key=%@的值是int类型,值为%d",key,[value intValue]);
            }
            if (strcmp(pObjCType, @encode(float)) == 0) {
                NSLog(@"字典中key=%@的值是float类型,值为%f",key,[value floatValue]);
            }
            if (strcmp(pObjCType, @encode(double))  == 0) {
                NSLog(@"字典中key=%@的值是double类型,值为%f",key,[value doubleValue]);
            }
            if (strcmp(pObjCType, @encode(BOOL)) == 0) {
                NSLog(@"字典中key=%@的值是bool类型,值为%i",key,[value boolValue]);
            }
        }
        
    }
}

- (void)mutableDictionary {
    // 详见字典：增删改等操作
}

- (void)dictionary {
//    创建字典
    NSDictionary *dic0 = [NSDictionary dictionaryWithObject:@"A" forKey:@"1"];
    NSDictionary *dic1 = [[NSDictionary alloc]initWithObjects:@[@"wo",@"love",@"ni"] forKeys:@[@"1",@"2",@"3"]];
    NSDictionary *dic2 = @{@"1":@"a",@"2":@"b",@"3":@"c"};
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"a",@"1",@"b",@"2",@"c",@"3", nil];//1234都是key
    NSDictionary *dic4 = [dic0 objectsForKeys:@[@"a",@"c"] notFoundMarker:@"not Founder"];// 找不到对应的key时就用not Founder代替
//    添加新的元素:转为可变字典
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic1];
    [mutableDic addEntriesFromDictionary:@{@"7":@"j",@"8":@"n"}];//+1引用计数
     NSLog(@"mutableDic = %@,",mutableDic);
//    删除元素
    [mutableDic removeObjectsForKeys:@[@"1",@"2"]];//-1
//   修改元素
    [mutableDic setValue:@"修改了一下" forKey:@"3"];
    NSLog(@"mutableDic = %@,dic1=%@",mutableDic,dic1);
//   查： 遍历字典
    [dic1 enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"dic1[%@] = %@",key,obj);
    }];
      //或者1
    for (id key in dic1) {//forin 的参数是key
        NSLog(@"dic1[%@] = %@",key,[dic1 objectForKey:key]);
    }
    //或者2
    NSEnumerator *enumerator = [dic1 keyEnumerator];//迭代器
    id key;
    while (key = [enumerator nextObject]) {
        NSLog(@"dic1[%@]=%@",key,[dic1 objectForKey:key]);
    }
    
    
}
- (void)mutableArray {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithObjects:@"woshuo",@"hahha",@"tianxia", nil];
//   添加元素
    [mutableArray addObject:@"新添加的"];
    [mutableArray addObjectsFromArray:[NSArray arrayWithObjects:@"添加新对象",@"添加新对象2", nil]];
//   移除元素:移除元素，用可变数组。+1或-1
    [mutableArray removeObject:@"hahha"];
    [mutableArray removeAllObjects];
//  排序
    NSMutableArray *array1=[NSMutableArray arrayWithObjects:@"1",@"3",@"2", nil];
    NSArray *array2= [array1 sortedArrayUsingSelector:@selector(compare:)];//注意这个方法没有修改array1
    NSLog(@"array1 = %@,array2 = %@",array1,array2);
#warning 少：sortUsingSelector的可以使原数组发生变化。
    [array1 sortUsingSelector:@selector(compare:)];// 可变数组中如果使用sortUsingSelector:排序原来的数组顺序就发生了变化。
    
    
}

- (void)array {
//    创建
    NSArray *array0 = [[NSArray alloc] initWithObjects:@"wo",@"he",@"ni", nil];//不可变故初始化就赋值
    NSLog(@"array0 == %@",array0);
    NSArray *array1 = [NSArray arrayWithObjects:@"wo",@"he",@"ni",nil];
    NSArray *array2 = @[@"wo",@"he",@"ni"];
    NSArray *array3 = [NSArray array];
    
//  获取数组中的某个或某些元素
    NSString *first = [array1 objectAtIndex:0]; //[array0 firstObject];
    NSString *last = [array2 objectAtIndex:array2.count-1];//[array2 lastObject];
    NSMutableArray *newArray = [NSMutableArray array];
    [array2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [newArray addObject:obj];
    }];
      //   或者1
    for (NSString *str in array2) {
        [newArray addObject:str];
    }
      //   或者2
    for (int i=0; i<array2.count; ++i) {
        NSString *str99 = [array2 objectAtIndex:i];
        [newArray addObject:str99];
    }
      //   或者3:反向迭代器
    NSEnumerator *enumerator = [array2 reverseObjectEnumerator];//获取一个反向迭代器
    id obj;
    while (obj = [enumerator nextObject]) {
        [newArray addObject:obj];
    }
//   派生出新的数组：截取一个数组，添加对象到数组
    NSArray *subArray = [array2 subarrayWithRange:NSMakeRange(0, 1)];
    NSArray *extisionArray = [array2 arrayByAddingObject:@"新增一个对象"];
    BOOL b = [array2 containsObject:@"撒子"];
//   把整个数组转为字符串
    NSString *str = [array2 componentsJoinedByString:@""];
      NSLog(@"遍历读取出整个数组：%@,是否包含某个对象：%d，截取数组：%@,延伸数组：%@，转为字符串：%@",newArray,b,subArray,extisionArray,str);//结果：woheini
//   写入文件和读取文件
    NSArray *fileArray = [NSArray arrayWithObjects:@"我",@"要",@"写入文件了", nil];
    NSString *fileStr = @"/Users/qsymac/Desktop/369";
    [fileArray writeToFile:fileStr atomically:YES];
    NSArray *getArray = [NSArray arrayWithContentsOfFile:fileStr];
//   排序
    NSArray *sortArray = @[@"r我要",@"g我排序",@"b你了"];
    NSArray *array111 = [sortArray sortedArrayUsingSelector:@selector(compare:)];// 正序
     //或者1
    NSArray *array222 = [sortArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj2 compare:obj1];//倒序
    }];
    //或者2
    Engineer *eng0 = [[Engineer alloc] init];
    eng0.name = @"woleigecaca";
    eng0.height = 1.f;
    eng0.dog = [[Dog alloc] init];
    eng0.dog.weight = 21.f;
    
    Engineer *eng1 = [[Engineer alloc] init];
    eng1.name = @"memm";
    eng1.height = 34.f;
    eng1.dog = [[Dog alloc] init];
    eng1.dog.weight = 87.f;
    
    Engineer *eng2 = [[Engineer alloc] init];
    eng2.name = @"backT";
    eng2.height = 8.f;
    eng2.dog = [[Dog alloc] init];
    eng2.dog.weight = 9.f;
   
    NSArray *engineerArray = [NSArray arrayWithObjects:eng0,eng1,eng2, nil];
    NSSortDescriptor *engineerName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSSortDescriptor *dogweight = [NSSortDescriptor sortDescriptorWithKey:@"dog.weight" ascending:YES];
    NSArray *des = [NSArray arrayWithObjects:engineerName, dogweight,nil];//先按照person的name排序再按照DOg的weight排序
    NSArray *sortedArray = [engineerArray sortedArrayUsingDescriptors:des];
    
    NSLog(@"排序array111：%@,排序array222：%@,sortedArray自定义排序:%@",array111,array222,sortedArray);
    
#pragma mark 与可变数组的转化
    NSMutableArray *mutableArray0 = [NSMutableArray arrayWithArray:array0];
//  或
    NSMutableArray *mutableArray1 = array0.mutableCopy;
}

- (void)mutableString {
//    创建
    NSMutableString *str = @"woleige".mutableCopy;
    NSMutableString *mutableStr = [[NSMutableString alloc] initWithCapacity:10];//性能较好。可存储超过10位的数字
    mutableStr.string = @"woleigequ";
    
//   添加，拼接可变字符串
    [mutableStr appendString:@",hahaha"];
//   添加，：插入字符串
    [mutableStr insertString:@"wn" atIndex:0];
//    更改：替换字符串
    [mutableStr replaceCharactersInRange:NSMakeRange(0, 9) withString:@"qsy"];
//    删除字符串
    [mutableStr deleteCharactersInRange:NSMakeRange(2, 3)];
    NSLog(@"%@",mutableStr);
#pragma mark 和不可变相互转化
     NSString *str333 = [NSMutableString stringWithString:mutableStr];
//    或者
    NSString *str3333 = mutableStr.copy;
}


- (void)structMany{
    NSRange rg2 = NSMakeRange(3, 5);
    NSLog(@"range结构体：%@",NSStringFromRange(rg2));
    
    CGPoint pt2 = CGPointMake(10, 15);
    NSLog(@"%@",NSStringFromCGPoint(pt2));
    
    CGSize se2 = CGSizeMake(100, 100);
    NSLog(@"%@",NSStringFromCGSize(se2));
    
    CGRect rt2 = CGRectMake(0, 88, 34, 5);
    NSLog(@"%@",NSStringFromCGRect(rt2));
}

- (void)date {
    NSDate *now1 = [NSDate date];//当前时间:东0区
    NSDate *date1 = [NSDate dateWithTimeIntervalSinceNow:120];//东0区当前时间+2分钟
    NSDate *date2 = [NSDate distantFuture];//将来的随机某个时间
    NSDate *date3 = [NSDate dateWithTimeIntervalSince1970:120];//从1970年1月1日0时0分，加上2分钟的时间
    NSLog(@"date3=%@",date3);
    //    时间格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *nowStr = [dateFormatter stringFromDate:now1];//该字符串是当地当前时间
    
    NSDate *now2 = [dateFormatter dateFromString:nowStr];//东0区的时间
    NSLog(@"格式时间后的时间：%@,未格式的时间：%@",nowStr,now2);
}

- (void)string {
    //    创建字符串
    // 动态方法
    NSString *str1 = [[NSString alloc] init];
    //静态方法
    NSString *str2 = [NSString new];
    NSString *str3 = [NSString stringWithFormat:@"age is %i,name is %.2f",19,1.72f];
    
    NSString *str4 = @"woleiGeQu";// 等同于 NSString *str5 = [NSString stringWithString:@"haoyaya"];
    // 首字母大写和小写，其他字母不变
    [str4 capitalizedString];
    [str4 capitalizedStringWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [str4 lowercaseString];
    // 判断字符串是不是相同
    BOOL b = [@"qoeuu" isEqualToString:str1];
    //比较字符串
    NSComparisonResult result2 = [@"wolei" compare:str4];
    if (result2 == NSOrderedAscending) {
        NSLog(@"%ld",(long)result2);
    } else if (result2 == NSOrderedSame) {
        NSLog(@"%ld",(long)result2);
    } else if (result2 == NSOrderedDescending) {
        NSLog(@"%ld",(long)result2);
    }
    //是否有前缀和后缀的字符串
    BOOL preFix = [str4 hasPrefix:@"wolei"];
    BOOL suffix  = [str4 hasSuffix:@"Qu"];
    
    // 截取和拼接字符串:
    NSString *str44 = [str4 substringWithRange:NSMakeRange(2, 3)];//从在2位置的开始，总长度为3的字符串
    NSString *str444 = [str4 stringByAppendingString:@"我要拼接了"];
    //字符串与其他类型的转换
    int aInt = [str4 intValue];
    char str441 = [str4 characterAtIndex:0];
    Class cls = NSClassFromString(@"类名");
    CGRect rect = CGRectFromString(@"rect");
    NSRange range = NSRangeFromString(@"range");
    
    NSLog(@"%@,%d,%d,%d,%@,%c,%@,%d",str4,b,preFix,suffix,str44,str441,str444,aInt);
    // 读取文件和写入文件（字符串方式和url方式）
    NSString *strPath = @"/Users/qsymac/Desktop/DataSaveFull";//字符串是文件夹路径
    NSError *error;
    NSString *fileStr = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:&error ];
    if (error) {
        NSLog(@"读取错误");
    } else {
        NSLog(@"读取正确：%@",fileStr);
    }
    
    NSURL *url=[NSURL URLWithString:@"http://www.apple.com"];//url是网页路径
    NSString *str333=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"str3 is %@",str333);
    //  写入文件
    NSString *writeStr = @"我要写入了";
    NSString *witeToFile = @"/Users/qsymac/Desktop/DataSaveFull";
    [writeStr writeToFile:witeToFile atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"写入失败");
    } else
        NSLog(@"写入成功");
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    [mutableArray addObject:@"tianxia"];
    [mutableArray addObject:@"yu"];
    [mutableArray addObject:@"wushuang"];
    NSString *pathStr = [NSString pathWithComponents:mutableArray];//字符串拼接成路径：tianxia/yu/wushuang
    NSLog(@"文件路径：%@",pathStr);
    
    //拓展名操作
    NSString *path=@"Users/Qsy/Desktop/test.txt";
    NSLog(@"获取OC中拓展名不包括点：%@,删除拓展名：%@,",[path pathExtension],[path stringByDeletingPathExtension]);
    
    
#pragma mark 和可变相互转化
    NSMutableString *str4444 = [NSString stringWithString:str1];
//或者
    NSMutableString *str44444 = str1.mutableCopy;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
