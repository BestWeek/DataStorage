//
//  StatusTableViewCell.h
//  数据存储 大全
//
//  Created by qsyMac on 16/1/25.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;
@interface StatusTableViewCell : UITableViewCell
#pragma mark 微博对象
@property (nonatomic,strong) Status *status;

#pragma mark 单元格高度
@property (assign,nonatomic) CGFloat height;
@end
