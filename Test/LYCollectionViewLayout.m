//
//  LYCollectionViewLayout.m
//  瀑布流
//
//  Created by ly on 2017/2/14.
//  Copyright © 2017年 com.Joyetech.test. All rights reserved.
//

#import "LYCollectionViewLayout.h"

/** 默认的列数 */
static const NSInteger LYDefaultColumnCount = 1;
/** 每一列之间的间距 */
static const CGFloat LYDefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const CGFloat LYDefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets LYDefaultEdgeInsets = {40, 40, 40, 40};

@interface LYCollectionViewLayout  ()

/** 存放所有cell的布局属性 **/
@property (nonatomic,strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 **/
@property (nonatomic,strong) NSMutableArray *columnHeights;
/** 内容的高度 **/
@property (nonatomic,assign) CGFloat contentHeight;

-(CGFloat)rowMargin;

-(CGFloat)columMargin;

-(NSInteger)colunmCount;

-(UIEdgeInsets)edgeInsets;

@end

@implementation LYCollectionViewLayout

#pragma mark - 处理数据
-(CGFloat)rowMargin {
    if([self.delegate respondsToSelector:@selector(rowMarginInViewLayout:)]) {
        return [self.delegate rowMarginInViewLayout:self];
    }else {
        return LYDefaultRowMargin;
    }
}

-(CGFloat)columMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInInViewLayout:)]) {
        return [self.delegate columnMarginInInViewLayout:self];
    }else{
        return LYDefaultColumnMargin;
    }
}

-(NSInteger)colunmCount {
    if ([self.delegate respondsToSelector:@selector(columnCountInViewLayout:)]) {
        return [self.delegate columnCountInViewLayout:self];
    }else{
        return LYDefaultColumnCount;
    }
}

-(UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInViewLayout:)]) {
        return [self.delegate edgeInsetsInViewLayout:self];
    }else{
        return LYDefaultEdgeInsets;
    }
    
}

#pragma mark - 懒加载
-(NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights=[NSMutableArray array];
    }
    return _columnHeights;
}

-(NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray=[NSMutableArray array];
    }
    return _attrsArray;
}

-(void)prepareLayout {
    [super prepareLayout];
    
    self.columnHeights=0;
    
    //清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for(NSInteger i=0;i<self.colunmCount;i++){
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    //清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    //开始创建每一个cell对应的布局属性
    NSInteger count=[self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }

}

/****
 **决定cell的排布
 ****/
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.attrsArray;
    
}

/*****
 ***返回indexPath位置cell对应的布局属性
 *****/
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //创建布局属性
    UICollectionViewLayoutAttributes *attrs=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //collectionView的宽度
    CGFloat collectionViewW=self.collectionView.frame.size.width;
    
    //设置布局属性的frame
    CGFloat w=(collectionViewW-self.edgeInsets.left-self.edgeInsets.right-(self.colunmCount-1)*self.columMargin)/self.colunmCount;
    CGFloat h=[self.delegate LYViewLayout:self heightForItemAtIndex:indexPath.item itemWidth:w];
    
    //找出高度最短的那一列
    NSInteger destColumn=0;
    CGFloat minColumnHeight=[self.columnHeights[0] doubleValue];
    for (NSInteger i=1; i<self.colunmCount; i++) {
        //取得第i列的高度
        CGFloat columnHeight=[self.columnHeights[i] doubleValue];
        if (minColumnHeight>columnHeight) {
            minColumnHeight=columnHeight;
            destColumn=i;
        }
    }
    CGFloat x=self.edgeInsets.left+destColumn * (w + self.columMargin);
    CGFloat y=minColumnHeight;
    if (y !=self.edgeInsets.top) {
        y +=self.rowMargin;
    }
    //获得frame
    attrs.frame=CGRectMake(x, y, w, h);
    
    //更新最短那列的高度
    self.columnHeights[destColumn]=@(CGRectGetMaxY(attrs.frame));
    
    //记录内容的高度
    CGFloat columnHeight=[self.columnHeights[destColumn]doubleValue];
    if (self.contentHeight<columnHeight) {
        self.contentHeight=columnHeight;
    }
    return attrs;
}

-(CGSize)collectionViewContentSize {
    
    return CGSizeMake(0,self.contentHeight+self.edgeInsets.bottom);
    
}

@end





























