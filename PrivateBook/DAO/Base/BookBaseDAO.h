//
//  BookBaseDAO.h
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BookBaseModel.h"

#import <FMDB.h>

@interface BookBaseDAO : NSObject

+ (long long)insertModel:(BookBaseModel *)model withDataBase:(FMDatabase *)db;

@end
