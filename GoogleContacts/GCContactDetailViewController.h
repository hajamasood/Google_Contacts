//
//  GCContactDetailViewController.h
//  GoogleContacts
//
//  Created by Haja Masood on 7/8/14.
//  Copyright (c) 2014 Hajamasood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCContactsManager.h"

@interface GCContactDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *contact;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *phoneno;
@property (weak, nonatomic) IBOutlet UITextView *address;

@end
