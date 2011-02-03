//
//  HexGenomeViewController.m
//  HexGenome
//
//  Created by Devin Chalmers on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HexGenomeViewController.h"

#import "HexCritter.h"
#import "HexCritterView.h"

@interface HexGenomeViewController ()

@property (nonatomic, retain) NSArray *childCritterViews;

- (void)showChildren;

@end



@implementation HexGenomeViewController

@synthesize childCritterViews;

@synthesize firstCritterView;
@synthesize secondCritterView;

@synthesize childCritterView1;
@synthesize childCritterView2;
@synthesize childCritterView3;
@synthesize childCritterView4;
@synthesize childCritterView5;
@synthesize childCritterView6;

- (void)dealloc;
{
	[firstCritterView release], firstCritterView = nil;
	[secondCritterView release], secondCritterView = nil;
	
	for (HexCritterView *critterView in self.childCritterViews)
		[critterView release], critterView = nil;
	
	[childCritterViews release], childCritterViews = nil;
	
	[super dealloc];
}

- (void)viewDidLoad;
{
	self.firstCritterView.critter = [[[HexCritter alloc] init] autorelease];
	self.secondCritterView.critter = [[[HexCritter alloc] init] autorelease];
	
	self.childCritterViews = [NSArray arrayWithObjects:self.childCritterView1, self.childCritterView2, self.childCritterView3, self.childCritterView4, self.childCritterView5, self.childCritterView6, nil];
	[self showChildren];
}

- (void)showChildren;
{
	for (HexCritterView *critterView in self.childCritterViews) {
		critterView.critter = [HexCritter critterByBreeding:self.firstCritterView.critter with:self.secondCritterView.critter];
		[critterView setNeedsDisplay];
	}
}

- (IBAction)shuffleAction:(id)sender;
{
	HexCritterView *critterView = ([sender tag] == 1) ? self.firstCritterView : self.secondCritterView;
	critterView.critter = [[[HexCritter alloc] init] autorelease];
	[critterView setNeedsDisplay];
	[self showChildren];
}

@end
