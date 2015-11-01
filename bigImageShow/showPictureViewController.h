//
//  showPictureViewController.h
//  bigImageShow
//
//  Created by 高彬 on 15/10/29.
//  Copyright © 2015年 高彬. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "showBigimageMore.h"

@interface showPictureViewController : UIViewController<GBCycleScrollViewDatasource,GBCycleScrollViewDelegate>


@property (nonatomic,strong) NSString * fromWhere;

@property (nonatomic,strong) NSMutableArray * imageArr;

@property (nonatomic,assign) NSInteger imageIndex;

@end
