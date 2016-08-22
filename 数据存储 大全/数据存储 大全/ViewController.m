//
//  ViewController.m
//
//
//  Created by Zen on 16/1/16.
//  Copyright © 2016年 Zen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_dataArray;//文件夹数组
    NSArray *_classArray;//类名数组
    
}

@end

@implementation ViewController
// 数据存储的方式可以归纳为两类：一类是存储为文件，另一类是存储到数据库
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)initData {
    _dataArray = [[NSArray alloc] initWithObjects:@"Foundation框架常用NSObject",@"文件夹使用",@"文件存储 之 偏好设置（本质是1个以项目bundle identifier为命名的plist文件)",@"文件存储 之 归档（本质是Data数据的arc格式）",@"文件存储 之 plist文件（xml属性列表）",@"数据库存储 之 sqlite（嵌入式数据库,不推荐直接使用）",@"数据库存储 之 FMDB（考虑并发安全性，如何更好的处理事务等的sqlite的面向对象的封装）",@"数据库存储 之 Core Data（面向对象方式的嵌入式数据库）", nil];
    _classArray = [[NSArray alloc] initWithObjects:@"NSObjectViewController",@"FileManagerViewController",@"UserDefaultViewController",@"KeyedArchiverViewController",@"XMLPlistViewController",@"SqliteViewController",@"FMDBViewController",@"CoreDataViewController", nil];
}

- (void)setUI {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    NSLog(@"少：self.view —> %@ \n tableview —> %@",NSStringFromCGRect(self.view.frame),NSStringFromCGRect(_tableView.frame));
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%li : %@",(long)indexPath.row,_dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cls;
    cls = NSClassFromString(_classArray[indexPath.row]);
    UIViewController *viewC = [[cls alloc] init];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBtnItem;
    [self.navigationController pushViewController:viewC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
