//
//  shapes1ViewController.h
//  shapes1
//
//  Created by Devin Chalmers on 8/28/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GrammarShapeLayer;

@interface shapes1ViewController : UIViewController {

}

@property (nonatomic, retain) GrammarShapeLayer *best;
@property (nonatomic, retain) GrammarShapeLayer *secondBest;

@property (nonatomic, retain) NSArray *candidateViews;
@property (nonatomic, retain) NSMutableArray *candidates;
@property (nonatomic, retain) NSMutableArray *candidateScores;

@property (nonatomic, retain) IBOutlet UIView *containerView;

@property (nonatomic, retain) IBOutlet UIImageView *targetView;

@property (nonatomic, retain) IBOutlet UIImageView *candidate1View;
@property (nonatomic, retain) IBOutlet UIImageView *candidate2View;
@property (nonatomic, retain) IBOutlet UIImageView *candidate3View;
@property (nonatomic, retain) IBOutlet UIImageView *candidate4View;
@property (nonatomic, retain) IBOutlet UIImageView *candidate5View;
@property (nonatomic, retain) IBOutlet UIImageView *candidate6View;
@property (nonatomic, retain) IBOutlet UIImageView *candidate7View;
@property (nonatomic, retain) IBOutlet UIImageView *candidate8View;
@property (nonatomic, retain) IBOutlet UIImageView *candidate9View;

- (IBAction)shuffleAction:(id)sender;
- (IBAction)evolveAction:(id)sender;

- (float)scoreCandidateImage:(UIImage *)image;
- (void)showShape:(GrammarShapeLayer *)shape;

@end

