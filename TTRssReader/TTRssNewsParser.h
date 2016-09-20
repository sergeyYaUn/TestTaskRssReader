//
//  TTRssNewsModel.h
//  TTRssReader
//
//  Created by Admin on 20.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  void (^GetNewsRssCallback)(NSArray * rssNewsArray, BOOL error);


@interface TTRssNewsParser : NSObject <NSXMLParserDelegate>
{
    NSXMLParser * parser;
}

-(void)getNewsRssDictionaryWithSourceURL:(NSURL*)sourceURL andCallback:(GetNewsRssCallback)callback;

@end
