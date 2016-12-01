//
//  WakeUpViewController.m
//  YourStop
//
//  Created by chutima mungmee on 11/30/16.
//  Copyright © 2016 Chad Wiedemann LLC. All rights reserved.
//

#import "WakeUpViewController.h"

@interface WakeUpViewController ()

@end

@implementation WakeUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(homeVC)];
    
    self.navigationItem.leftBarButtonItem = saveButton;
}

-(void)homeVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
