//
//  RegisterViewController.h
//  豆瓣
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *usernameTF;

@property (strong, nonatomic) IBOutlet UITextField *passwordTF;

@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTF;

@property (strong, nonatomic) IBOutlet UITextField *mailTF;

@property (strong, nonatomic) IBOutlet UITextField *telephoneTF;

- (IBAction)registerBarButton:(UIBarButtonItem *)sender;



















@end
