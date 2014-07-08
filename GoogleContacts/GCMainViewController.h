//
//  GCMainViewController.h
//  GoogleContacts
//
//  Created by Haja Masood on 7/8/14.
//  Copyright (c) 2014 Hajamasood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCContactsManager.h"

@interface GCMainViewController : UIViewController <GCContactsManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *login;

- (IBAction)login:(id)sender;

@end
