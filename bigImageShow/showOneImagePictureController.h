//
//  showOneImagePictureController.h
//  bigImageShow
//
//  Created by 高彬 on 15/10/29.
//  Copyright © 2015年 高彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@class showPictureViewController;

@interface showOneImagePictureController : UIScrollView

-(instancetype) initWithFrame:(CGRect)frame addImage:(NSString *) image;

@property (nonatomic,strong) showPictureViewController * pictOneImage;


@property (nonatomic,assign) NSInteger numberOfImage;

@end
