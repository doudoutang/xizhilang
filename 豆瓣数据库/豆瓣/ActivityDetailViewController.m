//
//  ActivityDetailViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/7/25.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "DataBaseHandle.h"
#import "LoginViewController.h"
@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController

//- (void)loadView {
//    self.activityView = [[AcitivityView alloc] init];
//    self.view = _activityView;
//}

//- (void)setActivityList:(ActivityList *)activityList {
//    
//    NSLog(@"%@",activityList.title);
//    _activityList = activityList;
//    _titleLable.text = activityList.title;
//    NSLog(@"%@",_titleLable.text);
//}

- (void)viewDidLoad {
    [super viewDidLoad]; 
    // Do any additional setup after loading the view.
    _titleLable.text = _activityList.title;
    _contentLable.text = _activityList.content;
    
    NSRange range = NSMakeRange(5, 11);
    if (_activityList.begin_time.length > 11) {
        NSString *beginStr = _activityList.begin_time;
        
        _begin_timeLable.text = [beginStr substringWithRange:range];
    }else {
        _begin_timeLable.text = _activityList.begin_time;
    }
    if (_activityList.end_time.length > 11) {
        NSString *endStr = _activityList.end_time;
        _end_timeLable.text = [endStr substringWithRange:range];
    }else {
        _end_timeLable.text = _activityList.begin_time;
    }
    
    

    _addressLable.text = _activityList.address;
    _nameLable.text = _activityList.name;
    _category_nameLable.text = _activityList.category_name;
    _imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_activityList.image]]];
    
}



- (void)viewDidAppear:(BOOL)animated {
    
    CGFloat height = [self getHeightWithText:_contentLable.text];
    if (height + 350 < CGRectGetHeight(self.view.frame)) {
        self.scrollView.contentSize = CGSizeMake(311, CGRectGetHeight(self.view.frame));
    }else {
        self.scrollView.contentSize = CGSizeMake(311, height + 350);
    }
    CGRect contentView = _contentLable.frame;
    contentView.size.height = height;
    _contentLable.frame = contentView;
//
//    
//    
//    CGRect contentRect = [self.contentLable.text boundingRectWithSize:CGSizeMake(280, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
//    CGFloat height = 200 +contentRect.size.height+50;
//    
//    if (height < self.view.bounds.size.height) {
//        
//        height = self.view.bounds.size.height + 30;
//    }
//    
//    self.scrollView.contentSize = CGSizeMake(311, height);
//    
//    
//    
//    CGRect contentViewRect = _contentLable.frame;
//    contentViewRect.size.height = contentRect.size.height;
//    _contentLable.frame = contentViewRect;

}

- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)sharedBarButton:(UIBarButtonItem *)sender {
    
    BOOL state = [[NSUserDefaults standardUserDefaults] boolForKey:@"state"];
    
    if (state == 1) {
        
        [[DataBaseHandle sharedInstance] creatSql];
        NSInteger userRowid = [[NSUserDefaults standardUserDefaults] integerForKey:@"userRowid"];
        ActivityList *activityList = [[DataBaseHandle sharedInstance] queryUserActivity:userRowid title:_titleLable.text];
        if (activityList == nil) {
            
            [[DataBaseHandle sharedInstance] addDataWithTitle:_titleLable.text userRowid:userRowid content:_contentLable.text begin_time:_activityList.begin_time end_time:_activityList.end_time address:_addressLable.text name:_nameLable.text category_name:_category_nameLable.text image:_activityList.image];
            
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertC animated:YES completion:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"该活动已经被收藏过" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertC addAction:tureAction];
            [self presentViewController:alertC animated:YES completion:nil];
        }
        
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
    
}


- (CGFloat)getHeightWithText:(NSString *)text
{
    CGSize size = CGSizeMake(311, 1000);
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat height = rect.size.height;
    return height;
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


@end
