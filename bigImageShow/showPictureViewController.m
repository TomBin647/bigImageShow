//
//  showPictureViewController.m
//  bigImageShow
//
//  Created by 高彬 on 15/10/29.
//  Copyright © 2015年 高彬. All rights reserved.
//

#import "showPictureViewController.h"
#import "showOneImagePictureController.h"

//#import "showMorePictureController.h"

//#import "showImageBig.h"

@interface showPictureViewController ()

@end

@implementation showPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * arr = [NSArray arrayWithObjects:@"1.png",@"2.png",@"3.png",@"4.png",@"5.png", nil];
    self.imageArr = [NSMutableArray arrayWithArray:arr];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBarHidden = YES;
    if ([self.fromWhere isEqualToString:@"单个"]) {
        // 跳转到单个界面
        showOneImagePictureController * showOne = [[showOneImagePictureController alloc]initWithFrame:self.view.bounds addImage:@"1.png"];
        showOne.pictOneImage = self;
        [self.view addSubview:showOne];
    } else {
        //跳转到多个界面
//        showMorePictureController * showMore = [[showMorePictureController alloc]initWithFrame:self.view.bounds addImageArrUrl:self.imageArr addImageIndex:2];
//        showMore.showMorePicture = self;
//        
//        [self.view addSubview:showMore];
//        showImageBig * showMore = [[showImageBig alloc]initWithFrame:self.view.bounds addImageArrUrl:self.imageArr addImageIndex:2];
//        showMore.showMorePicture = self;
//        [self.view addSubview:showMore];
        
        
        showBigimageMore *csView = [[showBigimageMore alloc] initWithFrame:self.view.bounds];
        csView.delegate = self;
        csView.datasource = self;
        [self.view addSubview:csView];
        
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfPages
{
    return 5;
}
- (UIView *)pageAtIndex:(NSInteger)index
{
    
    showOneImagePictureController * showOne = [[showOneImagePictureController alloc]initWithFrame:self.view.bounds addImage:[self.imageArr objectAtIndex:index]];
    showOne.numberOfImage = self.imageArr.count;
    return showOne;

}

- (void)didClickPage:(showBigimageMore *)csView atIndex:(NSInteger)index
{
    
    [self.navigationController popViewControllerAnimated:NO];
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                    message:[NSString stringWithFormat:@"当前点击第%ld个页面",(long)index]
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
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
