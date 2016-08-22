//
//  FileManagerViewController.m
//  数据存储 大全
//
//  Created by qsyMac on 16/1/24.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "FileManagerViewController.h"

@interface FileManagerViewController ()

@end

@implementation FileManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 200, 30);
    [button setTitle:@"文件夹使用" forState:UIControlStateNormal ];
    [button addTarget:self action:@selector(FileManage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)FileManage:(UIButton *)btn {// 重复创建是会出现问题，应该首先判断文件夹是否已经存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
//    在沙盒里，创建新的文件夹目录
    NSArray *fileArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [fileArray lastObject];
    NSLog(@"%@",filePath);
    NSString *appendPath = [filePath stringByAppendingPathComponent:@"woqu"];
    
    if (![fileManager fileExistsAtPath:appendPath]) {
        NSLog(@"文件不存在，需要重新创建");
        if (![fileManager createDirectoryAtPath:appendPath withIntermediateDirectories:YES attributes:nil error:nil]) {
        NSLog(@"创建不成功");
     }
 }
    //    文件夹的基本操作
    BOOL isRead = [fileManager isReadableFileAtPath:appendPath];
//   重新命名文件目录
    NSString *changeName = [filePath stringByAppendingPathComponent:@"改名了"];
    if (![fileManager moveItemAtPath:appendPath toPath:changeName error:nil]) {
        NSLog(@"改名失败");
    }
    //文件拷贝
//    NSString *copyPath = [filePath stringByAppendingPathComponent:@"文件拷贝"];
//    if(![fileManager copyItemAtPath:changeName toPath:copyPath error:nil]){
//        NSLog(@"Copy failed!");
//    }
//    删除文件夹
//    if (![fileManager removeItemAtPath:changeName error:nil]) {
//        NSLog(@"删除失败");
//    }
//  遍历文件夹 方法1
    NSDirectoryEnumerator *directoryEnum = [fileManager enumeratorAtPath:changeName];
    while (changeName = [directoryEnum nextObject]) {
        NSLog(@"%@",changeName);
    }
    //遍历文件夹 方法2
    NSArray *paths = [fileManager contentsOfDirectoryAtPath:changeName error:nil];
    for (NSObject *obj in paths) {
        NSLog(@"%@",obj);
    }
    
//  文件的操作
    NSString *txtStr = @"/Users/qiushaoyi/Desktop/ddd/172772.txt";
    //存为NSData形式
    NSData *data1 = [txtStr dataUsingEncoding: NSUTF8StringEncoding];//直接存路径的字符串  //NSData *data3 = [NSData dataWithContentsOfFile:txtStr];
    NSData *data2 = [fileManager contentsAtPath:txtStr];
    //二进制流转化为字符串
    NSString *contentString = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
      NSLog(@"data=%@,contentString=%@",data2,contentString);
  //获得当前程序所在目录
    NSString *currentPath = [fileManager currentDirectoryPath];
    NSLog(@"currentPath = %@",currentPath);
    NSString *newFilePath = [currentPath stringByAppendingPathComponent:@"test.txt"];
    [fileManager createFileAtPath:newFilePath contents:[@"hello,world" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
//  通过包内容读取数据
//如果有test.txt则返回路径，否则返回nil
    NSString *pathStr333 =[[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"];
    
}


@end
