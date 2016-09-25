//
//  UIRssNewsTableViewController.h
//  TTRssReader
//
//  Created by Admin on 20.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTRssNewsModel;

@interface UIRssNewsTableViewController : UITableViewController
{
    // Массив для хранения элементов представлющих новость
    NSMutableArray<TTRssNewsModel*> * collectionRssNews;
}

// Своиство для хранения имени ресурса новостей
@property (nonatomic, strong) NSString * sourceName;
// Cвоиство для хранения url адреса ресурса новостей
@property (nonatomic, strong) NSURL * sourceURL;


@end
