//
//  cyclePlayDetailViewController.m
//  Test
//
//  Created by ly on 2017/2/13.
//  Copyright © 2017年 com.Joyetech.test. All rights reserved.
//

#import "cyclePlayDetailViewController.h"
#import "MainViewController.h"

@interface cyclePlayDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *returnBtn;

@end

@implementation cyclePlayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self returnBtnSetting];
    
}

-(void)returnBtnSetting {
    [self.returnBtn addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)skip:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
