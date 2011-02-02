//
//  shapes2AppDelegate.h
//  shapes2
//
//  Created by Devin Chalmers on 8/30/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class shapes2ViewController;

@interface shapes2AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    shapes2ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet shapes2ViewController *viewController;

@end

