//
//  showImageBig.h
//  bigImageShow
//
//  Created by 高彬 on 15/10/30.
//  Copyright © 2015年 高彬. All rights reserved.
//

#import <UIKit/UIKit.h>
@class showPictureViewController;

@interface showImageBig : UIScrollView {
}


-(instancetype) initWithFrame:(CGRect)frame addImageArrUrl:(NSMutableArray *)imageArr addImageIndex:(NSInteger)imageIndex;




@property (nonatomic,strong) showPictureViewController * showMorePicture;

@end
