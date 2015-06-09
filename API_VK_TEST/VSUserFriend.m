//
//  VSUser.m
//  API_VK_TEST
//
//  Created by Владислав Станишевский on 6/9/15.
//  Copyright (c) 2015 Vlad Stanishevskij. All rights reserved.
//

#import "VSUserFriend.h"

@implementation VSUserFriend

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        self.firstName = [dictionary objectForKey:@"first_name"];
        self.lastName = [dictionary objectForKey:@"last_name"];
        self.imgURL = [NSURL URLWithString:[dictionary objectForKey:@"photo_50"]];
        
    }
    return self;
}

@end
