//
//  UIAddSourceViewController.h
//  TTRssReader
//
//  Created by Admin on 26.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CallBackForReloadData)(NSString * nameSource, NSString * urlSourse);


@interface UIAddSourceViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *nameSourceTextField;
@property (strong, nonatomic) IBOutlet UITextField *urlSourceTextField;

@property (strong, nonatomic) CallBackForReloadData callback;

- (IBAction)addSourceAction;
- (IBAction)cancelOperationAction;

@end
