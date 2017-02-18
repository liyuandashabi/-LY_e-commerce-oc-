//
//  productsDetailViewController.m
//  Test
//
//  Created by ly on 2017/2/17.
//  Copyright © 2017年 com.Joyetech.test. All rights reserved.
//

#import "productsDetailViewController.h"
#import "MainViewController.h"


@interface productsDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *returnMainVCBtn;



@end

@implementation productsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self returnMainVCBtnSetting];
    
    switch (self.index) {
        case 0:
            self.view.backgroundColor=[UIColor redColor];
            NSLog(@"%ld",(long)self.index);
            break;
            
        case 1:
            self.view.backgroundColor=[UIColor blueColor];
             NSLog(@"%ld",(long)self.index);
            break;
            
        case 2:
            self.view.backgroundColor=[UIColor yellowColor];
              NSLog(@"%ld",(long)self.index);
            break;
            
        case 3:
            self.view.backgroundColor=[UIColor greenColor];
             NSLog(@"%ld",(long)self.index);
            break;
            
        case 4:
            self.view.backgroundColor=[UIColor grayColor];
             NSLog(@"%ld",(long)self.index);
            break;
    }
}

-(void)returnMainVCBtnSetting {
    [self.returnMainVCBtn addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)skip:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
