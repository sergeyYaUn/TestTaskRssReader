//
//  UIRootTableViewController.m
//  TTRssReader
//
//  Created by Admin on 19.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import "UIRootTableViewController.h"
#import "UIRssNewsTableViewController.h"

@interface UIRootTableViewController ()

@end

@implementation UIRootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"RSS list";
    
    TTRssSQL * sql = [[TTRssSQL alloc] init];
      
    if ([sql createSourceTable]){
        [sql appendSourceItemWithName:@"Yandex.ru" andURL:@"https://news.yandex.ru/index.rss"];
    }
    
    sourceItemRSS = [[NSMutableArray alloc] init];
    
    [sql getSourceItemsArrayWithCallback:^(NSArray * sourceSqlRss){
        for (NSDictionary * source in sourceSqlRss){
            TTRssSourceModel * sourceRSS = [[TTRssSourceModel alloc] initWithName:[source valueForKey:@"name"] andURL:[source valueForKey:@"url"]];
            
            [sourceItemRSS addObject:sourceRSS];
        }
        [self.tableView reloadData];
    }];
    
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
    return [sourceItemRSS count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDSourceRSSCell" forIndexPath:indexPath];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"IDSourceRSSCell"];
    }
    
    // Configure the cell...
    cell.textLabel.text = sourceItemRSS[indexPath.row].name;
    cell.detailTextLabel.text = [sourceItemRSS[indexPath.row].url absoluteString];
    

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"IDSegueNewsList" sender:sourceItemRSS[indexPath.row]];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"IDSegueNewsList"]){
        UIRssNewsTableViewController * destination = [segue destinationViewController];
        destination.sourceURL = ((TTRssSourceModel*)sender).url;
        destination.sourceName = ((TTRssSourceModel*)sender).name;
    }
    
}


@end
