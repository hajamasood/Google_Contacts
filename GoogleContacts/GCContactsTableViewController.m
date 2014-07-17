//
//  GCContactsTableViewController.m
//  GoogleContacts
//
//  Created by Haja Masood on 7/8/14.
//  Copyright (c) 2014 Hajamasood. All rights reserved.
//

#import "GCContactsTableViewController.h"
#import "GCContactsManager.h"
#import "GCContactDetailViewController.h"
#import "GCUser.h"

#define RANDOM_20_USERS_API @"http://api.randomuser.me/?results=20"

@interface GCContactsTableViewController ()
{
    NSMutableArray *_contacts;
    UIActivityIndicatorView *_spinner;
    
}
@end

@implementation GCContactsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _contacts = [[NSMutableArray alloc] init];
    self.title = @"Contacts";
    
    //add network activity indicator
    _spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50.0, 50.0)];
    [_spinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [_spinner setCenter:self.view.center];
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
    [self getRandomUsers];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    GCUser *user = _contacts[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName];
    
    // set placeholder user image while image is being downloaded
    cell.imageView.image = [UIImage imageNamed:@"contact_placeholder"];
    
    __weak UITableViewCell *wCell = cell;
    
    // download the image asynchronously
    [self downloadDataWithURL:[NSURL URLWithString:user.pictureLink] completionBlock:^(BOOL succeeded, NSData *data) {
        if (succeeded) {
            // change the image in the cell
            UIImage *image = [UIImage imageWithData:data];
            wCell.imageView.image = image;
            
        }
    }];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    GCContactDetailViewController *detailViewController = [[GCContactDetailViewController alloc] initWithContact:_contacts[indexPath.row]];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - Helper Methods

-(void)getRandomUsers
{
    
    [self downloadDataWithURL:[NSURL URLWithString:RANDOM_20_USERS_API] completionBlock:^(BOOL succeeded, NSData *responseData) {
        NSError *jsonError;
        NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonError];
        [self handleJSON:jsonResults];
        
    }];
    
}

- (void)handleJSON:(NSDictionary *)json
{
    for (NSDictionary *userDict in json[@"results"]) {
        GCUser *user = [[GCUser alloc] initWithUser:userDict[@"user"]];
        [_contacts addObject:user];
    }
    NSLog(@"total contacts retrieved : %d",_contacts.count);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_spinner stopAnimating];
        [_spinner removeFromSuperview];
        [self.tableView reloadData];
    });
}

- (void)downloadDataWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, NSData *responseData))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if ( !connectionError )
        {
            completionBlock(YES,data);
        }
        else
        {
            NSLog(@"Connection Error !! %@",connectionError);
            completionBlock(NO,nil);
        }

    }];
    
}

@end
