//
//  GCContactsManager.m
//  GoogleContacts
//
//  Created by Haja Masood on 7/8/14.
//  Copyright (c) 2014 Hajamasood. All rights reserved.
//

#import "GCContactsManager.h"
#import "GCContactsManager.h"

@interface GCContactsManager ()
{
    NSString *_username;
    NSString *_password;
}
@end

@implementation GCContactsManager

+(GCContactsManager *)sharedInstance
{
    static GCContactsManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance)
        {
            instance = [[GCContactsManager alloc] init];
        }
    });
    
    return instance;
}

-(id)init
{
    self = [super init];
    if (self) {
        _googleContacts = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSArray *)getGoogleContacts
{
    return (NSArray *)_googleContacts;
}

#pragma mark - Google Contacts Fetch Methods

- (void)fetchContactsWithUsername:(NSString *)username password:(NSString *)password
{
    _username = username;
    _password = password;
    
    GDataServiceGoogleContact *service = [self contactService];
    GDataServiceTicket *ticket;
    
    BOOL shouldShowDeleted = TRUE;
    
    // request a whole buncha contacts; our service object is set to
    // follow next links as well in case there are more than 2000
    
    const int kBuncha = 2000;
    
    NSURL *feedURL = [GDataServiceGoogleContact contactFeedURLForUserID:kGDataServiceDefaultUser];
    
    GDataQueryContact *query = [GDataQueryContact contactQueryWithFeedURL:feedURL];
    [query setShouldShowDeleted:shouldShowDeleted];
    [query setMaxResults:kBuncha];
    
    ticket = [service fetchFeedWithQuery:query
                                delegate:self
                       didFinishSelector:@selector(contactsFetchTicket:finishedWithFeed:error:)];
    
    [self setContactFetchTicket:ticket];
}

- (void)setContactFetchTicket:(GDataServiceTicket *)ticket
{
    _mContactFetchTicket = ticket;
}

- (GDataServiceGoogleContact *)contactService
{
    static GDataServiceGoogleContact* service = nil;
    
    if (!service) {
        service = [[GDataServiceGoogleContact alloc] init];
        
        [service setShouldCacheResponseData:YES];
        [service setServiceShouldFollowNextLinks:YES];
    }
    
    // update the username/password each time the service is requested
    
    [service setUserCredentialsWithUsername:_username
                                   password:_password];
    
    return service;
}

// contacts fetched callback
- (void)contactsFetchTicket:(GDataServiceTicket *)ticket
           finishedWithFeed:(GDataFeedContact *)feed
                      error:(NSError *)error {
    
    if (error) {
        NSLog(@"Contacts Fetch error");
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(fetchContactsFailed)]) {
            [self.delegate fetchContactsFailed];
        }
        
    } else {
        
        NSArray *contacts = [feed entries];
        NSLog(@"Contacts Count: %d ", [contacts count]);
        [_googleContacts removeAllObjects];
        for (int i = 0; i < [contacts count]; i++) {
            GDataEntryContact *contact = [contacts objectAtIndex:i];
            
            // Name
            NSString *ContactName = [[[contact name] fullName] contentStringValue];
            
            // Email
            GDataEmail *email = [[contact emailAddresses] objectAtIndex:0];
            NSString *ContactEmail =  @"";
            if (email && [email address]) {
                ContactEmail = [email address];
            }
            
            // Phone
            GDataPhoneNumber *phone = [[contact phoneNumbers] objectAtIndex:0];
            NSString *ContactPhone = @"";
            if (phone && [phone contentStringValue]) {
                ContactPhone = [phone contentStringValue];
            }
            
            // Address
            GDataStructuredPostalAddress *postalAddress = [[contact structuredPostalAddresses] objectAtIndex:0];
            NSString *address = @"";
            if (postalAddress && [postalAddress formattedAddress]) {
                address = [postalAddress formattedAddress];
            }
            
            if (!ContactName || !(ContactEmail || ContactPhone) ) {
               // Empty Contact Fields. Not Adding
            }
            else
            {
                NSArray *keys = [[NSArray alloc] initWithObjects:CONTACT_KEY_NAME, CONTACT_KEY_EMAIL, CONTACT_KEY_PHONE_NUMBER, CONTACT_KEY_ADDRESS, nil];
                NSArray *objs = [[NSArray alloc] initWithObjects:ContactName, ContactEmail, ContactPhone, address, nil];
                NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objs forKeys:keys];
                
                [_googleContacts addObject:dict];
            }
        }
        
        NSSortDescriptor *descriptor =
        [[NSSortDescriptor alloc] initWithKey:CONTACT_KEY_NAME ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
        [_googleContacts sortUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
        
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(fetchContactsSucceed)]) {
            [self.delegate fetchContactsSucceed];
        }
        
    }
}


@end
