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

@synthesize critterView;

- (void)dealloc;
{
	[critterView release], critterView = nil;
	
	[super dealloc];
}

- (void)viewDidLoad;
{
	self.critterView.critter = [[[HexCritter alloc] init] autorelease];
}

- (IBAction)shuffleAction:(id)sender;
{
	self.critterView.critter = [[[HexCritter alloc] init] autorelease];
	[self.critterView setNeedsDisplay];
}

@end
