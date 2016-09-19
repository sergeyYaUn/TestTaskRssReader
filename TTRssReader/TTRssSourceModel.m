//
//  TTRssSourceModel.m
//  TTRssReader
//
//  Created by Admin on 20.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import "TTRssSourceModel.h"

@implementation TTRssSourceModel

-(instancetype)init{
    if ((self = [super init])){
        _name = nil;
        _url = nil;
    }
    return self;
}

-(instancetype)initWithName:(NSString *)name andURL:(NSString *)url
{
    if ((self = [super init]))
    {
        _name = [name copy];
        _url = [[NSURL URLWithString:url] copy];
    }
    return self;
}

@end

