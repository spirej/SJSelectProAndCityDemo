//
//  SJSelectProAndCityViewController.m
//  SJSelectProAndCityDemo
//
//  Created by SPIREJ on 16/1/14.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "SJSelectProAndCityViewController.h"
#define cellHeight 55
static NSString *currentProString;

@interface SJSelectProAndCityViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    SJStationType thisType;
    NSArray *dataArr;
}

@end

@implementation SJSelectProAndCityViewController

- (instancetype)initWithType:(SJStationType)type{
    self = [super init];
    if (self) {
        thisType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = thisType == SJStationType_Pro?@"省/直辖市":@"地区";
    
    [self getData];
    [self setUI];
}

- (void)getData {
    NSArray *stationArr = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"]];
    if (thisType == SJStationType_Pro) {
        NSMutableArray *proListArr = [NSMutableArray array];
        for (int i = 0; i < stationArr.count; i++) {
            NSDictionary *proDic = stationArr[i];
            NSString *proNameStr = [proDic objectForKey:@"state"];
            if ([proNameStr isKindOfClass:[NSString class]]) {
                [proListArr addObject:proNameStr];
            }
        }
        dataArr = [NSArray arrayWithArray:proListArr];
    }else if (thisType == SJStationType_City){
        for (int i = 0; i < stationArr.count; i++) {
            NSDictionary *proDic = stationArr[i];
            NSString *proNameStr = [proDic objectForKey:@"state"];
            if ([proNameStr isEqualToString:currentProString]) {
                NSArray *cityListArr = [proDic objectForKey:@"cities"];
                dataArr = [NSArray arrayWithArray:cityListArr];
            }
        }
    }
}
- (void)setUI {
    
}

#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"stationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.textLabel.text = dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (thisType == SJStationType_Pro) {
        currentProString = dataArr[indexPath.row];
        self.stationProBlock(dataArr[indexPath.row]);
    }
    if (thisType == SJStationType_City) {
        self.stationCityBlock(dataArr[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
