//
//  LocalArchiverManager.m
//  Weather
//
//  Created by 张文晏 on 2018/4/24.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import "LocalArchiverManager.h"
#define Document [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define ArchiverFile    [Document stringByAppendingPathComponent:@"Archiver"]

@interface LocalArchiverManager()
@property (nonatomic, strong)NSFileManager *fileManager;
@end
@implementation LocalArchiverManager
+ (LocalArchiverManager *)shareManager {
    static LocalArchiverManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LocalArchiverManager alloc] init];
    });
    return instance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.fileManager = [NSFileManager defaultManager];
    }
    return self;
}
#pragma mark private methods
/// 检测path路径文件是否存在
- (BOOL)checkPathIsExist: (NSString *)path {
    return [self.fileManager fileExistsAtPath:path isDirectory:nil];
}
- (void)createArchiverFile {
    if (![self checkPathIsExist:ArchiverFile]) {
        [self addNewFolder:ArchiverFile];
    }
}
/// 新建目录 path为目录路径（包含目录名）
- (void)addNewFolder:(NSString *)path {
    [self.fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}
#pragma mark public methods
- (void)clearArchiverData {
    NSError *error;
    if ([self.fileManager removeItemAtPath:ArchiverFile error:&error]) {
        
    }else {
        ZZLog(@"清除本地序列化文件失败...%@",error);
    }
}
- (void)saveDataArchiver:(id)obj fileName:(NSString *)name {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:obj forKey:name];
    [archiver finishEncoding];
    [self createArchiverFile];
    name = [name stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *path = [ArchiverFile stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.text",name]];
    BOOL isSuccess = [data writeToFile:path atomically:YES];
    if (!isSuccess) {
        ZZLog(@"本地序列化失败...%@",name);
    }
}
- (id)archiverQueryName:(NSString *)name {
    NSString *str = [name stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *path = [ArchiverFile stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.text",str]];
    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id content = [unarchiver decodeObjectForKey:name];
    [unarchiver finishDecoding];
    ZZLog(@"content...%@",content);
    return content;
    
}
@end







































