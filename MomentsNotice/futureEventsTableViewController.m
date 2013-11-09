//
//  futureEventsTableViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/7/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "futureEventsTableViewController.h"

@interface futureEventsTableViewController ()
//@property MNEventList* eventList;
@end

@implementation futureEventsTableViewController

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Event";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"title";
        
        // Whether the built-in pull-to-refresh is enabled
       self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
        // The number of objects to show per page
        //self.objectsPerPage = 10;
    }
    return self;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)unwindFromAddEvent:(UIStoryboardSegue*)sender
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                            selector:@selector(refreshTable:)
                                                 name:@"refreshTable"
                                               object:nil];
    //you need to initial the eventlist here
    //demo
   // self.eventList = [[MNEventList alloc] initWithUserFetchPastEvents:self.user];
    //MNEvent* event = [[MNEvent alloc] init];
    //event = [self.eventList fectchEventByIndex:0];
    //NSLog(@"is there? %@\n",event.title);
    //demo

}
- (void)refreshTable:(NSNotification *) notification
{
    // Reload the recipes
    [self loadObjects];
}
- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
   //NSLog(@"wrong");
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
      //if ([self.objects count] == 0) {
         // NSLog(@"wrong");
    // query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    // }
    
    //    [query orderByAscending:@"name"];
    
    return query;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section. ?????????
    return [self.eventList count];
    //NSLog(@"%@", [self.eventList count]);
}*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"FutureEventCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    // Configure the cell
 
 //  UILabel titleLabel = (UIlabel*) [cell viewWithTag:100];
   // UILabel *titleLabel = (UILabel*) [cell viewWithTag:100];
    
    NSString* tempDate1;
    NSDate* fromdate1= [object objectForKey:@"fromDate"];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm'"];
    //[formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"];
     tempDate1 = [formatter stringFromDate:fromdate1];
   // NSLog(tempDate1);
cell.textLabel.text= [object objectForKey:@ "title"];
    //cell.textLabel.text=tempDate1;
    cell.detailTextLabel.text=[object objectForKey:@ "title"];
   // cell.detailTextLabel.text=tempDate1;
    //[object objectForKey:@"fromDate"];
    
   // UILabel *prepTimeLabel = (UILabel*) [cell viewWithTag:102];
    //prepTimeLabel.text = [object objectForKey:@"prepTime"];
    
    return cell;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
/*{
    static NSString *CellIdentifier = @"futureEventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    MNEvent *event = [self.eventList fectchEventByIndex:indexPath.row];
    cell.textLabel.text = event.title;
    cell.detailTextLabel.text = [event stringOfFromDate];
    
    return cell;
}
*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    PFObject *object = [self.objects objectAtIndex:indexPath.row];
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self refreshTable:nil];
    }];
}
/*- (void) objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    NSLog(@"error: %@", [error localizedDescription]);
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
 
    // <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    // [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end
