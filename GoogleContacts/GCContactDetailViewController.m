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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
