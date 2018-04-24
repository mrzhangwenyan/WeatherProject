//
//  LocalArchiverManager.h
//  Weather
//
//  Created by 张文晏 on 2018/4/24.
//  Copyright © 2018年 www.zhangwenyan@travel.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalArchiverManager : NSObject

+ (LocalArchiverManager *)shareManager;
- (void)clearArchiverData;
- (void)saveDataArchiver:(id)obj fileName:(NSString *)name;
- (id)archiverQueryName:(NSString *)name;
@end
