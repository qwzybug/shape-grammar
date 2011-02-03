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

@implementation HexGenomeViewController

@synthesize firstCritterView;
@synthesize secondCritterView;
@synthesize childCritterView;

- (void)dealloc;
{
	[firstCritterView release], firstCritterView = nil;
	[secondCritterView release], secondCritterView = nil;
	[childCritterView release], childCritterView = nil;
	
	[super dealloc];
}

- (void)viewDidLoad;
{
	self.firstCritterView.critter = [[[HexCritter alloc] init] autorelease];
	self.secondCritterView.critter = [[[HexCritter alloc] init] autorelease];
}

- (IBAction)shuffleAction:(id)sender;
{
	HexCritterView *critterView = ([sender tag] == 1) ? self.firstCritterView : self.secondCritterView;
	critterView.critter = [[[HexCritter alloc] init] autorelease];
	[critterView setNeedsDisplay];
}

- (IBAction)breedAction:(id)sender;
{
	self.childCritterView.critter = [HexCritter critterByBreeding:self.firstCritterView.critter with:self.secondCritterView.critter];
	[self.childCritterView setNeedsDisplay];
}

@end
