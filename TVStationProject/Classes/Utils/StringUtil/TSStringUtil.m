//
//  TSStringUtil.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/19.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSStringUtil.h"

@implementation TSStringUtil
//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

// 字典转成字符串
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        NSLog(@"Successfully serialized the dictionary into data.");
        //NSData转换为String
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    } else if ([jsonData length] == 0 && error == nil) {
        NSLog(@"No data was returned after serialization.");
    } else if (error != nil) {
        NSLog(@"An error happened = %@", error);
    }
    return nil;
}
@end
