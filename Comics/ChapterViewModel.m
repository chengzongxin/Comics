//
//  SectionViewModel.m
//  Comics
//
//  Created by Jason on 2018/6/1.
//  Copyright © 2018年 Jason. All rights reserved.
//

#import "ChapterViewModel.h"

@implementation ChapterViewModel


NSInteger alphabeticSort(id string1, id string2, void *reverse)
{
    if (*(BOOL *)reverse == YES) {
        
        return [string2 localizedCaseInsensitiveCompare:string1];
    }
    
    return [string1 localizedCaseInsensitiveCompare:string2];
}


+ (NSArray<NSArray<NSString *> *> *)sections{
    NSMutableArray *picturePaths = [NSMutableArray array];
    
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[NSBundle mainBundle] bundlePath] error:NULL];
    for (NSString *fileName in files) {
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:path];
        // do something with `url`
        if ([[url pathExtension] isEqualToString:@"jpg"]) {
            [picturePaths addObject:url.path];
        }
    }
    
    NSLog(@"%@",picturePaths);
    // note: anArray is sorted
    NSData *sortedArrayHint = [picturePaths sortedArrayHint];
    
    
    // sort with a hint
    BOOL reverseSort = NO;
    NSArray *sortedArray = [picturePaths sortedArrayUsingFunction:alphabeticSort
                                                          context:&reverseSort
                                                             hint:sortedArrayHint];
    
    NSLog(@"hintFunctionSortedArray = %@",sortedArray);
    
    
    NSMutableArray *chapters = [NSMutableArray array];
    
    for (NSString *urlStr in sortedArray) {
        NSURL *url = [NSURL fileURLWithPath:urlStr];
        // 从路径中获得完整的文件名（带后缀）
        NSString *fullfile = [url lastPathComponent];
        // 获得文件名（不带后缀）
        NSString *file = [fullfile stringByDeletingPathExtension];
        int chapter = [[file substringWithRange:NSMakeRange(2, 2)] intValue];
        
        if (chapter > chapters.count) {
            NSMutableArray *pages = [NSMutableArray array];
            [pages addObject:urlStr];
            [chapters addObject:pages];
        }else{
            NSMutableArray *pages = [chapters objectAtIndex:(chapter - 1)];
            [pages addObject:urlStr];
        }
        
    }
    
    return chapters;
    
    
}

@end

