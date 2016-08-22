//
//  UserDefaultViewController.m
//  数据存储 大全
//
//  Created by Zen on 16/1/22.
//  Copyright © 2016年 Zen. All rights reserved.
//

#import "UserDefaultViewController.h"
#import "Student.h"

@interface UserDefaultViewController ()<UITextFieldDelegate>
{
    UILabel *loginLabel;
    UILabel *passwordLabel;
    UITextField *loginTextField;
    UITextField *passwordTextField;
}
@end
// NSUserDefaults只纯洁的支持下面这些类型的不可变的对象： NSString, NSNumber（NSInteger、float、double、BOOL）, NSDate, NSData,NSArray, NSDictionary.
//  （注意：自定义对象归档后可支持，可变对象转为不可变可支持）
//适用范围：一些短小的信息->用户名、密码
//存储路径：Library/Preferences目录
@implementation UserDefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

#pragma mark textfield 的代理方法
//编辑完毕后，按done时调用
- (void)textFieldDidEndEditing:(UITextField *)textField {
    //   测试1
    if ([textField isEqual:loginTextField]) {
        [[NSUserDefaults standardUserDefaults] setObject: textField.text forKey:@"用户名"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        [[NSUserDefaults standardUserDefaults] setObject: textField.text forKey:@"密码"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSString *loginName = [[NSUserDefaults standardUserDefaults]objectForKey:@"用户名"];
    NSString *passwordName = [[NSUserDefaults standardUserDefaults]objectForKey:@"密码"];
    NSLog(@"用户名 = %@,密码 = %@",loginName,passwordName);
    
    
    //   测试2 存储可变数据：可变变为不可变的，再存储。取出时反向
    NSMutableArray *mutableArray = [NSMutableArray arrayWithObjects:@"123",@"234",@"999", nil];
    NSArray *array = [NSArray arrayWithArray:mutableArray];
    [[NSUserDefaults standardUserDefaults]setObject:array forKey:@"记住存放的数据一定是不可变的"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    NSMutableArray *mutableA = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"记住存放的数据一定是不可变的"]];
    NSLog(@"可变数组 = %@",mutableA);
    
    
    
    //   测试3 存储自定义对象:把自定义对象的转为NSData类型，在存放在可变数组，再将可变数组转为不可变数组，再存在NSUserDefaults中。取出反向
    Student  *a = [[Student alloc]init];
    a.name  = @"男神";
    a.number = @"628658562856";
    a.sex = @"人妖";
//    其他数据类型通过归档方式转化为data
    NSData *dataA = [NSKeyedArchiver archivedDataWithRootObject:a];
    
    Student  *b = [[Student alloc]init];
    b.name  = @"女神";
    b.number = @"12334145";
    b.sex = @"妖";
//    其他数据类型通过归档方式转化为data
    NSData *dataB = [NSKeyedArchiver archivedDataWithRootObject:b];
    
    
    NSMutableArray *studentArray = [NSMutableArray arrayWithObjects:dataA,dataB, nil];
    NSArray *studentA = [NSArray arrayWithArray:studentArray];
    [[NSUserDefaults standardUserDefaults]setObject:studentA forKey:@"学生"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSArray *getArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"学生"];
    NSMutableArray *getMutableArray = [NSMutableArray arrayWithArray:getArray];
    for (NSData *studentData in getMutableArray) {
        Student *getStudent = [NSKeyedUnarchiver unarchiveObjectWithData:studentData];
        NSLog(@"名字 : %@,学号 ：%@, 性别 ：%@",getStudent.name,getStudent.number,getStudent.sex);
    }
}

- (void)setUI {
    loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 60, 30)];
    loginLabel.textColor = [UIColor blackColor];
    loginLabel.textAlignment = NSTextAlignmentLeft;
    loginLabel.text = @"用户名";
    [self.view addSubview:loginLabel];
    
    passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 160, 60, 30)];
    passwordLabel.textColor = [UIColor blackColor];
    passwordLabel.textAlignment = NSTextAlignmentLeft;
    passwordLabel.text = @"密码";
    [self.view addSubview:passwordLabel];
    
    loginTextField = [[ UITextField alloc] initWithFrame:CGRectMake(140, 100,200, 30)];
    loginTextField.delegate = self;
    loginTextField.borderStyle = UITextBorderStyleRoundedRect;
    loginTextField.placeholder = @"请输入账号";
    loginTextField.textColor = [UIColor blackColor];
    loginTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:loginTextField];
    
    
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(140, 160, 200, 30)];
    passwordTextField.delegate = self;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    loginTextField.placeholder = @"请输入密码";
    passwordTextField.textColor = [UIColor blackColor];
    passwordTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:loginTextField];
    [self.view addSubview:passwordTextField];
}

//改变时调用该方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
            return YES;
}

//点击返回按钮调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
