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
    NSMutableArray<TTRssNewsModel*> * collectionRssNews;
}

@property (nonatomic, strong) NSString * sourceName;
@property (nonatomic, strong) NSURL * sourceURL;


@end
