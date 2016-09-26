//
//  UIRootTableViewController.h
//  TTRssReader
//
//  Created by Admin on 19.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTRssSQL.h"
#import "TTRssSourceModel.h"



@interface UIRootTableViewController : UITableViewController
{
    NSMutableArray<TTRssSourceModel*> * sourceItemRSS;
}

- (IBAction)addSourceRss;

@end
