//
//  TTRssSourceModel.h
//  TTRssReader
//
//  Created by Admin on 20.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTRssSourceModel : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSURL * url;

-(instancetype)initWithName:(NSString*)name andURL:(NSString*)url;

@end
