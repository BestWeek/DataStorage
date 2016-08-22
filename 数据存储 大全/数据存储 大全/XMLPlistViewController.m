//
//  XMLPlistViewController.m
//  数据存储 大全
//
//  Created by Zen on 16/1/22.
//  Copyright © 2016年 Zen. All rights reserved.
//

#import "XMLPlistViewController.h"

@interface XMLPlistViewController ()

@end
// 常用场景：一些配置和固定的设置都可以写成plist文件。
//适用对象：字典和数组。只有NSArray、NSMutableArray、NSDictionary、NSMutableDictionary支持。因为NSString、NSNumber、NSData即使有writeToFile存储的也不是xml格式。

@implementation XMLPlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 200, 30);
    [button setTitle:@"生成plist文件" forState:UIControlStateNormal ];
    [button addTarget:self action:@selector(getXML:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)getXML:(UIButton *)btn {
//获取沙盒路径并拼接一个该文件的名字和类型。
    NSArray *filePath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathString = [filePath lastObject];
    NSString *path = [pathString stringByAppendingPathComponent:@"名字数组.plist"];
    NSString *path1 = [pathString stringByAppendingPathComponent:@"年龄字典.plist"];
    NSLog(@"%@    %@",path,path1);
    /*
     * 测试1 数组
     */
//    NSString *path = @"/Users/qiushaoyi/Desktop/数据存储 大全/plist文件夹/名字数组.plist";
//  把数组写在文件里
    NSArray *nameArray = @[@"qiushaoyi",@"wuna",@"fffff"];
    [nameArray writeToFile:path atomically:YES];
//    读取文件里
    NSArray *array2 = [NSArray arrayWithContentsOfFile:path];
    [array2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"array2[%lu] = %@",idx,obj);
    }];
    /*
     * 测试2 字典
     */
//  NSString *pathDic = @"/Users/qiushaoyi/Desktop/数据存储 大全/plist文件夹/年龄字典.plist";
    NSDictionary *ageDic = @{@"qiushaoyi":@"18",@"wuna":@"16",@"ffffff":@"12",};
    [ageDic writeToFile:path1 atomically:YES];
//    读取文件
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path1];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"dic[%@] = %@",key,obj);
    }];
    
//   测试3 字符串
    NSString *path2 = @"/Users/qiushaoyi/Desktop/数据存储 大全/plist文件夹/字符串.txt";
    NSString *str = @"字符串";
    [str writeToFile:path2 atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSString *getStr = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"字符串：%@",getStr);
}

@end
