//
//  GCContactDetailViewController.h
//  GoogleContacts
//
//  Created by Haja Masood on 7/8/14.
//  Copyright (c) 2014 Hajamasood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCContactsManager.h"

@class GCUser;

@interface GCContactDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *phoneno;
@property (weak, nonatomic) IBOutlet UITextView *address;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

-(id)initWithContact:(GCUser *)contact;

@end
