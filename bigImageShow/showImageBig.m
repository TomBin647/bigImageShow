//
//  showMorePictureController.m
//  bigImageShow
//
//  Created by 高彬 on 15/10/29.
//  Copyright © 2015年 高彬. All rights reserved.
//

#import "showImageBig.h"
#import "showPictureViewController.h"

#import "showOneImagePictureController.h"

#define GBMainViewWidth self.bounds.size.width

#define GBMainViewHeight self.bounds.size.height



@interface showImageBig ()<UIScrollViewDelegate,UIActionSheetDelegate> {
    CGFloat startContentOffsetX;
    
    CGFloat willEndContentOffsetX;
    
    CGFloat endContentOffsetX;
}

@property (nonatomic,strong) UIView * containerView;

@property (nonatomic,strong) UIImageView * imageView;


@property (nonatomic) CGSize minSize;

@property (nonatomic,assign) NSInteger chooseIndex;

@property (nonatomic,strong) NSMutableArray * moreArrImage;


@property (nonatomic,strong) NSMutableArray * curViews;


@end

@implementation showImageBig

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(instancetype) initWithFrame:(CGRect)frame addImageArrUrl:(NSMutableArray *)imageArr addImageIndex:(NSInteger)imageIndex {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.contentSize = CGSizeMake(3 * GBMainViewWidth, 0);
        self.contentOffset = CGPointMake(GBMainViewWidth, 0);
        self.directionalLockEnabled = YES;
        self.moreArrImage = [NSMutableArray new];
        self.moreArrImage = imageArr;
        self.chooseIndex = imageIndex;
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 30;
        rect.size.height = 30;
        
        [self loadView];
        
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushNext:) name:@"pushNext" object:nil];
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushUp:) name:@"PushUp" object:nil];
    }
    return  self;
}
#pragma mark - UIScrollViewDelegate

//-(void)pushNext:(NSNotification *) notic{
//    int a = [notic.object intValue];
//    NSLog(@"%d",a);
//    self.chooseIndex = [self validPageValue:self.chooseIndex+1];
//    [self loadView];
//}
//-(void)pushUp:(NSNotification *) notic{
//    
//    int a = [notic.object intValue];
//    NSLog(@"%d",a);
//    self.chooseIndex = [self validPageValue:self.chooseIndex-1];
//    [self loadView];
//}

-(void) loadView {
    //从scrollView上移除所有的subview
    NSArray *subViews = [self subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpages:self.chooseIndex];
    
    for (int i = 0; i < 3; i++) {
        UIView *v = [_curViews objectAtIndex:i];
        v.userInteractionEnabled = YES;
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        
        [self addSubview:v];
    }
    
    [self setContentOffset:CGPointMake(GBMainViewWidth, 0)];
    
}

- (int)validPageValue:(NSInteger)value {
    
    if(value == -1) value = self.moreArrImage.count - 1;
    if(value == self.moreArrImage.count) value = 0;
    
    return (int)value;
    
}

-(void) getDisplayImagesWithCurpages:(NSInteger)pageIndex {
    int pre = (int)[self validPageValue:self.chooseIndex-1];
    int last = (int)[self validPageValue:self.chooseIndex+1];
    
    if (!_curViews) {
        _curViews = [NSMutableArray new];
    }
    
    [_curViews removeAllObjects];
    
    [_curViews addObject:[self pageAtIndex:pre]];
    [_curViews addObject:[self pageAtIndex:(int)pageIndex]];
    [_curViews addObject:[self pageAtIndex:last]];
}

-(UIView *)pageAtIndex:(int)pageIndex {

//    showOneImagePictureController * showOne = [[showOneImagePictureController alloc]initWithFrame:CGRectMake(0, 0, GBMainViewWidth, GBMainViewHeight) addImage:[self.moreArrImage objectAtIndex:pageIndex]];
//    //showOne.tag = pageIndex;
//    showOne.numberOfImage = self.moreArrImage.count;
//    return showOne;
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.moreArrImage objectAtIndex:pageIndex]]];
    imageView.frame = CGRectMake(0, 0, GBMainViewWidth, GBMainViewHeight);
    return imageView;
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {//滑动开始的坐标
    startContentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{    //将要停止前的坐标
    
    willEndContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    endContentOffsetX = scrollView.contentOffset.x;
    
    if (endContentOffsetX < willEndContentOffsetX && willEndContentOffsetX < startContentOffsetX) { //画面从右往左移动，前一页
        
        self.chooseIndex = [self validPageValue:self.chooseIndex-1];
        [self loadView];
    }
    
    if (endContentOffsetX > willEndContentOffsetX && willEndContentOffsetX > startContentOffsetX) {//画面从左往右移动，后一页
        self.chooseIndex = [self validPageValue:self.chooseIndex+1];
        [self loadView];
    }


}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [self setContentOffset:CGPointMake(GBMainViewWidth, 0) animated:NO];
//}






@end
