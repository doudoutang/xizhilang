//
//  UserTableViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/7/25.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "UserTableViewController.h"
#import "UserTableViewCell.h"
#import "LoginViewController.h"
#import "ActivityCollectTableViewController.h"
#import "MovieCollectTableViewController.h"
#import "LoginViewController.h"
#import "DataBaseHandle.h"


@interface UserTableViewController ()
@property (nonatomic, retain) NSArray *cellArray;

@property (nonatomic, assign) BOOL state;
@end

@implementation UserTableViewController

- (void)viewWillAppear:(BOOL)animated {
    
    BOOL state = [[NSUserDefaults standardUserDefaults] boolForKey:@"state"];
    if (state == 1) {
        
        self.navigationItem.rightBarButtonItem.title = @"注销";
    }else {
        self.navigationItem.rightBarButtonItem.title = @"登录";
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.cellArray = [NSArray arrayWithObjects:@"我的活动",@"我的电影",@"清除缓存", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _cellArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user" forIndexPath:indexPath];
    
    cell.titleLable.text = _cellArray[indexPath.row];
    
    
    return cell;
}
                  
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    
    BOOL state = [[NSUserDefaults standardUserDefaults] boolForKey:@"state"];
    
        
        if (_indexPath.row == 0) {
            
            if (state == 1) {
               
                ActivityCollectTableViewController *activityCollectTVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"activityCollect"];
                activityCollectTVC.title = @"活动收藏";
                [self.navigationController pushViewController:activityCollectTVC animated:YES];
                
            }else {
                
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请登录后进行收藏" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                [alertC addAction:cancleAction];
                
                UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    LoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"loginVC"];
                    [self presentViewController:loginVC animated:YES completion:nil];
                    
                }];
                [alertC addAction:tureAction];
                [self presentViewController:alertC animated:YES completion:nil];

                
            }
            
        }else if (_indexPath.row == 1) {
            if (state == 1) {
                
                MovieCollectTableViewController *movieCollectTVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"movieCollect"];
                movieCollectTVC.title = @"电影收藏";
                [self.navigationController pushViewController:movieCollectTVC animated:YES];
                
            }else {
                
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请登录后进行收藏" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                [alertC addAction:cancleAction];
                
                UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    LoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"loginVC"];
                    [self presentViewController:loginVC animated:YES completion:nil];
                    
                }];
                [alertC addAction:tureAction];
                [self presentViewController:alertC animated:YES completion:nil];
                
            }

        }else {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清除缓存" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertC addAction:cancleAction];
            [alertC addAction:tureAction];
            
            [self presentViewController:alertC animated:YES completion:nil];
            
            NSInteger userRowid = [[NSUserDefaults standardUserDefaults] integerForKey:@"userRowid"];
            [[DataBaseHandle sharedInstance] deleteAllActivityByuserRowid:userRowid];
            [[DataBaseHandle sharedInstance] deleteAllMovieByUserRowid:userRowid];
         }
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"login"]) {
        
        NSString *title = self.navigationItem.rightBarButtonItem.title;
        
        if (![title isEqualToString:@"登录"]) {
            
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认注销" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userRowid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                self.navigationItem.rightBarButtonItem.title = @"登录";
            }];
            [alertC addAction:cancleAction];
            [alertC addAction:tureAction];
            
            [self presentViewController:alertC animated:YES completion:nil];
            
        }
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    
//    //BOOL state = [[NSUserDefaults standardUserDefaults] boolForKey:@"state"];
//    
//    LoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"loginVC"];
//    NSString *username = loginVC.username.text;
//    
//    if ([username isEqualToString:@""]) {
//        _state = NO;
//        _loginBarButton.title = @"注销";
//    }else {
//        _state = YES;
//        _loginBarButton.title = @"登录";
//    }
//    
//    
//}

- (IBAction)didClickLoginBarButoon:(UIBarButtonItem *)sender {
    
    
    
    
    
    
    
    
    
    
    
    
//    BOOL state = [[NSUserDefaults standardUserDefaults] boolForKey:@"state"];
//    NSLog(@"%d",state);
//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    NSString *username = loginVC.username.text;
//    NSString *password = loginVC.password.text;
//    
//    if ((![username isEqualToString:@""]) && (![password isEqualToString:@""])) {
//        state = YES;
//        _loginBarButton.title = @"注销";
//    }else {
//        state = NO;
//    }
    
//    if (state == YES) {
//        _loginBarButton.title = @"注销";
//    }else {
//        _loginBarButton.title = @"登录";
//    }
    
}

















@end
