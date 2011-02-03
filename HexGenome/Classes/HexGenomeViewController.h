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

@property (nonatomic, retain) IBOutlet HexCritterView *critterView;

- (IBAction)shuffleAction:(id)sender;

@end

