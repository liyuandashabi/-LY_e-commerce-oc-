//
//  MainViewController.m
//  Test
//
//  Created by User on 2017/2/9.
//  Copyright © 2017年 com.Joyetech.test. All rights reserved.
//

#import "MainViewController.h"
#import "XRCarouselView.h"
#import "MJRefresh.h"
#import "activityViewController.h"
#import "cyclePlayDetailViewController.h"
#import "LYCollectionViewLayout.h"

#define LYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LYRandomColor LYColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface MainViewController () <XRCarouselViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,LYCollectionViewLayoutDelegate>

@property (weak, nonatomic) IBOutlet XRCarouselView *picView;

@property (weak, nonatomic) IBOutlet UIButton *changeToActivityBtn;

@property (weak, nonatomic) IBOutlet UICollectionView *LYCollectionView;

@end

@implementation MainViewController
static NSString *const LYShopId=@"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self cyclePlayPic];
    
    [self changeToActivityBtnSetting];
    
    [self collectionInitSetting];
    
    [self setuoRefresh];
}

#pragma mark - ActivitySkip
-(void)changeToActivityBtnSetting {
    
    [self.changeToActivityBtn addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)skip:(UIButton *)sender {
    UIStoryboard *storyboard=self.storyboard;
    activityViewController *activityVC=[storyboard instantiateViewControllerWithIdentifier:@"aVC"];
    activityVC.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:activityVC animated:YES completion:nil];
}

#pragma mark - 刷新加载
-(void)setuoRefresh {
    self.LYCollectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendRequest)];
    [self.LYCollectionView.mj_header beginRefreshing];

    self.LYCollectionView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.LYCollectionView.mj_footer.hidden = YES;
}

-(void)sendRequest {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.LYCollectionView.mj_header endRefreshing];
    });

}

-(void)loadMore {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.LYCollectionView.mj_footer endRefreshing];
    });
}

#pragma mark - 设置轮播图
-(void)cyclePlayPic {
    
    NSArray *arr=@[[UIImage imageNamed:@"cycle_image1.png"],  // ******************
                   [UIImage imageNamed:@"cycle_image2.png"],  //   网络图片用@"http://********
                   [UIImage imageNamed:@"cycle_image3.png"],  //
                   [UIImage imageNamed:@"cycle_image4.png"],  //
                   [UIImage imageNamed:@"cycle_image5.png"],  //
                   [UIImage imageNamed:@"cycle_image1.png"]]; //*************************
    
    //设置图片数组及图片描述文字
    _picView.imageArray = arr;
    //用代理处理图片点击
    _picView.delegate = self;
    //设置每张图片的停留时间，默认值为5s，最少为2s
    _picView.time = 2;
    //淡入淡出模式
    _picView.changeMode=ChangeModeFade;
    //设置分页控件的位置，默认为PositionBottomCenter
    _picView.pagePosition = PositionBottomRight;
    //设置分页控件指示器的颜色
    [_picView setPageColor:[UIColor whiteColor] andCurrentPageColor:[UIColor yellowColor]];
    //设置图片切换的方式
    _picView.changeMode = ChangeModeFade;
    //用block处理图片点击事件
    _picView.imageClickBlock = ^(NSInteger index){
        NSLog(@"点击了第%ld张图片", (long)index);
        UIStoryboard *storyboard=self.storyboard;
        cyclePlayDetailViewController *cPDVC=[storyboard instantiateViewControllerWithIdentifier:@"CPDVC_1"];
        cPDVC.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        [self presentViewController:cPDVC animated:YES completion:nil];
    };
}

#pragma mark - collectionSetting
-(void)collectionInitSetting {
    LYCollectionViewLayout *LYLayout=[[LYCollectionViewLayout alloc]init];
    LYLayout.delegate=self;
    
    self.LYCollectionView.collectionViewLayout=LYLayout;
    [self.LYCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:LYShopId];
    

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 50;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:LYShopId forIndexPath:indexPath ];
    cell.backgroundColor=LYRandomColor;
    
    NSInteger tag = 10;
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = tag;
        [cell.contentView addSubview:label];
    }
    
    label.text = [NSString stringWithFormat:@"%zd", indexPath.item];
    [label sizeToFit];
    
    return cell;
}

#pragma mark - layoutDelegate
-(CGFloat)LYViewLayout:(LYCollectionViewLayout *)LYViewLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    return 100 + arc4random_uniform(150);
}

-(CGFloat)rowMarginInViewLayout:(LYCollectionViewLayout *)ViewLayout {
    return 5;
}

-(CGFloat)columnMarginInInViewLayout:(LYCollectionViewLayout *)ViewLayout {
    return 5;
}

-(CGFloat)columnCountInViewLayout:(LYCollectionViewLayout *)ViewLayout {
    return 2;
}

-(UIEdgeInsets)edgeInsetsInViewLayout:(LYCollectionViewLayout *)ViewLayout {
    return UIEdgeInsetsMake(2, 2, 2, 2);
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
