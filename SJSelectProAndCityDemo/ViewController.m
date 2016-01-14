//
//  ViewController.m
//  SJSelectProAndCityDemo
//
//  Created by SPIREJ on 16/1/14.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "ViewController.h"
#import "SJSelectProAndCityViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *proTipLB;
@property (weak, nonatomic) IBOutlet UILabel *cityTipLB;
- (IBAction)clearBtnClick:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _proTipLB.tag = 10001;
    _cityTipLB.tag = 10002;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelGesture:)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelGesture:)];
    _proTipLB.userInteractionEnabled = YES;
    _cityTipLB.userInteractionEnabled = YES;
    [_proTipLB addGestureRecognizer:tap];
    [_cityTipLB addGestureRecognizer:tap1];
}

- (void)labelGesture:(UITapGestureRecognizer *)gesture{
    
    if (gesture.view.tag == 10001) {
        [self selectProvince];
    }else if (gesture.view.tag == 10002){
        [self selectCity];
    }
}

- (void)selectProvince{
    SJSelectProAndCityViewController *selectProVC = [[SJSelectProAndCityViewController alloc] initWithType:SJStationType_Pro];
    selectProVC.stationProBlock = ^(NSString *proName){
        _proTipLB.text = proName;
        _proTipLB.textColor = [UIColor blackColor];
    };
    [self.navigationController pushViewController:selectProVC animated:YES];
}
- (void)selectCity{
    if ([_proTipLB.text isEqualToString:@"请选择省份"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tip" message:@"请先选择省份" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    SJSelectProAndCityViewController *selectCityVC = [[SJSelectProAndCityViewController alloc] initWithType:SJStationType_City];
    [self.navigationController pushViewController:selectCityVC animated:YES];
    selectCityVC.stationCityBlock = ^(NSString *cityName){
        _cityTipLB.text = cityName;
        _cityTipLB.textColor = [UIColor blackColor];
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearBtnClick:(UIButton *)sender {
    _proTipLB.text = @"请选择省份";
    _proTipLB.textColor = [UIColor lightGrayColor];
    _cityTipLB.text = @"请选择城市";
    _cityTipLB.textColor = [UIColor lightGrayColor];
}
@end
