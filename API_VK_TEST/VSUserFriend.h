//
//  VSUser.h
//  API_VK_TEST
//
//  Created by Владислав Станишевский on 6/9/15.
//  Copyright (c) 2015 Vlad Stanishevskij. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSUserFriend : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSURL *imgURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
