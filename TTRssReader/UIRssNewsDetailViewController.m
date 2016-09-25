//
//  UIRssNewsDetailViewController.m
//  TTRssReader
//
//  Created by Admin on 25.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import "UIRssNewsDetailViewController.h"

@interface UIRssNewsDetailViewController ()

@end

@implementation UIRssNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Устанавливаем тексты в лэйбл заголовка и текстовое представление
    [self.headerLabel setText:_headerRssNews];
    [self.detaiTextArea setText:_detailTextRssNews];
    
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
