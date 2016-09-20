//
//  UIRssNewsTableViewController.m
//  TTRssReader
//
//  Created by Admin on 20.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import "UIRssNewsTableViewController.h"
#import "TTRssNewsParser.h"
#import "TTRssNewsModel.h"
#import "TTRssSQL.h"


@interface UIRssNewsTableViewController ()

@end

@implementation UIRssNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __block BOOL errorConnection = NO;
    
    TTRssSQL * sqlControl = [[TTRssSQL alloc] init];
    
    TTRssNewsParser * parser = [[TTRssNewsParser alloc] init];
    [parser getNewsRssDictionaryWithSourceURL:_sourceURL andCallback:^(NSArray *rssNewsArray, BOOL error) {
        
        if (!error){
            collectionRssNews = [[NSMutableArray alloc] init];
    
            for (NSDictionary * item in rssNewsArray){
                TTRssNewsModel * itemNews = [[TTRssNewsModel alloc] initWithSource:item[@"source"] andTitle:item[@"title"] andDetail:item[@"detail"]];
                [collectionRssNews addObject:itemNews];
            }
            
            [sqlControl saveRssNewsWithName:_sourceName fromArray:rssNewsArray];
            
        }else{
            errorConnection = error;
        }
    }];
    
    if (errorConnection)
    {
        [sqlControl loadRssNewsWithSource:_sourceName withCallback:^(NSArray * list) {
            collectionRssNews = [[NSMutableArray alloc] init];
            for (NSDictionary * item in list){
                TTRssNewsModel * itemNews = [[TTRssNewsModel alloc] initWithSource:item[@"source"] andTitle:item[@"title"] andDetail:item[@"detail"]];
                [collectionRssNews addObject:itemNews];
            }
        }];
        
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return [collectionRssNews count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDRssNewsCell" forIndexPath:indexPath];
    
    if(!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"IDRssNewsCell" ];
    // Configure the cell...
    
    cell.textLabel.text = collectionRssNews[indexPath.row].title;
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
