//
//  TSFileUtil.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/11.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSFileUtil : NSObject

// 给指定文件目录添加不备份属性
+ (void)addDoNotBackupAttribute:(NSString *)path;

// 文件缓存时间
+ (long)cacheFileDuration:(NSString *)path;

// 创建文件根路径
+ (void)createBaseDirectoryAtPath:(NSString *)path;

// 创建文件夹目录
+ (void)checkDirectory:(NSString *)path;

// 获取文件夹路径
+ (NSString *)getBasePathWithEndString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
