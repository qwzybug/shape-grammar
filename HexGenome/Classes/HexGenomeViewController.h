//
//  HexGenomeViewController.h
//  HexGenome
//
//  Created by Devin Chalmers on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HexCritterView;

@interface HexGenomeViewController : UIViewController {

}

@property (nonatomic, retain) IBOutlet HexCritterView *firstCritterView;
@property (nonatomic, retain) IBOutlet HexCritterView *secondCritterView;

@property (nonatomic, retain) IBOutlet HexCritterView *childCritterView1;
@property (nonatomic, retain) IBOutlet HexCritterView *childCritterView2;
@property (nonatomic, retain) IBOutlet HexCritterView *childCritterView3;
@property (nonatomic, retain) IBOutlet HexCritterView *childCritterView4;
@property (nonatomic, retain) IBOutlet HexCritterView *childCritterView5;
@property (nonatomic, retain) IBOutlet HexCritterView *childCritterView6;

- (IBAction)shuffleAction:(id)sender;

@end

