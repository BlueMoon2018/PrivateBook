//
//  BookBaseDAO.m
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookBaseDAO.h"



@implementation BookBaseDAO

+ (long long)insertModel:(BookBaseModel *)model withDataBase:(FMDatabase *)db
{
    NSString *msg = [NSString stringWithFormat:@"%s is not implemented for the class %@", sel_getName(_cmd), self];
    @throw [NSException exceptionWithName:@"BookBaseDAOMethodException" reason:msg userInfo:nil];
}

@end
