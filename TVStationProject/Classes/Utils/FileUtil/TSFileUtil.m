//
//  TSFileUtil.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/11.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSFileUtil.h"

@implementation TSFileUtil

// 给指定文件目录添加不备份属性
+ (void)addDoNotBackupAttribute:(NSString *)path
{
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [url setResourceValue:@YES forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        NSLog(@"error in set back up attribute: %@", error.localizedDescription);
    }
}

// 文件缓存时间
+ (long)cacheFileDuration:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSDictionary *attributes = [fileManager attributesOfItemAtPath:path error:&error];
    if (!attributes) {
        NSLog(@"Error get attributes for file at %@: %@", path, error);
        return -1;
    }
    long seconds = -[[attributes fileModificationDate] timeIntervalSinceNow];
    return seconds;
}

// 创建文件根路径
+ (void)createBaseDirectoryAtPath:(NSString *)path
{
    NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        NSLog(@"create cache diretory failed, error = %@", error);
    } else {
        [TSFileUtil addDoNotBackupAttribute:path];
    }
}

// 创建文件夹目录
+ (void)checkDirectory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        // 创建缓存目录
        [TSFileUtil createBaseDirectoryAtPath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            // 重新创建缓存目录
            [TSFileUtil createBaseDirectoryAtPath:path];
        }
    }
}

// 获取文件夹路径
+ (NSString *)getBasePathWithEndString:(NSString *)string
{
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:string];
    [TSFileUtil checkDirectory:path];
    return path;
}
@end
