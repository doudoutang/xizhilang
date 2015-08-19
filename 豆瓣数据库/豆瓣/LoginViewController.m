//
//  LoginViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/7/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "UserTableViewController.h"
#import "DataBaseHandle.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)loginButton:(UIButton *)sender {
    
    //NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:_username.text];
    User *user = [[DataBaseHandle sharedInstance] queryUserByUsername:_username.text];
    
    if (user == nil) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名未发现,请注册" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:cancleAction];
        [alertC addAction:confirmAction];
        
        [self presentViewController:alertC animated:YES completion:nil];
    }else {
        
        if ([user.password isEqualToString:_password.text]) {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"state"];
            [[NSUserDefaults standardUserDefaults] setInteger:user.userRowid forKey:@"userRowid"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"state"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertC addAction:cancleAction];
            [alertC addAction:confirmAction];
            
            [self presentViewController:alertC animated:YES completion:nil];
        }

        
    }
    /*
    if ([_password.text isEqualToString:password]) {
//        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
//        [self presentViewController:alertC animated:YES completion:nil];
//        
//        [self dismissViewControllerAnimated:YES completion:nil];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"state"];
        
//        UserTableViewController *userTVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"user"];
//        
//        userTVC.usrename = _username.text;
//        NSLog(@"+++++++++%@,%@",userTVC.usrename,_username.text);
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }else {
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"state"];
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:cancleAction];
        [alertC addAction:confirmAction];
        
        [self presentViewController:alertC animated:YES completion:nil];
    }
 */
}

- (IBAction)registerButton:(UIButton *)sender {
}
@end
