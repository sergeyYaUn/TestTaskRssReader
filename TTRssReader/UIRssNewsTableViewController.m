//
//  UIRssNewsTableViewController.m
//  TTRssReader
//
//  Created by Admin on 20.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import "UIRssNewsTableViewController.h"
#import "UIRssNewsDetailViewController.h"
#import "TTRssNewsParser.h"
#import "TTRssNewsModel.h"
#import "TTRssSQL.h"


@interface UIRssNewsTableViewController ()

@end

@implementation UIRssNewsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Создаем объект для обращения к базе данных
    TTRssSQL * sqlControl = [[TTRssSQL alloc] init];
    
    // Загружаем имеющиеся новости из базы данных
    // в callback заполняем массив данных для представления новостей
    [sqlControl loadRssNewsWithSource:_sourceName withCallback:^(NSArray * list) {
        collectionRssNews = [[NSMutableArray alloc] init];
        
        for (NSDictionary * item in list){
            TTRssNewsModel * itemNews = [[TTRssNewsModel alloc] initWithSource:item[@"source"] andTitle:item[@"title"] andDetail:item[@"detail"]];
            [collectionRssNews addObject:itemNews];
            [self.tableView reloadData];
        }
    }];
    
    // Создаем объект для получения данных из RSS ресурса
    TTRssNewsParser * parser = [[TTRssNewsParser alloc] init];
    
    
    // Загружаем новости из интернет-ресурса по ссылке _sourceURL,
    // по завершении загрузки и парсинга вызываем блок обработки
    [parser getNewsRssDictionaryWithSourceURL:_sourceURL andCallback:^(NSArray *rssNewsArray, BOOL error) {
        // Если ошибок при получении данных не было,
        // заполняем массив данных для представления из словаря полученного после парсинга XML
        if (!error){
            collectionRssNews = [[NSMutableArray alloc] init];
    
            for (NSDictionary * item in rssNewsArray){
                TTRssNewsModel * itemNews = [[TTRssNewsModel alloc] initWithSource:_sourceName andTitle:item[@"title"] andDetail:item[@"detail"]];
                [collectionRssNews addObject:itemNews];
            }
            
            // Обновляем содержимое tableView
            [self.tableView reloadData];
            
            // Создаем таблицу для хранения полученных данных
            [sqlControl createNewsTable];
            // Сохраняем данные в базе
            [sqlControl saveRssNewsWithName:_sourceName fromArray:rssNewsArray];
            
        }
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
    return [collectionRssNews count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDRssNewsCell" forIndexPath:indexPath];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"IDRssNewsCell" ];
    }
    // Configure the cell...
    cell.textLabel.text = collectionRssNews[indexPath.row].title;

    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"IDDetailRssNewsSegue" sender:collectionRssNews[indexPath.row]];
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
    if ([segue.identifier isEqualToString:@"IDDetailRssNewsSegue"]){
        UIRssNewsDetailViewController * destination = [segue destinationViewController];
        TTRssNewsModel * newsItem = (TTRssNewsModel*)sender;
        
        // Устанавливаем в контроллере назначения заголовок и текст новости
        destination.headerRssNews = newsItem.title;
        destination.detailTextRssNews = newsItem.detail;
    }
    
}


@end
