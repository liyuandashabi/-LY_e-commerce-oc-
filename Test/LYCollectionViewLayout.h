//
//  LYCollectionViewLayout.h
//  瀑布流
//
//  Created by ly on 2017/2/14.
//  Copyright © 2017年 com.Joyetech.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYCollectionViewLayout;

@protocol LYCollectionViewLayoutDelegate <NSObject>

@required
-(CGFloat)LYViewLayout:(LYCollectionViewLayout *)LYViewLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
-(CGFloat)columnCountInViewLayout:(LYCollectionViewLayout *)ViewLayout;

-(CGFloat)columnMarginInInViewLayout:(LYCollectionViewLayout *)ViewLayout;

-(CGFloat)rowMarginInViewLayout:(LYCollectionViewLayout *)ViewLayout;

-(UIEdgeInsets)edgeInsetsInViewLayout:(LYCollectionViewLayout *)ViewLayout;
@end



@interface LYCollectionViewLayout : UICollectionViewLayout

@property (nonatomic,weak) id<LYCollectionViewLayoutDelegate> delegate;


@end
