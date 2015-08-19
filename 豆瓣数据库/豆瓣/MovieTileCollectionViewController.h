//
//  MovieTileCollectionViewController.h
//  豆瓣
//
//  Created by lanou3g on 15/7/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieList.h"
@interface MovieTileCollectionViewController : UICollectionViewController

@property (nonatomic, retain) MovieList *movieList;

@property (nonatomic, retain) NSMutableArray *movieArray;

- (IBAction)backListPage:(UIBarButtonItem *)sender;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end
