//
//  TTRssNewsModel.m
//  TTRssReader
//
//  Created by Admin on 20.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import "TTRssNewsModel.h"

@implementation TTRssNewsModel

-(instancetype)init{
    if ((self = [super init]))
    {
        _source = nil;
        _title = nil;
        _detail = nil;
    }
    return self;
}

-(instancetype)initWithSource:(NSString*)source andTitle:(NSString*)title andDetail:(NSString*)detail{
    
    if((self = [super init])){
        _source = [source copy];
        _title = [title copy];
        _detail = [detail copy];
    }
    return self;
}

@end
