//
//  UserTableViewController.h
//  豆瓣
//
//  Created by lanou3g on 15/7/25.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewController : UITableViewController

@property (nonatomic ,retain) NSIndexPath *indexPath;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *loginBarButton;

- (IBAction)didClickLoginBarButoon:(UIBarButtonItem *)sender;

@property (nonatomic, retain) NSString *usrename;

@end
