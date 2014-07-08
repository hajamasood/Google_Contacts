//
//  GCMainViewController.m
//  GoogleContacts
//
//  Created by Haja Masood on 7/8/14.
//  Copyright (c) 2014 Hajamasood. All rights reserved.
//

#import "GCMainViewController.h"
#import "GCContactsManager.h"
#import "GCContactsTableViewController.h"

@interface GCMainViewController ()

@end

@implementation GCMainViewController

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
    [[GCContactsManager sharedInstance] setDelegate:self];
    self.title = @"Login";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    self.view.alpha = 0.5;
    [[GCContactsManager sharedInstance] fetchContactsWithUsername:self.username.text password:self.password.text];
}

#pragma mark - GCContactsManagerDelegate Methods

- (void)fetchContactsSucceed
{
    self.view.alpha = 1.0;
    GCContactsTableViewController *ctvc = [[GCContactsTableViewController alloc] initWithNibName:@"GCContactsTableViewController" bundle:nil];
    [self.navigationController pushViewController:ctvc animated:YES];
}

@end
