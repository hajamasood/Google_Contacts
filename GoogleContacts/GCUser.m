//
//  GCUser.m
//  GoogleContacts
//
//  Created by Haja Masood on 7/17/14.
//  Copyright (c) 2014 Hajamasood. All rights reserved.
//

#import "GCUser.h"

@implementation GCUser


-(id)initWithUser:(NSDictionary *)userDict
{
    self = [super init];
    if (self) {
        _firstName = userDict[@"name"][@"first"];
        _lastName = userDict[@"name"][@"last"];
        _phoneno = userDict[@"phone"];
        _cell = userDict[@"cell"];
        _email = userDict[@"email"];
        _street = userDict[@"location"][@"street"];
        _city = userDict[@"location"][@"city"];
        _state = userDict[@"location"][@"state"];
        _zip = userDict[@"location"][@"zip"];
        _pictureLink = userDict[@"picture"];
    }
    return self;
}

@end
