//
//  GCContactDetailViewController.m
//  GoogleContacts
//
//  Created by Haja Masood on 7/8/14.
//  Copyright (c) 2014 Hajamasood. All rights reserved.
//

#import "GCContactDetailViewController.h"

@interface GCContactDetailViewController ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = self.contact[CONTACT_KEY_NAME];
    
    self.name.text = self.contact[CONTACT_KEY_NAME];
    self.email.text = self.contact[CONTACT_KEY_EMAIL];
    self.phoneno.text = self.contact[CONTACT_KEY_PHONE_NUMBER];
    self.address.text = self.contact[CONTACT_KEY_ADDRESS];
    
    [self loadContactPhoto];
    
    [self.view setUserInteractionEnabled:NO];
}

- (void)loadContactPhoto
{
    NSURL *photoURL = [NSURL URLWithString:self.contact[CONTACT_KEY_PHOTO_URL]];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *photoData = [NSData dataWithContentsOfURL:photoURL];

        if (photoData.length > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.photoImageView.image = [UIImage imageWithData:photoData];
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
