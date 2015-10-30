//
//  showOneImagePictureController.m
//  bigImageShow
//
//  Created by 高彬 on 15/10/29.
//  Copyright © 2015年 高彬. All rights reserved.
//

#import "showOneImagePictureController.h"
#import "showPictureViewController.h"

#define GBMainViewWidth self.frame.size.width

#define GBMainViewHeight self.frame.size.height

@interface UIImage (GBImage)

- (CGSize)sizeThatFits:(CGSize)size;

@end

@implementation UIImage (GBImage)

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize imageSize = CGSizeMake(self.size.width / self.scale,
                                  self.size.height / self.scale);
    
    CGFloat widthRatio = imageSize.width / size.width;
    CGFloat heightRatio = imageSize.height / size.height;
    
    if (widthRatio > heightRatio) {
        imageSize = CGSizeMake(imageSize.width / widthRatio, imageSize.height / widthRatio);
    } else {
        imageSize = CGSizeMake(imageSize.width / heightRatio, imageSize.height / heightRatio);
    }
    
    return imageSize;
}


@end


@interface UIImageView (GBImage)

-(CGSize)contentSize;

@end
@implementation UIImageView (GBImage)

-(CGSize)contentSize {
    return [self.image sizeThatFits:self.bounds.size];
}

@end


@interface showOneImagePictureController () <UIScrollViewDelegate>
{
CGFloat startContentOffsetX;

CGFloat willEndContentOffsetX;

CGFloat endContentOffsetX;
}


@property (nonatomic,strong) UIView * containerView;

@property (nonatomic,strong) UIImageView * imageView;

@property (nonatomic) CGSize minSize;


@property (nonatomic) CGRect Oldframe;

@property (nonatomic,strong) UIImage * imageOld;

@end

@implementation showOneImagePictureController

-(instancetype) initWithFrame:(CGRect)frame addImage:(NSString *) image {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate  = self;
        self.bouncesZoom = YES;
        self.bounces = YES;
        self.pagingEnabled = NO;
        self.directionalLockEnabled = YES;
        
        _imageOld =  [UIImage imageNamed:image];
        //在scroller 加入uiview
        UIView * containerView = [[UIView alloc]initWithFrame:self.bounds];
        containerView.backgroundColor = [UIColor clearColor];
        [self addSubview:containerView];
        _containerView = containerView;
        
        //在uiview上加入imageview
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:containerView.bounds];
        imageView.image = [UIImage imageNamed:image];
        imageView.contentMode =UIViewContentModeScaleAspectFit;
        [containerView addSubview:imageView];
        _imageView = imageView;
        
        //计算出image的大小
        CGSize imageSize = imageView.contentSize;
        
        self.containerView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        imageView.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
        imageView.center = CGPointMake(imageSize.width/2, imageSize.height/2);
        
        
        //设置初始scroller的滑动距离
        
        self.contentSize = imageSize;
        
        self.Oldframe = self.containerView.frame;
        
        self.minSize = imageSize;
        //设置scrollerView 的放大系数
        
        [self setMaximumZoomScale];
        [self centerContent];
        
        
    }
    
    return self;
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {//滑动开始的坐标
    startContentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{    //将要停止前的坐标
    
    willEndContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    endContentOffsetX = scrollView.contentOffset.x;
    
//    if (endContentOffsetX < willEndContentOffsetX && willEndContentOffsetX < startContentOffsetX) { //画面从右往左移动，前一页
//        
//        self.chooseIndex = [self validPageValue:self.chooseIndex-1];
//        [self loadView];
//    }
//    
//    if (endContentOffsetX > willEndContentOffsetX && willEndContentOffsetX > startContentOffsetX) {//画面从左往右移动，后一页
//        self.chooseIndex = [self validPageValue:self.chooseIndex+1];
//        [self loadView];
//    }
    
    
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"%f",scrollView.contentOffset.x);
   //[self resignFirstResponder];
    if (self.contentOffset.x+ GBMainViewWidth> self.contentSize.width + 20) {
        NSLog(@"下一页");
        
        if (self.tag == self.numberOfImage-1) {
            return;
        }
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushNext" object:[NSNumber numberWithInteger:self.tag]];
        
        [self resignFirstResponder];
        [self.containerView removeFromSuperview];
        //在scroller 加入uiview
        UIView * containerView = [[UIView alloc]initWithFrame:self.bounds];
        containerView.backgroundColor = [UIColor clearColor];
        [self addSubview:containerView];
        _containerView = containerView;
        
        //在uiview上加入imageview
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:containerView.bounds];
        imageView.image = _imageOld;
        imageView.contentMode =UIViewContentModeScaleAspectFit;
        [containerView addSubview:imageView];
        _imageView = imageView;
        
        //计算出image的大小
        CGSize imageSize = imageView.contentSize;
        
        self.containerView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        imageView.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
        imageView.center = CGPointMake(imageSize.width/2, imageSize.height/2);
        
        
        //设置初始scroller的滑动距离
        
        self.contentSize = imageSize;
        
        self.Oldframe = self.containerView.frame;
        
        self.minSize = imageSize;
        //设置scrollerView 的放大系数
        [self setMaximumZoomScale];
        [self centerContent];
        
        
        
        
        
    }
    
    
    
    if (self.contentOffset.x < -100) {
        NSLog(@"上一页");
        
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PushUp" object:[NSNumber numberWithInteger:self.tag]];
        [self resignFirstResponder];
        [self.containerView removeFromSuperview];
        //在scroller 加入uiview
        UIView * containerView = [[UIView alloc]initWithFrame:self.bounds];
        containerView.backgroundColor = [UIColor clearColor];
        [self addSubview:containerView];
        _containerView = containerView;
        
        //在uiview上加入imageview
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:containerView.bounds];
        imageView.image = _imageOld;
        imageView.contentMode =UIViewContentModeScaleAspectFit;
        [containerView addSubview:imageView];
        _imageView = imageView;
        
        //计算出image的大小
        CGSize imageSize = imageView.contentSize;
        
        self.containerView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        imageView.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
        imageView.center = CGPointMake(imageSize.width/2, imageSize.height/2);
        
        
        //设置初始scroller的滑动距离
        
        self.contentSize = imageSize;
        
        self.Oldframe = self.containerView.frame;
        
        self.minSize = imageSize;
        //设置scrollerView 的放大系数
        [self setMaximumZoomScale];
        [self centerContent];
        
    }
    
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerContent];
}
-(void)centerContent {
    CGRect frame = self.containerView.frame;
    
    CGFloat top = 0, left = 0;
    if (self.contentSize.width < self.bounds.size.width) {
        //算出离左边的距离
        left = (self.bounds.size.width - self.contentSize.width) * 0.5;
    }
    if (self.contentSize.height < self.bounds.size.height) {
        top = (self.bounds.size.height - self.contentSize.height) * 0.5;
    }
    
    top -= frame.origin.y;
    left -= frame.origin.x;
    
    self.contentInset = UIEdgeInsetsMake(top, left, top, left);
}

-(void)setMaximumZoomScale {
//    CGSize imageSize = self.imageView.image.size;
//    CGSize imagePresentationSize = self.imageView.contentSize;
//    CGFloat maxScale = MAX(imageSize.height / imagePresentationSize.height, imageSize.width / imagePresentationSize.width);
    self.maximumZoomScale = MAX(1, 3); // Should not less than 1
    self.minimumZoomScale = 1.0;
}





@end
