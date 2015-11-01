//
//  ViewController.m
//  bigImageShow
//
//  Created by 高彬 on 15/10/29.
//  Copyright © 2015年 高彬. All rights reserved.
//

#import "ViewController.h"

#import "showPictureViewController.h"

@interface ViewController ()

@end

@implementation ViewController


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"图片显示";
    
    UIButton * buttonOne =[[ UIButton alloc]initWithFrame:CGRectMake(50, 100, 200, 30)];
    [buttonOne setTitle:@"显示单张图片" forState:UIControlStateNormal];
    [buttonOne setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buttonOne addTarget:self action:@selector(clickOneButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonOne];
    
    
    UIButton * buttonTwo =[[ UIButton alloc]initWithFrame:CGRectMake(50, 200, 200, 30)];
    [buttonTwo setTitle:@"显示多张图片" forState:UIControlStateNormal];
    [buttonTwo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonTwo addTarget:self action:@selector(clickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonTwo];
    
}

-(void)clickOneButton:(UIButton *) sender {
    showPictureViewController * showPict = [showPictureViewController new];
    showPict.fromWhere = @"单个";
    [self.navigationController pushViewController:showPict animated:NO];
}

-(void)clickMoreButton:(UIButton *) sender {
    showPictureViewController * showPict = [showPictureViewController new];
    showPict.fromWhere = @"多个";
    [self.navigationController pushViewController:showPict animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
