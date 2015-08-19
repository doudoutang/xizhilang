//
//  RegisterViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "RegisterViewController.h"
#import "User.h"
#import "LoginViewController.h"
#import "DataBaseHandle.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)registerBarButton:(UIBarButtonItem *)sender {
    
    
    
    if ([self.usernameTF.text isEqualToString:@""] || [self.passwordTF.text isEqualToString:@""]) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名,密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertC addAction:cancleAction];
        
        [self presentViewController:alertC animated:YES completion:nil];
        
    }else {
        
        if ([self.passwordTF.text isEqualToString:self.confirmPasswordTF.text]) {
            
            User *user = [[DataBaseHandle sharedInstance] queryUserByUsername:self.usernameTF.text];
            if (user != nil) {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名已存在" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                
                [alertC addAction:cancleAction];
                
                [self presentViewController:alertC animated:YES completion:nil];
                
            }else {
                
                User *user1 = [[User alloc] initWithUsername:_usernameTF.text password:_passwordTF.text mail:_mailTF.text telephone:_telephoneTF.text];
                
                [[DataBaseHandle sharedInstance] creatUserinfoSql];
                [[DataBaseHandle sharedInstance] addUserWithUser:user1];
                
                //[[NSUserDefaults standardUserDefaults] setObject:_passwordTF.text forKey:_usernameTF.text];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
   
        }else {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次密码输入不一致" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            
            [alertC addAction:cancleAction];
            [alertC addAction:confirmAction];
            [self presentViewController:alertC animated:YES completion:nil];
        }
    }
    
}
@end
