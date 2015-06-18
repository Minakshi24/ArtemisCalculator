//
//  Qualification.m
//  Artemis Immigration - 457 Calculator
//
//  Created by Minakshi on 3/28/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import "Qualification.h"
#import "OccupationYears.h"
#import "Country.h"
#import <QuartzCore/QuartzCore.h>

@interface Qualification ()

@end

@implementation Qualification

@synthesize qualificationTableView, qualificationArray;

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
	// Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.qualificationArray = [[NSMutableArray alloc] initWithObjects:@"None", @"Diploma", @"Bachelor Degree", @"Higher Than Bachelor", nil];
    
    logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    logoImageView.frame = CGRectMake(85, 10, 150, 111);
    logoImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:logoImageView];
    [logoImageView release];
    
    UILabel *occupationLabel = [[UILabel alloc] init];
    occupationLabel.frame = CGRectMake(10, 125, 300, 40);
    occupationLabel.backgroundColor = [UIColor clearColor];
    occupationLabel.textAlignment = NSTextAlignmentCenter;
    occupationLabel.textColor = [UIColor blackColor];
    occupationLabel.text = @"2. Qualification";
    [self.view addSubview:occupationLabel];
    
    self.qualificationTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 175, 300, 50*[self.qualificationArray count])];
    self.qualificationTableView.backgroundColor = [UIColor clearColor];
    self.qualificationTableView.delegate = self;
    self.qualificationTableView.dataSource = self;
    self.qualificationTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.qualificationTableView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.qualificationTableView.layer.borderWidth = 2.0;
    [self.view addSubview:self.qualificationTableView];
    
    self.qualificationTableView.contentSize = CGSizeMake(300, 50*[self.qualificationArray count]);

    
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.qualificationArray count];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *simpleTable = @"SimpleTable";
	
	UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTable];
	//cell.contentView.backgroundColor = [UIColor blackColor];
	if(cell==nil){
		cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTable]autorelease];
	}
	
    //	NSArray *subviews = [[NSArray alloc]initWithArray:cell.contentView.subviews];
    //
    //	for(UILabel *subview in subviews){
    //
    //		[subview removeFromSuperview];
    //	}
    //	[subviews release];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	
	cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.text = [self.qualificationArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	mainDelegate.qualification = [self.qualificationArray objectAtIndex:indexPath.row];
    
    if(indexPath.row == 0)
    {
        OccupationYears *occupationYearsObj = [[OccupationYears alloc] init];
        [self.navigationController pushViewController:occupationYearsObj animated:YES];
    }
    else
    {
        Country *countryObj = [[Country alloc] init];
        [self.navigationController pushViewController:countryObj animated:YES];
        
    }
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
