//
//  MovieTileCollectionViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieTileCollectionViewController.h"
#import "MovieTileCollectionViewCell.h"
#import "MovieList.h"
#import "MovieDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "ImageDownloader.h"
#import "MovieListTableViewController.h"

#define kUrl @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/movielist.php"

@interface MovieTileCollectionViewController ()

@end

@implementation MovieTileCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    //解析数据
    [self p_jsonData];

}

- (void)p_jsonData {
           
    self.movieArray = [NSMutableArray array];
    
    NSURL *url = [NSURL URLWithString:kUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        dispatch_queue_t mainQ = dispatch_get_main_queue();
        dispatch_async(mainQ, ^{
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *array = dic[@"result"];
            for (NSDictionary *dict in array) {
                MovieList *movie = [[MovieList alloc] init];
                [movie setValuesForKeysWithDictionary:dict];
                [self.movieArray addObject:movie];
            }
            [self.collectionView reloadData];
        });
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"movieDetail"]) {
        MovieDetailViewController *movieDetailVC = (MovieDetailViewController *)segue.destinationViewController;
        MovieList *movieList = _movieArray[_indexPath.item];
        movieDetailVC.movieId = movieList.movieId;
        movieDetailVC.image = movieList.image;
        movieDetailVC.imageUrl = movieList.pic_url;
//        movieDetailVC.image = movieDetailVC.imgView.image;
        movieDetailVC.type = @"detail2";
    }
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete method implementation -- Return the number of items in the section
    
    return _movieArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieTileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    MovieList *movieList = _movieArray[indexPath.item];
    cell.movieList = movieList;
//    if (movieList.image == nil) {
//        [movieList loadImage];
//        
//        //添加观察者
//        [movieList addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:(__bridge void *)(indexPath)];
//        
//    }else {
//        cell.imgView.image = movieList.image;
//    }
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:movieList.pic_url]];
    
    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    UIImage *image = change[@"new"];
    NSIndexPath *indexPath = (__bridge NSIndexPath *)(context);
    NSArray *array = [self.collectionView indexPathsForVisibleItems];
    
    if ([array containsObject:indexPath]) {
        MovieTileCollectionViewCell *cell = (MovieTileCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        cell.imgView.image = image;
    }
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    //移除观察者
    [object removeObserver:object forKeyPath:keyPath context:context];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //MovieList *movie = _movieArray[indexPath.item];
    self.indexPath = indexPath;
    [self performSegueWithIdentifier:@"movieDetail" sender:self];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (IBAction)backListPage:(UIBarButtonItem *)sender {
    
    MovieListTableViewController *movieListTVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"movieListTVC"];
    movieListTVC.view.backgroundColor = [UIColor redColor];
    NSLog(@"%@",[self.view.superview class]);
    [UIView transitionFromView:self.view toView:movieListTVC.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        
          [movieListTVC.tableView reloadData];
    }];
//    [UITableView transitionWithView:self.view duration:2.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    } completion:nil];
    
}














@end
