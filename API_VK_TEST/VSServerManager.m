//
//  VSServerManager.m
//  API_VK_TEST
//
//  Created by Владислав Станишевский on 6/8/15.
//  Copyright (c) 2015 Vlad Stanishevskij. All rights reserved.
//

#import "VSServerManager.h"
#import "VSUserFriend.h"
#import <AFNetworking.h>

static NSUInteger user_id = 87290707;

@interface VSServerManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *requestOperationManager;

@end

@implementation VSServerManager

+ (VSServerManager *)sharedManager {
    
    static VSServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[VSServerManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURL *baseURL = [NSURL URLWithString:@"https://api.vk.com/method/"];
        
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    }
    return self;
}

- (void)getFriendsNumberWithOffset:(NSUInteger)offset
                             count:(NSUInteger)count
                         onSuccess:(void(^)(NSArray *friends)) success
                         onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *params = @{@"user_id": [NSNumber numberWithUnsignedInteger:user_id],
                             @"order": @"name",
                             @"count": [NSNumber numberWithUnsignedInteger:count],
                             @"offset": [NSNumber numberWithUnsignedInteger:offset],
                             @"fields": @"photo_50",
                             @"name_case": @"nom"};

    [self.requestOperationManager GET:@"friends.get" parameters:params
                              success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                                  
                                  NSArray *friends = [responseObject objectForKey:@"response"];
                                  
                                  NSMutableArray *usersArray = [NSMutableArray array];
                                  
                                  for (NSDictionary *dict in friends) {
                                      
                                      VSUserFriend *user = [[VSUserFriend alloc] initWithDictionary:dict];
                                      [usersArray addObject:user];
                                  }
                                  
                                  if (success) {
                                      success(usersArray);
                                  }
                                  
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              
                                  NSLog(@"Error: %@", error);
                                  
                                  if(failure) {
                                      failure(error, operation.response.statusCode);
                                  }
                              }];
    
}

@end
