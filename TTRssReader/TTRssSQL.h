//
//  TTRssSQL.h
//  TTRssReader
//
//  Created by Admin on 20.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"


typedef void (^GetSourceArrayCallback)(NSArray*);
typedef void (^GetRssNewsArrayCallback)(NSArray*);

@interface TTRssSQL : NSObject
{
    sqlite3 * database;
}

-(void)getSourceItemsArrayWithCallback:(GetSourceArrayCallback)callback;

-(BOOL)appendSourceItemWithName:(NSString*)name andURL:(NSString*)url;

-(BOOL)saveRssNewsWithName:(NSString*)sourceName fromArray:(NSArray<NSDictionary*>*)array;

-(void)loadRssNewsWithSource:(NSString*)sourceName withCallback:(GetRssNewsArrayCallback)callback;

-(BOOL)createSourceTable;

-(BOOL)createNewsTable;

-(BOOL)deleteSourceTable;

@end
