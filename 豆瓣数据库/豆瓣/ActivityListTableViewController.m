//
//  ActivityListTableViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ActivityListTableViewController.h"
#import "ActivityListTableViewCell.h"
#import "ActivityList.h"
#import "ActivityDetailViewController.h"
#import "DataBaseHandle.h"
@interface ActivityListTableViewController ()
@property (nonatomic, retain) NSMutableArray *activityListArray;
@end

@implementation ActivityListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];

    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"state"];
    
    [[DataBaseHandle sharedInstance] open];
    NSURL *url = [NSURL URLWithString:@"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/activitylist.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //设置请求方式
    //[request setHTTPMethod:@"POST"];
    
    //设置请求体
//    NSData *data = [@"" dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:data];
    
    //5.创建链接对象
    __weak ActivityListTableViewController *activityListTVC = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        activityListTVC.activityListArray = [NSMutableArray array];
        NSArray *array = dic[@"events"];
        for (NSDictionary *dict in array) {
            NSDictionary *ownerDic = dict[@"owner"];
            NSString *nameStr = ownerDic[@"name"];
            [dict setValue:nameStr forKey:@"name"];
            ActivityList *activityList = [[ActivityList alloc] init];
            [activityList setValuesForKeysWithDictionary:dict];
            [_activityListArray addObject:activityList];
        }
        [self.tableView reloadData];
    }];
    
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
    return _activityListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"activityList" forIndexPath:indexPath];
    
    ActivityList *activityList = _activityListArray[indexPath.row];
    cell.activityList = activityList;
    
    if (activityList.picture == nil) {
        [activityList loadImage];
        
        [activityList addObserver:self forKeyPath:@"picture" options:NSKeyValueObservingOptionNew context:(__bridge void *)(indexPath)];
        
    }else {
        cell.imgView.image = activityList.picture;
    }
    
    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    UIImage *image = [change objectForKey:@"new"];
    NSIndexPath *indexPath = (__bridge NSIndexPath *)(context);
    NSArray *showArray = [self.tableView indexPathsForVisibleRows];
    
    if ([showArray containsObject:indexPath]) {
        ActivityListTableViewCell *cell = (ActivityListTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.imgView.image = image;
    }
    //手动刷新某行
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [object removeObserver:self forKeyPath:keyPath context:context];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.indexPath = indexPath;
    [self performSegueWithIdentifier:@"activityDetail" sender:self];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"activityDetail"]) {
        ActivityDetailViewController *activityDetailVC1 = (ActivityDetailViewController *)segue.destinationViewController;
        ActivityList *activityList = _activityListArray[_indexPath.row];
        activityDetailVC1.activityList = activityList;
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





@end
