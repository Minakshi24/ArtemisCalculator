//
//  EnglishAbility.m
//  Artemis Immigration - 457 Calculator
//
//  Created by Minakshi on 3/28/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import "EnglishAbility.h"
#import "Salary.h"
#import "Sponser.h"
#import <QuartzCore/QuartzCore.h>

@interface EnglishAbility ()

@end

@implementation EnglishAbility

@synthesize englishAbilityTableView, englishAbilityArray;

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
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.englishAbilityArray = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < 10; i++)
    {
        [self.englishAbilityArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    logoImageView.frame = CGRectMake(85, 10, 150, 111);
    logoImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:logoImageView];
    [logoImageView release];
    
    UILabel *occupationLabel = [[UILabel alloc] init];
    occupationLabel.frame = CGRectMake(10, 125, 300, 60);
    occupationLabel.backgroundColor = [UIColor clearColor];
    occupationLabel.textAlignment = NSTextAlignmentCenter;
    occupationLabel.textColor = [UIColor blackColor];
    occupationLabel.text = @"5. English Ability (speaking, reading, writing and listening).";
    occupationLabel.numberOfLines = 2;
    [self.view addSubview:occupationLabel];
    
    self.englishAbilityTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 195, 300, 265)];
    self.englishAbilityTableView.backgroundColor = [UIColor clearColor];
    self.englishAbilityTableView.delegate = self;
    self.englishAbilityTableView.dataSource = self;
    self.englishAbilityTableView.separatorStyle = UITableViewCellSelectionStyleBlue;
    self.englishAbilityTableView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.englishAbilityTableView.layer.borderWidth = 2.0;
    [self.view addSubview:self.englishAbilityTableView];
    
    self.englishAbilityTableView.contentSize = CGSizeMake(300, 50*[self.englishAbilityArray count]);
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.englishAbilityArray count];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *simpleTable=@"SimpleTable";
	
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
	
	cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.font = [UIFont fontWithName:@"ArialMT" size:20];
    cell.detailTextLabel.text = [self.englishAbilityArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    
    mainDelegate.occupationStr = [self.englishAbilityArray objectAtIndex:indexPath.row];
    
    if(indexPath.row > 7)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Result" message:@"Congratulations, Pass" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        alertView.tag = 200;
        [alertView show];
    }
    else
    {
    
        Salary *salaryObj = [[Salary alloc] init];
        [self.navigationController pushViewController:salaryObj animated:YES];
    }
    
    
	
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag == 200)
    {
        if (buttonIndex == 0)
        {
            //Code for OK button
            Sponser *sponserObj = [[Sponser alloc] init];
            [self.navigationController pushViewController:sponserObj animated:YES];
        }
        if (buttonIndex == 1)
        {
            //Code for download button
        }
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
