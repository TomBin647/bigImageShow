//
//  showBigimageMore.h
//  bigImageShow
//
//  Created by 高彬 on 15/10/30.
//  Copyright © 2015年 高彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GBCycleScrollViewDelegate;
@protocol GBCycleScrollViewDatasource;

@interface showBigimageMore : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    
    NSInteger _totalPages;
    NSInteger _curPage;
    
    NSMutableArray *_curViews;
}

@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign,setter = setDataource:) id<GBCycleScrollViewDatasource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<GBCycleScrollViewDelegate> delegate;

- (void)reloadData;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;

@end

@protocol GBCycleScrollViewDelegate <NSObject>

- (void)didClickPage:(showBigimageMore *)csView atIndex:(NSInteger)index;

@optional

@end

@protocol GBCycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)pageAtIndex:(NSInteger)index;

@end

