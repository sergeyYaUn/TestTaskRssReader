//
//  TTRssSQL.m
//  TTRssReader
//
//  Created by Admin on 20.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import "TTRssSQL.h"

static NSString * const databaseName = @"rssDb.sql3";



@implementation TTRssSQL

-(instancetype)init{
    if ((self = [super init]))
        database = nil;
    return self;
}

-(BOOL)openDatabaseWithName:(NSString*)name{

    NSString * databasePath = [NSTemporaryDirectory() stringByAppendingPathComponent:name];

    int result = sqlite3_open([databasePath UTF8String], &database);
    if (result == SQLITE_OK)
        return YES;
    return NO;
    
}

-(void)closeDatabase{
    if (database)
        sqlite3_close(database);
}

-(BOOL)createSourceTable{
    if ([self openDatabaseWithName:databaseName])
    {
        const char * createTableQuery = [@"CREATE TABLE IF NOT EXISTS sourcetable (id INTEGER PRIMARY KEY, name varchar(35), url TEXT)" UTF8String];
        char * errInfo;
        int result = sqlite3_exec(database, createTableQuery, nil, nil, &errInfo);
        
        [self closeDatabase];
        
        if (result == SQLITE_OK)
        {
            return YES;
        }else
        {
            NSLog(@"Error create table : %@", [NSString stringWithUTF8String:errInfo]);
            return NO;
        }
    }
    return NO;
}

-(BOOL)createNewsTable{
    if ([self openDatabaseWithName:databaseName])
    {
        const char * createTableQuery = [@"CREATE TABLE IF NOT EXISTS newstable (id INTEGER PRIMARY KEY, source varchar(35), title TEXT, detail TEXT)" UTF8String];
        char * errInfo;
        int result = sqlite3_exec(database, createTableQuery, nil, nil, &errInfo);
        
        [self closeDatabase];
        
        if (result == SQLITE_OK)
        {
            return YES;
        }else
        {
            NSLog(@"Error create table : %@", [NSString stringWithUTF8String:errInfo]);
            return NO;
        }
    }
    return NO;
}


-(void)getSourceItemsArrayWithCallback:(GetSourceArrayCallback)callback
{
    NSMutableArray * sourceItems = [[NSMutableArray alloc] init];
    NSDictionary * item;
    
    if ([self openDatabaseWithName:databaseName])
    {
        sqlite3_stmt * sqlStatement;
        const char * selectQuery = [@"SELECT id, name, url FROM sourcetable ORDER BY id" UTF8String];
        int result  = sqlite3_prepare_v2(database, selectQuery, -1, &sqlStatement, nil);
        if (result == SQLITE_OK)
        {
            while(sqlite3_step(sqlStatement) == SQLITE_ROW)
            {
                item = @{ @"name" : [NSString stringWithUTF8String:(const char*)sqlite3_column_text(sqlStatement, 1)],
                                         @"url" : [NSString stringWithUTF8String:(const char*)sqlite3_column_text(sqlStatement, 2)]};
               
                [sourceItems addObject:item];
            }
            sqlite3_finalize(sqlStatement);
            [self closeDatabase];
            callback(sourceItems);
        }
    
    }
}


-(BOOL)appendSourceItemWithName:(NSString *)name andURL:(NSString *)url
{
    if ([self openDatabaseWithName:databaseName]){
        const char * insertSourceQuery = [[NSString stringWithFormat:@"INSERT INTO sourcetable (name, url) VALUES ('%@', '%@')", name, url] UTF8String];
        char * errInfo;
        int result = sqlite3_exec(database, insertSourceQuery, nil, nil, &errInfo);
        
        [self closeDatabase];
        
        if (result == SQLITE_OK)
        {
            return YES;
        }else
        {
            NSLog(@"Error append row in source table: %@", [NSString stringWithUTF8String:errInfo]);
            return NO;
        }
        
    } 
    return NO;
}


-(BOOL)saveRssNewsWithName:(NSString*)sourceName fromArray:(NSArray<NSDictionary*>*)array{
    if([self openDatabaseWithName:databaseName])
    {
        //Delete old rows of RSS news
        const char * deleteQuery = [[NSString stringWithFormat:@"DELETE FROM newstable WHERE source = '%@'", sourceName] UTF8String];
        sqlite3_exec(database, deleteQuery, nil, nil, nil);
        
        
        BOOL complete = YES;
        int result[[array count]];
        char * errInfo[[array count]];
        int counter = 1;
        
        for (NSDictionary * item in array)
        {
            const char * insertNewsQuery = [[NSString stringWithFormat:@"INSERT INTO newstable (source, title, detail) VALUES ('%@', '%@', '%@')", item[@"source"], item[@"title"], item[@"detail"]] UTF8String];
            
            result[counter] = sqlite3_exec(database, insertNewsQuery, nil, nil, &errInfo[counter]);
            counter++;
    
        }
        for (int i = 1; i < [array count]; i++)
        if (result[i] != SQLITE_OK)
        {
            NSLog(@"Erron save news: %@", [NSString stringWithUTF8String:errInfo[i]]);
            complete = NO;
        }
        return complete;
    }
    return NO;
}

-(void)loadRssNewsWithSource:(NSString*)sourceName withCallback:(GetSourceArrayCallback)callback{
    if([self openDatabaseWithName:databaseName])
    {
        
        NSMutableArray * list = [[NSMutableArray alloc] init];
        NSDictionary * item;
        
        const char * selectQuery = [[NSString stringWithFormat:@"SELECT source, title, detail FROM newstable WHERE source = '%@'", sourceName] UTF8String];
        sqlite3_stmt * sqlStatement;
        
        int result  = sqlite3_prepare_v2(database, selectQuery, -1, &sqlStatement, nil);
        if (result == SQLITE_OK)
        {
            while(sqlite3_step(sqlStatement) == SQLITE_ROW)
            {
                item = @{ @"source" : [NSString stringWithUTF8String:(const char*)sqlite3_column_text(sqlStatement, 0)],
                          @"title" : [NSString stringWithUTF8String:(const char*)sqlite3_column_text(sqlStatement, 1)],
                          @"detail" : [NSString stringWithUTF8String:(const char*)sqlite3_column_text(sqlStatement, 2)]};
                
                [list addObject:item];
            }
            sqlite3_finalize(sqlStatement);
            [self closeDatabase];
            callback(list);
        }
        
        
    }
}






-(BOOL)deleteSourceTable
{
    if ([self openDatabaseWithName:databaseName])
    {
        const char * dropTableQuery = [@"DROP TABLE IF EXISTS sourcetable" UTF8String];
        char * errInfo;
        int result = sqlite3_exec(database, dropTableQuery, nil, nil, &errInfo);
        if (result == SQLITE_OK)
            return YES;
    }
    return NO;
}


@end
