//
//  VSServerManager.h
//  API_VK_TEST
//
//  Created by Владислав Станишевский on 6/8/15.
//  Copyright (c) 2015 Vlad Stanishevskij. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSServerManager : NSObject

+ (VSServerManager *)sharedManager;

- (void)getFriendsNumberWithOffset:(NSUInteger)offset
                             count:(NSUInteger)count
                         onSuccess:(void(^)(NSArray *friends)) success
                         onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

@end
