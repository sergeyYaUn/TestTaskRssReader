//
//  TTRssNewsModel.h
//  TTRssReader
//
//  Created by Admin on 20.09.16.
//  Copyright © 2016 doungram. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTRssNewsModel : NSObject

@property (nonatomic, copy) NSString * source;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * detail;

-(instancetype)initWithSource:(NSString*)source andTitle:(NSString*)title andDetail:(NSString*)detail;

@end
