//
//  UIRssNewsDetailViewController.h
//  TTRssReader
//
//  Created by Admin on 25.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIRssNewsDetailViewController : UIViewController

// Свойство для хранения заголовка новости
@property (copy, nonatomic) NSString *headerRssNews;
// Своиство для хранения текста новости
@property (copy, nonatomic) NSString *detailTextRssNews;

// Лэйбл для отображения заголовка новости
@property (strong, nonatomic) IBOutlet UILabel * headerLabel;
// Лэйбл для отображения текста новости
@property (strong, nonatomic) IBOutlet UITextView * detaiTextArea;

@end
