//
//  showBigimageMore.h
//  bigImageShow
//
//  Created by 高彬 on 15/10/30.
//  Copyright © 2015年 高彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XLCycleScrollViewDelegate;
@protocol XLCycleScrollViewDatasource;

@interface showBigimageMore : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    
    //id<XLCycleScrollViewDelegate> delegate;
    //id<XLCycleScrollViewDatasource> datasource;
    
    NSInteger _totalPages;
    NSInteger _curPage;
    
    NSMutableArray *_curViews;
}

@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign,setter = setDataource:) id<XLCycleScrollViewDatasource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<XLCycleScrollViewDelegate> delegate;

- (void)reloadData;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;

@end

@protocol XLCycleScrollViewDelegate <NSObject>

@optional

@end

@protocol XLCycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)pageAtIndex:(NSInteger)index;

@end

