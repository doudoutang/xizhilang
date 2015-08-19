//
//  MovieListTableViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieListTableViewController.h"
#import "MovieListTableViewCell.h"
#import "MovieList.h"
#import "MovieDetailViewController.h"
#import "MovieTileCollectionViewController.h"
@interface MovieListTableViewController ()

@property (nonatomic, retain) NSMutableArray *movieArray;

@end

@implementation MovieListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    
    NSURL *url = [NSURL URLWithString:@"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/movielist.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"result"];
        self.movieArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            MovieList *movieList = [[MovieList alloc] init];
            [movieList setValuesForKeysWithDictionary:dict];
            [_movieArray addObject:movieList];
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
    return _movieArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieList" forIndexPath:indexPath];
    
    MovieList *movieList = _movieArray[indexPath.row];
    cell.movieList = movieList;
    
    if (movieList.image == nil) {
        [movieList loadImage];
        
        [movieList addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:(__bridge void *)(indexPath)];
    }else {
        cell.imgView.image = movieList.image;
    }
    
    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    UIImage *image = change[@"new"];
    NSIndexPath *indexPath = (__bridge NSIndexPath *)(context);
    NSArray *showArray = [self.tableView indexPathsForVisibleRows];
    
    if ([showArray containsObject:indexPath]) {
        MovieListTableViewCell *cell = (MovieListTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.imgView.image = image;
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [object removeObserver:self forKeyPath:keyPath context:context];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    self.indexPath = indexPath;
    
    [self performSegueWithIdentifier:@"movieDetail" sender:self];

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"movieDetail"]) {
        
        MovieDetailViewController *movieDetailVC = (MovieDetailViewController *)segue.destinationViewController;
        MovieList *movieList = _movieArray[_indexPath.row];
        movieDetailVC.movieId = movieList.movieId;
        movieDetailVC.image = movieList.image;
        movieDetailVC.type = @"detail1";

    }
    else if ([segue.identifier isEqualToString:@"Cell"]) {
        MovieTileCollectionViewController *movieTileCVC = (MovieTileCollectionViewController *)segue.destinationViewController;
        [UITableView transitionFromView:self.view toView:movieTileCVC.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        }];
        
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





- (IBAction)tileBarButton:(UIBarButtonItem *)sender {
    
    MovieTileCollectionViewController *movieTileCVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Cell"];
    
    
    [UITableView transitionFromView:self.view toView:movieTileCVC.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        [movieTileCVC view];
    }];
    

}
@end
