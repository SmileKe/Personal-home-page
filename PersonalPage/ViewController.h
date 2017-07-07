//
//  ViewController.h
//  PersonalPage
//
//  Created by cc on 2017/7/6.
//  Copyright © 2017年 keke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UITableView *perTableView;
@property (nonatomic, assign) CGRect origialFrame;
/**
 *  按钮选中,中间值
 */
@property (nonatomic,strong) UIButton *selectedBtn;
@end

