//
//  BookBaseModel.h
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookBaseModel : NSObject <NSCopying>

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (id)copyWithZone:(NSZone *)zone;
- (NSArray *)modelArrayFromDictArray:(NSArray *)dictArray withModelClass:(Class)modelClass;

@end
