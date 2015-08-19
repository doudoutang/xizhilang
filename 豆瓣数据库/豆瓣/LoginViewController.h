//
//  LoginViewController.h
//  豆瓣
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

- (IBAction)back:(UIBarButtonItem *)sender;

- (IBAction)loginButton:(UIButton *)sender;

- (IBAction)registerButton:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITextField *username;

@property (strong, nonatomic) IBOutlet UITextField *password;


@end
