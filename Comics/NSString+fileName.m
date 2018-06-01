//
//  NSString+fileName.m
//  Comics
//
//  Created by Jason on 2018/6/1.
//  Copyright © 2018年 Jason. All rights reserved.
//

#import "NSString+fileName.h"

@implementation NSString (fileName)

- (NSString *)fileName{
    NSURL *url = [NSURL fileURLWithPath:self];
    
    return [[url lastPathComponent] stringByDeletingPathExtension];
}

@end
