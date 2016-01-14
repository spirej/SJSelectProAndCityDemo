//
//  SJSelectProAndCityViewController.h
//  SJSelectProAndCityDemo
//
//  Created by SPIREJ on 16/1/14.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SJStationType){
    SJStationType_Pro,
    SJStationType_City
};

@interface SJSelectProAndCityViewController : UIViewController

- (instancetype)initWithType:(SJStationType)type;
@property(nonatomic, copy) void(^stationProBlock)(NSString *proName);
@property(nonatomic, copy) void(^stationCityBlock)(NSString *cityName);
@property (weak, nonatomic) IBOutlet UITableView *stationTableView;

@end
