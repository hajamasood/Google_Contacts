//
//  GCUser.h
//  GoogleContacts
//
//  Created by Haja Masood on 7/17/14.
//  Copyright (c) 2014 Hajamasood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCUser : NSObject

@property (nonatomic,strong) NSString *firstName;
@property (nonatomic,strong) NSString *lastName;
@property (nonatomic,strong) NSString *phoneno;
@property (nonatomic,strong) NSString *cell;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *street;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *zip;
@property (nonatomic,strong) NSString *pictureLink;

-(id)initWithUser:(NSDictionary *)userDict;

@end
