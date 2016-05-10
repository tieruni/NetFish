//
//  CityViewController.m
//  NetFish
//
//  Created by 蔚蓝海域 on 16/5/6.
//  Copyright © 2016年 Fish. All rights reserved.
//

#import "CityViewController.h"
#import "MineViewController.h"
@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *cities;
@property (nonatomic, strong) NSMutableArray *keys;
@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    // Do any additional setup after loading the view, typically from a nib.
    [self naviSetUp];
    [self dataPreparation];
    [self uiSetUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)naviSetUp {
    self.navigationItem.title = @"城市列表";
}

- (void)dataPreparation {
    self.keys = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
}

- (void)uiSetUp {
    _tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - tableView

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_keys objectAtIndex:section];
}
/*
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
 bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
 
 UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 250, 20)];
 titleLabel.backgroundColor = [UIColor clearColor];
 titleLabel.textColor = [UIColor darkGrayColor];
 titleLabel.font = [UIFont systemFontOfSize:12];
 
 NSString *key = [_keys objectAtIndex:section];
 titleLabel.text = key;
 
 [bgView addSubview:titleLabel];
 
 return bgView;
 }
 */
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keys;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *key = [_keys objectAtIndex:section];
    NSArray *citySection = [_cities objectForKey:key];
    return [citySection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [_keys objectAtIndex:indexPath.section];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        [cell.textLabel setTextColor:[UIColor blackColor]];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    cell.textLabel.text = [[[_cities objectForKey:key] objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *key = [_keys objectAtIndex:indexPath.section];
    NSString *str = [[[_cities objectForKey:key] objectAtIndex:indexPath.row] objectForKey:@"name"];

    [Utilities removeUserDefaults:@"city"];
    [Utilities setUserDefaults:@"city" content:str];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
