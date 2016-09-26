//
//  UIAddSourceViewController.m
//  TTRssReader
//
//  Created by Admin on 26.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import "UIAddSourceViewController.h"
#import "TTRssSQL.h"

@interface UIAddSourceViewController () <UITextFieldDelegate>

@end

@implementation UIAddSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addSourceAction
{
    self.callback([self.nameSourceTextField text],[self.urlSourceTextField text]);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelOperationAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.nameSourceTextField resignFirstResponder];
    [self.urlSourceTextField resignFirstResponder];
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
