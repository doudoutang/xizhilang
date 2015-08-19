//
//  MovieDetailViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/7/26.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieDetail.h"
#import "DataBaseHandle.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "UIImageView+WebCache.h"
@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/searchmovie.php?movieId=";
    NSString *urlString = [str stringByAppendingString:_movieId];
    
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dict = dic[@"result"];
        
        self.movieDetail = [[MovieDetail alloc] init];
        [_movieDetail setValuesForKeysWithDictionary:dict];
        self.navigationItem.title = _movieDetail.title;
        _plot_simpleLable.text = _movieDetail.plot_simple;
        _genresLable.text = _movieDetail.genres;
        _plot_simpleLable.text = _movieDetail.plot_simple;
        _countryLable.text = _movieDetail.country;
        _runtimeLable.text = _movieDetail.runtime;
        
        NSMutableString *str = [NSMutableString stringWithString:@"(评论)"];
        [str insertString:_movieDetail.rating_count atIndex:1];
        _rating_count.text = str;
        _ratingLable.text = _movieDetail.rating;
        _release_dataLable.text = _movieDetail.release_date;
        _actorsLable.text = _movieDetail.actors;
        _imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_movieDetail.poster]]];
//        if ([self.type isEqualToString:@"detail1"]) {
//        
//                    _imgView.image = _image;
//        }else{
//            
//            [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
//        }
        
    }];
    
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

- (IBAction)backBarButton:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)sharedBarButton:(UIBarButtonItem *)sender {

    BOOL state = [[NSUserDefaults standardUserDefaults] boolForKey:@"state"];
    if (state == 1) {
        NSString *title = _movieDetail.title;
        [[DataBaseHandle sharedInstance] creatMovieSql];
        NSInteger userRowid = [[NSUserDefaults standardUserDefaults] integerForKey:@"userRowid"];
        MovieDetail *movieDetail = [[DataBaseHandle sharedInstance] queryUserMovie:userRowid title:title];
        if (movieDetail == nil ) {
            
            [[DataBaseHandle sharedInstance] addMovieDataWithTitle:title userRowid:userRowid movieId:_movieId pic_url:_imageUrl];
            
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertC animated:YES completion:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"该电影已经被收藏过" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertC addAction:tureAction];
            [self presentViewController:alertC animated:YES completion:nil];
        }
        
    } else {
        
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

   
}
@end
