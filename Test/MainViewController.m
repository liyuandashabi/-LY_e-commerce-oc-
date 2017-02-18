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
#import "detailCollectionViewCell.h"
#import "productsDetailViewController.h"

#define LYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LYRandomColor LYColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface MainViewController () <XRCarouselViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet XRCarouselView *picView;

//活动按钮
@property (weak, nonatomic) IBOutlet UIButton *changeToActivityBtn;
//
@property (weak, nonatomic) IBOutlet UICollectionView *LYCollectionView;

@property (strong,nonatomic) NSMutableArray *arr;

@end

@implementation MainViewController
static NSString *const LYShopId=@"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self cyclePlayPic];
    
    [self changeToActivityBtnSetting];
    
    [self setuoRefresh];
    
    [self collectionCellSetting];
    
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
        //草泥马这一步坑的我好惨啊！要在跳转之前赋值！
        cPDVC.picNumber=index;
        NSLog(@"现在点击了的是：%ld",cPDVC.picNumber);
        [self presentViewController:cPDVC animated:YES completion:nil];
    };
   
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

#pragma mark - 上拉刷新加载
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

#pragma mark - CollectionSetting
-(void)collectionCellSetting {
    self.arr=[[NSMutableArray alloc]initWithCapacity:5];
    
    for (int i=0; i<5 ; i++) {
        [self.arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"detail_%d.jpg",i+1]]];
    }
    
    [self.LYCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Reusable"];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     detailCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:LYShopId forIndexPath:indexPath];
    cell.detailImage.image = [self.arr objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - 点击row事件

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"第%ld个section，第%ld个cell被点击了",(long)indexPath.section,(long)indexPath.row);
    
    UIStoryboard *storyboard=self.storyboard;
    
    productsDetailViewController *productsDetailVC=[storyboard instantiateViewControllerWithIdentifier:@"proDetail"];
    
    productsDetailVC.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    
    switch (indexPath.row) {
        case 0:
            productsDetailVC.index=indexPath.row;
            break;
        case 1:
            productsDetailVC.index=indexPath.row;
            break;
        case 2:
             productsDetailVC.index=indexPath.row;
            break;
        case 3:
             productsDetailVC.index=indexPath.row;
            break;
        case 4:
             productsDetailVC.index=indexPath.row;
            break;
    }
    [self presentViewController:productsDetailVC animated:YES completion:^{
        productsDetailVC.index=indexPath.row;
    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.LYCollectionView.frame.size.width, self.LYCollectionView.frame.size.height/1.5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
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
