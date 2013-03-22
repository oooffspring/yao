//
//  ViewController.m
//  CoolTable
//
//  Created by offspring on 13-1-11.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import "ViewController.h"
#import "AddViewController.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "ResultViewController.h"

@interface ViewController (){
    NSString *_path;
    BOOL pushed;
}

@property (nonatomic,strong) NSMutableArray *breakfast,*lunch,*dinner;
@property (nonatomic,strong) NSArray *meals;
@property (nonatomic,strong) UIActionSheet *myActionSheet;
@property (nonatomic,copy) NSIndexPath *selectedIndex;
@property (nonatomic,strong) UIAccelerometer *myAccelerometer;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    pushed = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"摇饭";
    //获取存储路径
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *ds = directories[0];
    _path = [ds stringByAppendingPathComponent:@"meals.archive"];
    
    self.meals = [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
    if (self.meals.count == 0) {
        self.breakfast = [[NSMutableArray alloc] initWithCapacity:100];
        self.lunch = [[NSMutableArray alloc] initWithCapacity:100];
        self.dinner = [[NSMutableArray alloc] initWithCapacity:100];
        self.meals = [NSArray arrayWithObjects:self.breakfast,self.lunch,self.dinner,nil];
    }

    self.myActionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil, nil];
    
    self.myAccelerometer = [UIAccelerometer sharedAccelerometer];
    [self.myAccelerometer setDelegate:self];
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    //静态变量 每一次执行这个函数的时候这个shakeCount的值都是上一次的值 常驻内存
    static NSInteger shakeCount = 0;
    if (fabsf(acceleration.x) > 1.7 || fabsf(acceleration.y) > 1.7 || fabsf(acceleration.z > 1.7)) {
        shakeCount ++;
        if (shakeCount > 2 && pushed == NO) {
            ResultViewController *resultViewController = [[ResultViewController alloc] init];
            resultViewController.comeBack = ^{
                pushed = NO;
            };
            [self.navigationController pushViewController:resultViewController animated:YES];
            pushed = YES;
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndex = indexPath;
    [self.myActionSheet showInView:self.view];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell%d",indexPath.section]];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%d",indexPath.section]];
//    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //set cell's textfield's value
//    NSString *entry;
//    if (indexPath.section == 0) {
//        entry = [_breakfast objectAtIndex:indexPath.row];
//    }
//    else if (indexPath.section == 1){
//        entry = [_lunch objectAtIndex:indexPath.row];
//    }
//    else{
//        entry = [_dinner objectAtIndex:indexPath.row];
//    }
//    UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 10, cell.bounds.size.width, cell.bounds.size.height - 10)];
//    [myTextField setBackgroundColor:[UIColor clearColor]];
//    myTextField.delegate = self;
//    myTextField.text = [((NSMutableArray *)[self.meals objectAtIndex:indexPath.section])[indexPath.row] copy];
//    [myTextField setTextAlignment:NSTextAlignmentCenter];
//    [myTextField setTag:(indexPath.section * 10 + indexPath.row)];
//    [cell addSubview:myTextField];
    cell.textLabel.text = [((NSMutableArray *)[self.meals objectAtIndex:indexPath.section])[indexPath.row] copy];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    cell.backgroundView = [[CustomCellBackground alloc] initWithFrame:cell.backgroundView.bounds];
    cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSMutableArray *)self.meals[section]).count;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"早饭";
    }
    else if(section == 1){
        return @"午餐";
    }
    else{
        return @"晚饭";
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [((NSMutableArray *)self.meals[self.selectedIndex.section]) removeObjectAtIndex:self.selectedIndex.row];
        [NSKeyedArchiver archiveRootObject:self.meals toFile:_path];
        [self.tableView reloadData];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //因为nsstring是指针，所以不能直接用==，要对对象调用方法
    NSLog(@"yes");
    if ([segue.identifier isEqualToString:@"addSegue"]) {
        AddViewController *addViewController = [segue destinationViewController];
        [addViewController setDelegate:self];
    }
}

//addDelegate方法
- (void)addNewDisk:(NSString *)diskName forMeal:(NSInteger)meal{
    [((NSMutableArray *)(self.meals[meal])) addObject:diskName];
    [NSKeyedArchiver archiveRootObject:self.meals toFile:_path];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CustomHeader *header = [[CustomHeader alloc] init];
    header.titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    [header.titleLabel bringSubviewToFront:header];
    if (section == 1) {
        header.lightColor = [UIColor colorWithRed:147.0/255.0 green:105.0/255.0 blue:216.0/255.0 alpha:1.0];
        header.darkColor = [UIColor colorWithRed:72.0/255.0 green:22.0/255.0 blue:137.0/255.0 alpha:1.0];
    }
    else if (section == 2){
        header.lightColor = [UIColor colorWithRed:255.0/255.0 green:0.0/0.0 blue:0.0/0.0 alpha:1.0];
        header.darkColor = [UIColor colorWithRed:180.0/255.0 green:0.0/0.0 blue:0.0/0.0 alpha:1.0];
    }
    return header;
}
@end
