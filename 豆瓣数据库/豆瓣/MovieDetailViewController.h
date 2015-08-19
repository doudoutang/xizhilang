//
//  MovieDetailViewController.h
//  豆瓣
//
//  Created by lanou3g on 15/7/26.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetail.h"
@interface MovieDetailViewController : UIViewController

@property (nonatomic, retain) NSString *movieId;

@property (strong, nonatomic) IBOutlet UILabel *ratingLable;

@property (strong, nonatomic) IBOutlet UILabel *rating_count;

@property (strong, nonatomic) IBOutlet UILabel *actorsLable;

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@property (strong, nonatomic) IBOutlet UILabel *countryLable;

@property (strong, nonatomic) IBOutlet UILabel *genresLable;

@property (strong, nonatomic) IBOutlet UILabel *runtimeLable;

@property (strong, nonatomic) IBOutlet UILabel *release_dataLable;

@property (strong, nonatomic) IBOutlet UILabel *plot_simpleLable;

@property (nonatomic, retain) MovieDetail *movieDetail;
@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic, retain) UIImage *image;
//用来区别那个界面推过来的
@property (nonatomic, strong) NSString *type;

- (IBAction)backBarButton:(UIBarButtonItem *)sender;

- (IBAction)sharedBarButton:(UIBarButtonItem *)sender;


@end
