//
//  MovieListTableViewController.h
//  豆瓣
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieListTableViewController : UITableViewController

@property (nonatomic, retain) NSIndexPath *indexPath;

- (IBAction)tileBarButton:(UIBarButtonItem *)sender;


@end
