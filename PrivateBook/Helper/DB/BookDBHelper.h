//
//  BookDBHelper.h
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookDBHelper : NSObject

+ (NSString *)dbFolder;

+ (NSString *)dbPath;

+ (void)buildDataBase;

@end
