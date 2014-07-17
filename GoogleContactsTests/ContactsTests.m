//
//  GoogleContactsTests.m
//  GoogleContactsTests
//
//  Created by Haja Masood on 7/8/14.
//  Copyright (c) 2014 Hajamasood. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GCMainViewController.h"

@interface ContactsTests : XCTestCase
{
    GCMainViewController *_mainViewController;
}
@end

@implementation ContactsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _mainViewController = [[GCMainViewController alloc] initWithNibName:@"GCMainViewController" bundle:nil];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testGCMainViewControllerOuletsAndActions {
    
    //Test if GCMainViewController exists
    XCTAssertNotNil([_mainViewController view], @"ViewController should contain a view");
        
   // XCTAssertNotNil(control, @"Username should be connected");
    XCTAssertNotNil([_mainViewController username], @"Username should be connected");

    //Test if password outlet is connected
    XCTAssertNotNil([_mainViewController password], @"Password should be connected");
    
    //Test if login has action hooked up
    NSArray *actions = [_mainViewController.login actionsForTarget:_mainViewController
                                                  forControlEvent:UIControlEventTouchUpInside];

    XCTAssertTrue([actions containsObject:@"login:"], @"Login action should be connected");
    
}



@end
