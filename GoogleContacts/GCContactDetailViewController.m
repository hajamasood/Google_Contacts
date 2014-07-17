//
//  GCContactDetailViewController.m
//  GoogleContacts
//
//  Created by Haja Masood on 7/8/14.
//  Copyright (c) 2014 Hajamasood. All rights reserved.
//

#import "GCContactDetailViewController.h"
#import "GCUser.h"

@interface GCContactDetailViewController ()
{
    GCUser *_contact;
}
@end

@implementation GCContactDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithContact:(GCUser *)contact
{
    self = [super initWithNibName:@"GCContactDetailViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _contact = contact;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = _contact.firstName;
    self.name.text = [NSString stringWithFormat:@"%@ %@",_contact.firstName,_contact.lastName];
    self.email.text = _contact.email;
    self.phoneno.text = _contact.phoneno;
    self.address.text = [NSString stringWithFormat:@"%@ \n%@ \n%@ \n%@",_contact.street,_contact.city,_contact.state,_contact.zip];
    self.photoImageView.image = [UIImage imageNamed:@"contact_placeholder"];
    
    [self loadContactPhoto];
    
    [self.view setUserInteractionEnabled:NO];
}

- (void)loadContactPhoto
{
    NSURL *photoURL = [NSURL URLWithString:_contact.pictureLink];

    __weak GCContactDetailViewController *wSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *photoData = [NSData dataWithContentsOfURL:photoURL];

        if (photoData.length > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                wSelf.photoImageView.image = [UIImage imageWithData:photoData];
            });
        }
        
    });

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
