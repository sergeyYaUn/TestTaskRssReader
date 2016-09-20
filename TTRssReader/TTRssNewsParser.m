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

-(instancetype)init{
    if ((self = [super init]))
    {
        
    
    }
    return self;
}

-(void)getNewsRssDictionaryWithSourceURL:(NSURL*)sourceURL andCallback:(GetNewsRssCallback)callback
{
    BOOL error = YES;
    parser = [[NSXMLParser alloc] initWithContentsOfURL:sourceURL];
    if (!parser){
        callback(nil, error);
        return;
    }
    
    [parser setDelegate:self];
    if ([parser parse])
        callback(collectionNews, NO);
    
}



-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"rss"])
        collectionNews = [[NSMutableArray alloc] init];
    if ([elementName isEqualToString:@"item"])
        item = [[NSMutableDictionary alloc] init];
    

}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!stringForParse){
        stringForParse = [[NSMutableString alloc] initWithString:string];
    }else
    {
        [stringForParse appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"title"])
        [item setValue:[stringForParse stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"title"];
    
    if ([elementName isEqualToString:@"description"])
        [item setValue:[stringForParse stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"detail"];
    
    if ([elementName isEqualToString:@"item"])
        [collectionNews addObject:item];
    
    stringForParse = nil;
}

@end
