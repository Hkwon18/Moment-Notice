//
//  XYZAddNewEventViewController.m
//  MomentNotice
//
//  Created by LiuLeon on 10/25/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//


#import "XYZAddNewEventViewController.h"

#define DBNAME    @"Moment.sqlite"
#define TITLE      @"title"
#define EVENTDETAIL     @"eventdetail"
#define FROMDATE   @"fromdate"
#define TODATE @"todate"
#define TABLENAME @"EVENTS"


@interface XYZAddNewEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *EventTitle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *fromDate;
@property (weak, nonatomic) IBOutlet UITextField *toDate;
@property (weak, nonatomic) IBOutlet UITextView *eventDetail;

@end

@implementation XYZAddNewEventViewController

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(sender != self.doneButton)
        return;
    if(self.EventTitle.text.length > 0)
    {
        
        //initial the new eventItem and assin the corresponding value from
        //the user input
        self.addEventItem = [[XYZEventItem alloc] init];
        self.addEventItem.eventName = self.EventTitle.text;
        self.addEventItem.completed = NO;
        self.addEventItem.eventDetail = self.eventDetail.text;
        
        //transform the data from NSString to NSDate and assign them
        //to the eventItem
        NSString* tempDate1;
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
        tempDate1 = [formatter stringFromDate:[NSDate date]];
        // notice that getDatestring is nil if the format is fualt
        NSString *tempString = self.fromDate.text;
        NSDate *getDateString = [[NSDate alloc] init];
        getDateString = [formatter dateFromString:tempString];
        self.addEventItem.fromDate= getDateString;
        getDateString = [formatter dateFromString:self.toDate.text];//wenti
        self.addEventItem.toDate = getDateString;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [paths objectAtIndex:0];
        NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
        if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
            sqlite3_close(db);
            NSLog(@"open fails");
        }
        //insert the value into the database
        NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS EVENTS (ID INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,eventdetail TEXT,fromdate TEXT,todate TEXT)";
        [self execSql:sqlCreateTable];
        NSString *sql1 = [NSString stringWithFormat:
                          @"INSERT INTO '%@' ('%@','%@','%@','%@') VALUES ('%@','%@','%@','%@')",
                          TABLENAME, TITLE,EVENTDETAIL,FROMDATE,TODATE,self.EventTitle.text,self.eventDetail.text,self.fromDate.text,self.toDate.text];
        
        
        
        [self execSql:sql1];
        sqlite3_close(db);
        
        
        
    }
    
}
-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"fails operating data");
    }
}


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
    //get the current system time and put it in the textfield of fromDate
    //for the convenience of user input
    NSString* tempDate;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
    tempDate = [formatter stringFromDate:[NSDate date]];
    self.fromDate.text = tempDate;
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
