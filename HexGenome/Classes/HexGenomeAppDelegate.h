//
//  HexGenomeAppDelegate.h
//  HexGenome
//
//  Created by Devin Chalmers on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HexGenomeViewController;

@interface HexGenomeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    HexGenomeViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HexGenomeViewController *viewController;

@end

