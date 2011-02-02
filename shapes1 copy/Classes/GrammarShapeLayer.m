//
//  GrammarShapeLayer.m
//  shapes1
//
//  Created by Devin Chalmers on 8/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GrammarShapeLayer.h"

#import "CALayer_ShapeGrammar.h"

#define SCALE 250
#define UNIT 20

@implementation GrammarShapeLayer

@synthesize width;
@synthesize height;
@synthesize pos;
@synthesize subPos;
@synthesize theta;

+ (GrammarShapeLayer *)randomShape;
{
	return [self randomShapeAtDepth:0];
}

+ (GrammarShapeLayer *)randomShapeAtDepth:(int)depth;
{
	float width = random() % SCALE + UNIT;
	float height = random() % SCALE + UNIT;
	float pos = (float)(random() % 100) / 100.0;
	float subPos = (float)(random() % 100) / 100.0;
	float theta = ((float)(random() % 100) / 50.0 - 1.0) * M_PI / 2.0;
	GrammarShapeLayer *rootShape = [[[self alloc] initWithWidth:width height:height pos:pos subPos:subPos theta:theta] autorelease];
	while (!(random() % (depth + 2))) {
		[rootShape addSublayer:[self randomShapeAtDepth:(depth+1)]];
	}
	return rootShape;
}

- (GrammarShapeLayer *)mutateWithShape:(GrammarShapeLayer *)other;
{
	GrammarShapeLayer *copy = [[self copy] autorelease];
	
	NSArray *myLayers = [copy flattenedSublayers];
	
	int rand = random() % 7;
	if (rand == 0) { // splice
		GrammarShapeLayer *otherCopy = [[other copy] autorelease];
		NSArray *otherLayers = [otherCopy flattenedSublayers];
		
		GrammarShapeLayer *layer = [myLayers objectAtIndex:(random() % myLayers.count)];
		GrammarShapeLayer *splice = [otherLayers objectAtIndex:(random() % otherLayers.count)];
		
		if (random() % 2)
			[copy replaceDeepSublayer:layer with:splice];
		else
			[layer addSublayer:splice];

		if (layer == copy) {
			copy = splice;
		}
	}
	else if (rand == 1) { // extend
		GrammarShapeLayer *layer = [myLayers objectAtIndex:(random() %  myLayers.count)];
		GrammarShapeLayer *newLayer = [[layer copy] autorelease];
		[newLayer addSublayer:[[self class] randomShapeAtDepth:self.depth]];
		[copy replaceDeepSublayer:layer with:newLayer];
		if (layer == copy) {
			copy = newLayer;
		}
	}
	else if (rand == 2) { // prune
		GrammarShapeLayer *layer = [myLayers objectAtIndex:(random() %  myLayers.count)];
		if (layer != copy) {
			[layer removeFromSuperlayer];
		}
	}
	else { // perturb
		GrammarShapeLayer *layer = [myLayers objectAtIndex:(random() %  myLayers.count)];
		GrammarShapeLayer *newLayer = [[layer copy] autorelease];
		
		switch (random() % 5) {
			case 0: newLayer.width = random() % SCALE + UNIT; break;
			case 1: newLayer.height = random() % SCALE + UNIT; break;
			case 2: newLayer.pos = (float)(random() % 100) / 100.0; break;
			case 3: newLayer.subPos = (float)(random() % 100) / 100.0; break;
			case 4: newLayer.theta = ((float)(random() % 100) / 50.0 - 1.0) * M_PI; break;
		}
		
		[copy replaceDeepSublayer:layer with:newLayer];
		if (layer == copy) {
			copy = newLayer;
		}
	}
	
	return copy;
}

- (id)initWithWidth:(float)inWidth height:(float)inHeight pos:(float)inPos subPos:(float)inSubPos theta:(float)inTheta;
{
	if (!(self = [super init]))
		return nil;
	
	self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5].CGColor;
	
	self.frame = CGRectMake(0.0, 0.0, inWidth, inHeight);
	
	self.width = inWidth;
	self.height = inHeight;
	self.pos = inPos;
	self.subPos = inSubPos;
	self.theta = inTheta;
	
	return self;
}

- (void)layoutSublayers;
{
	CGRect bounds = self.bounds;
	bounds.size.width = self.width;
	bounds.size.height = self.height;
	self.bounds = bounds;
	for (GrammarShapeLayer *sublayer in self.sublayers) {
		sublayer.anchorPoint = [sublayer relativePointForPosition:sublayer.subPos];
		CGPoint subPoint = [self pointForPosition:sublayer.pos];
		sublayer.position = subPoint;
		sublayer.transform = CATransform3DMakeRotation(sublayer.theta, 0.0, 0.0, 1.0);
	}
}

- (CGPoint)relativePointForPosition:(CGFloat)position;
{
	CGPoint p = CGPointZero;
	if (position < 1.0 / 8.0) {
		p = CGPointMake(0.5 - position * 4.0, 0.0);
	}
	else if (position < 3.0 / 8.0) {
		p = CGPointMake(0.0, (position - 1.0/8.0) * 4.0);
	}
	else if (position < 5.0 / 8.0) {
		p = CGPointMake((position - 3.0/8.0) * 4.0, 1.0);
	}
	else if (position < 7.0 / 8.0) {
		p = CGPointMake(1.0, 1.0 - (position - 5.0/8.0) * 4.0);
	}
	else {
		p = CGPointMake(1.0 - (position - 7.0/8.0) * 4.0, 0.0);
	}
	return p;
}

- (CGPoint)pointForPosition:(CGFloat)position;
{
	CGPoint p = [self relativePointForPosition:position];
	return CGPointMake(p.x * self.bounds.size.width, p.y * self.bounds.size.height);
}

- (id)copyWithZone:(NSZone *)zone
{
	GrammarShapeLayer *copy = [[GrammarShapeLayer alloc] initWithWidth:self.width height:self.height pos:self.pos subPos:self.subPos theta:self.theta];
	for (GrammarShapeLayer *layer in self.sublayers) {
		[copy addSublayer:[[layer copy] autorelease]];
	}
	return copy;
}

@end
