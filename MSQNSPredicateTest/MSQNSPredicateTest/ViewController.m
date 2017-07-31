//
//  ViewController.m
//  MSQNSPredicateTest
//
//  Created by 毛韶谦 on 2017/7/31.
//  Copyright © 2017年 毛韶谦. All rights reserved.
//

#import "ViewController.h"
#import "MSQModel.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *mutArr;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) NSArray *predicateArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSPredicate *ca = [NSPredicate predicateWithFormat:@"%@",@""];
    
    [self initNativeData];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)valueChanged:(UITextField *)sender {
    
    NSString *text = sender.text;
    
    /*
     比较运算符 > , < , == , >= , <= , !=
     运算符还可以跟逻辑运算符一起使用，&&  ,  || ,AND, OR 谓词不区分大小写
     
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age == %ld" ,[text integerValue]];
     */
    
    /*
     范围运算符：IN、BETWEEN
     
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age in{ 40, 50}" ,[text integerValue]]; //age == 40 age == 50
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age BETWEEN{ 40, 50}" ,[text integerValue]]; // 40 <= age <= 50
     */

    /*
     字符串本身:SELF
     NSArray *array=[NSArray arrayWithObjects: @"abc", @"def", @"ghi",@"jkl", nil nil];
     NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF=='abc'"];
     NSArray *array2 = [array filteredArrayUsingPredicate:pre];
     
     */
    
    /*
     字符串相关：BEGINSWITH 以···开始、ENDSWITH 以···结尾、CONTAINS 包含
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@" ,text];
     //注:[c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，也不区分发音符号。
     */
    
    /*
     通配符：LIKE  *代表通配符Like还接受[cd]  ?只匹配一个字符并且还可以接受[cd].
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self LIKE '?z'"];
     self.predicateArr = [[NSArray arrayWithObjects:@"az", @"zzz", @"zaa", @"arw", nil] filteredArrayUsingPredicate:predicate];
     */
    
    /*
     正则表达式：MATCHES
     NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
     NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
     //判断指定的对象是否满足NSPredicate创建的过滤条件
     [phoneTest evaluateWithObject:@"手机字符串"];
     */
    
    
    //创建NSPredicate（相当于创建一个过滤条件）
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@" ,text];
    
    //过滤出符合条件的对象（返回所有符合条件的对象）
    self.predicateArr = [self.mutArr filteredArrayUsingPredicate:predicate];
    [self.mainTableView reloadData];
    
}

- (IBAction)downAction:(id)sender {
    
    [self.view endEditing:YES];
}











- (void)initNativeData {
    
    for (int i = 0; i < 100; i++) {
        
        MSQModel *model = [[MSQModel alloc] init];
        model.age = arc4random()%90+10;
        model.name = [self creatRandomName];
        model.phoneNumber = [[self creatPhoneNumber] stringByAppendingString:[NSString stringWithFormat:@"%d",arc4random()%10000000+10000000]];
        [self.mutArr addObject:model];
    }
}

#pragma mark ---------TableView代理方法---------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.predicateArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    MSQModel *model = self.predicateArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"姓名：%@  年龄：%ld  电话：%@",model.name, model.age, model.phoneNumber];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    return cell;
}


























- (NSString *)creatPhoneNumber {
    
    NSString *phone;
    switch (arc4random()%4) {
        case 0:
            phone = @"182";
            break;
        case 1:
            phone = @"139";
            break;
        case 2:
            phone = @"158";
            break;
        case 3:
            phone = @"132";
            break;
            
        default:
            break;
    }
    
    
    return phone;
}

- (NSString *)creatRandomName {
    
    NSString *name;
    switch (arc4random()%4) {
        case 0:
            name = @"Mm毛";
            break;
        case 1:
            name = @"lL李";
            break;
        case 2:
            name = @"ZZ张";
            break;
        case 3:
            name = @"zz赵";
            break;
            
        default:
            break;
    }
    
    switch (arc4random()%10) {
        case 0:
            name = [name stringByAppendingString:@"栋"];
            break;
        case 1:
            name = [name stringByAppendingString:@"韶"];
            break;
        case 2:
            name = [name stringByAppendingString:@"钱"];
            break;
        case 3:
            name = [name stringByAppendingString:@"婷"];
            break;
        case 4:
            name = [name stringByAppendingString:@"历"];
            break;
        case 5:
            name = [name stringByAppendingString:@"雨"];
            break;
        case 6:
            name = [name stringByAppendingString:@"和"];
            break;
        case 7:
            name = [name stringByAppendingString:@"商"];
            break;
        case 8:
            name = [name stringByAppendingString:@"票"];
            break;
        case 9:
            name = [name stringByAppendingString:@"强"];
            break;
            
        default:
            name = [name stringByAppendingString:@"不可能"];
            break;
    }
    switch (arc4random()%15) {
        case 0:
            name = [name stringByAppendingString:@"栋"];
            break;
        case 1:
            name = [name stringByAppendingString:@"韶"];
            break;
        case 2:
            name = [name stringByAppendingString:@"钱"];
            break;
        case 3:
            name = [name stringByAppendingString:@"婷"];
            break;
        case 4:
            name = [name stringByAppendingString:@"历"];
            break;
        case 5:
            name = [name stringByAppendingString:@"雨"];
            break;
        case 6:
            name = [name stringByAppendingString:@"和"];
            break;
        case 7:
            name = [name stringByAppendingString:@"商"];
            break;
        case 8:
            name = [name stringByAppendingString:@"票"];
            break;
        case 9:
            name = [name stringByAppendingString:@"强"];
            break;
            
        default:
            break;
    }
    
    return name;
}

- (NSMutableArray *)mutArr {
    
    if (!_mutArr) {
        _mutArr = [NSMutableArray array];
    }
    return _mutArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
