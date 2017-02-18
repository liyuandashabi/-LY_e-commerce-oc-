//
//  cyclePlayDetailViewController.m
//  Test
//
//  Created by ly on 2017/2/13.
//  Copyright © 2017年 com.Joyetech.test. All rights reserved.
//

#import "cyclePlayDetailViewController.h"
#import "MainViewController.h"
#import "XRCarouselView.h"

@interface cyclePlayDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *returnBtn;

@property (weak, nonatomic) IBOutlet UILabel *cyclePlayLabel;



@end

@implementation cyclePlayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self returnBtnSetting];
    
    switch (self.picNumber) {
        case 0:
            [self one];
            break;
        case 1:
            NSLog(@"第二个视图显示的：%ld",(long)self.picNumber);
            self.cyclePlayLabel.text=@"第二个界面";
            break;
        case 2:
            NSLog(@"第二个视图显示的：%ld",(long)self.picNumber);
            self.cyclePlayLabel.text=@"第三个界面";
            break;
        case 3:
            NSLog(@"第二个视图显示的：%ld",(long)self.picNumber);
            self.cyclePlayLabel.text=@"第四个界面";
            break;
        case 4:
            NSLog(@"第二个视图显示的：%ld",(long)self.picNumber);
            self.cyclePlayLabel.text=@"第五个界面";
            break;
        case 5:
            NSLog(@"第二个视图显示的：%ld",(long)self.picNumber);
            self.cyclePlayLabel.text=@"第六个界面";
            break;
        }
}

-(void)returnBtnSetting {
    [self.returnBtn addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)skip:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)one{
    NSLog(@"第二个视图显示的：%ld",(long)self.picNumber);
    self.cyclePlayLabel.text=@"第一个界面";
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
