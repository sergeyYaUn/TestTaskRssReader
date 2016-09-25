//
//  TTRssNewsModel.m
//  TTRssReader
//
//  Created by Admin on 20.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//


#import "TTRssNewsParser.h"


@interface TTRssNewsParser ()
{
    NSMutableArray * collectionNews;
    NSMutableString * stringForParse;
    NSMutableDictionary * item;
}

@end

@implementation TTRssNewsParser

- (void)getNewsRssDictionaryWithSourceURL:(NSURL*)sourceURL andCallback:(GetNewsRssCallback)callback
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithURL:sourceURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (!error){
            parser = [[NSXMLParser alloc] initWithData:data];
            [parser setDelegate:self];
            if ([parser parse]){
                callback(collectionNews, NO);
            }
        } else {
            callback(nil, YES);
        }
    }];
    
    [task resume];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"rss"]){
        collectionNews = [[NSMutableArray alloc] init];
    }
    
    if ([elementName isEqualToString:@"item"]){
        item = [[NSMutableDictionary alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!stringForParse){
        stringForParse = [[NSMutableString alloc] initWithString:string];
    } else {
        [stringForParse appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"title"]){
        [item setValue:[stringForParse stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"title"];
    }
    
    if ([elementName isEqualToString:@"description"]){
        [item setValue:[stringForParse stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"detail"];
    }
    
    if ([elementName isEqualToString:@"item"]){
        [collectionNews addObject:item];
    }
    
    stringForParse = nil;
}

@end
