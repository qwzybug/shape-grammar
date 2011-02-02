//
//  shapes1ViewController.m
//  shapes1
//
//  Created by Devin Chalmers on 8/28/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "shapes1ViewController.h"

#import "GrammarShapeLayer.h"
#import "PixelImage.h"
#import "CALayer_ShapeGrammar.h"

@implementation shapes1ViewController

@synthesize best;
@synthesize secondBest;

@synthesize candidates;
@synthesize candidateScores;

@synthesize candidateViews;

@synthesize containerView;
@synthesize targetView;

@synthesize candidate1View;
@synthesize candidate2View;
@synthesize candidate3View;
@synthesize candidate4View;
@synthesize candidate5View;
@synthesize candidate6View;
@synthesize candidate7View;
@synthesize candidate8View;
@synthesize candidate9View;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	srandom([NSDate timeIntervalSinceReferenceDate]);
	
	self.candidateViews = [NSArray arrayWithObjects:self.candidate1View, self.candidate2View, self.candidate3View, self.candidate4View, self.candidate5View, self.candidate6View, self.candidate7View, self.candidate8View, self.candidate9View, nil];
	self.targetView.image = [UIImage imageNamed:@"A.png"];
	self.targetView.layer.magnificationFilter = kCAFilterNearest;
	
	[self evolveAction:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
}

- (IBAction)shuffleAction:(id)sender;
{
	self.best = nil;
	self.secondBest = nil;
	[self evolve];
}

- (IBAction)evolveAction:(id)sender;
{
	[self evolve];
	
	static NSTimer *timer = nil;
	if (!timer) {
		timer = [[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(evolve) userInfo:nil repeats:YES] retain];
	}
	else {
		[timer invalidate];
		[timer release], timer = nil;
	}
}

- (IBAction)evolve;
{
	self.candidates = [NSMutableArray array];
	self.candidateScores = [NSMutableArray array];
	
	int bestIndex = -1;
	int secondBestIndex = -1;
	
	float bestScore = -1;
	
	UIGraphicsBeginImageContext(self.containerView.bounds.size);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	for (int i = 0; i < 9; i++)
	{
		GrammarShapeLayer *rootShape;
		if (self.best && self.secondBest) {
			GrammarShapeLayer *bride = (random() % 2) ? self.secondBest : [GrammarShapeLayer randomShape];
			rootShape = (i == 0) ? self.best : [self.best mutateWithShape:bride];
		}
		else {
			rootShape = [GrammarShapeLayer randomShape];
		}
		[self.candidates addObject:rootShape];
		
		CGRect frame = rootShape.frame;
		frame.origin.x = self.containerView.bounds.size.width / 2.0;
		frame.origin.y = self.containerView.bounds.size.height / 2.0;
		rootShape.frame = frame;
		
		[self showShape:rootShape];
	
		CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
		CGContextFillRect(ctx, containerView.bounds);
		[containerView.layer renderInContext:ctx];
		CGImageRef img = CGBitmapContextCreateImage(ctx);
		[[self.candidateViews objectAtIndex:i] setImage:[UIImage imageWithCGImage:img]];
		
		float score = [self scoreCandidateImage:[UIImage imageWithCGImage:img]];
		int count = [rootShape deepSublayerCount];
//		score *= (count > 5) ? (count > 10) ? 0.5 : 0.75 : 1.0;
//		score = score + (1.0 / count / 10.0);
//		score = score / sqrt([rootShape deepSublayerCount]);
		if (score > bestScore) {
			secondBestIndex = bestIndex;
			bestIndex = i;
			bestScore = score;
		}
		else if (secondBestIndex < 0) {
			secondBestIndex = i;
		}
		
		CGImageRelease(img);
	}
	
	self.best = [self.candidates objectAtIndex:bestIndex];
	self.secondBest = [self.candidates objectAtIndex:secondBestIndex];
//	self.secondBest = [GrammarShapeLayer randomShape];
	
	[self showShape:self.secondBest];
		
	UIGraphicsEndImageContext();
}

- (void)showShapeThumbnail:(GrammarShapeLayer *)shape forIndex:(int)index;
{
}

- (void)showShape:(GrammarShapeLayer *)shape;
{
	NSArray *sublayers = [NSArray arrayWithArray:self.containerView.layer.sublayers];
	for (CALayer *sublayer in sublayers) {
		[sublayer removeFromSuperlayer];
	}
	[shape layoutSublayers];
	[self.containerView.layer addSublayer:shape];
}

- (float)scoreCandidateImage:(UIImage *)image;
{
	UIImage *targetImage = self.targetView.image;
	
	static PixelImage *bitmap = nil;
	if (!bitmap) bitmap = [[PixelImage alloc] initWithWidth:targetImage.size.width height:targetImage.size.height];
	static PixelImage *target = nil;
	if (!target) target = [[PixelImage alloc] initWithImage:targetImage];
	
	[bitmap drawImage:image];
	
	int matches = 0;
	float targetBrightness, brightness;
	for (int y = 0; y < targetImage.size.height; y++) {
		for (int x = 0; x < targetImage.size.width; x++) {
			brightness = [bitmap brightnessAtX:x y:y];
			targetBrightness = [target brightnessAtX:x y:y];
			matches += (fabs(brightness - targetBrightness) < 0.2 ? 1 : 0);
		}
	}
	
	return (float)matches / (float)(bitmap.width * bitmap.height);

//	float score = 0.0;
//	float targetBrightness, brightness;
//	for (int y = 0; y < targetImage.size.height; y++) {
//		for (int x = 0; x < targetImage.size.width; x++) {
//			brightness = [bitmap brightnessAtX:x y:y];
//			targetBrightness = [target brightnessAtX:x y:y];
//			score += 1.0 - fabs(brightness - targetBrightness);
//		}
//	}
//	
//	return score;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
