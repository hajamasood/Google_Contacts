//
//  GCContactsManager.h
//  GoogleContacts
//
//  Created by Haja Masood on 7/8/14.
//  Copyright (c) 2014 Hajamasood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataFeedContact.h"
#import "GDataContacts.h"

#define CONTACT_KEY_NAME  @"name"
#define CONTACT_KEY_EMAIL  @"email"
#define CONTACT_KEY_PHONE_NUMBER  @"phone"
#define CONTACT_KEY_ADDRESS  @"address"
#define CONTACT_KEY_PHOTO_URL @"photoURL"

@protocol GCContactsManagerDelegate <NSObject>
@optional
- (void)fetchContactsSucceed;
- (void)fetchContactsFailed;

@end

@interface GCContactsManager : NSObject
{
    NSMutableArray *_googleContacts;
    GDataServiceTicket *_mContactFetchTicket;
}

@property (nonatomic,weak) id <GCContactsManagerDelegate> delegate;

+ (GCContactsManager *)sharedInstance;

- (void)fetchContactsWithUsername:(NSString *)username password:(NSString *)password;
- (NSArray *)getGoogleContacts;


@end
