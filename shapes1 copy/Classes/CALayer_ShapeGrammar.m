//
//  CALayer_ShapeGrammar.m
//  shapes1
//
//  Created by Devin Chalmers on 8/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CALayer_ShapeGrammar.h"


@implementation CALayer (ShapeGrammar)

- (NSArray *)flattenedSublayers;
{
	NSArray *flattened = [NSArray arrayWithObject:self];
	for (CALayer *layer in self.sublayers) {
		flattened = [flattened arrayByAddingObjectsFromArray:[layer flattenedSublayers]];
	}
	return flattened;
}

- (void)replaceDeepSublayer:(CALayer *)layer with:(CALayer *)layer2;
{
	for (CALayer *sublayer in self.sublayers) {
		if (sublayer == layer) {
			[self replaceSublayer:layer with:layer2];
			return;
		}
		else {
			[sublayer replaceDeepSublayer:layer with:layer2];
		}
	}
}

- (int)deepSublayerCount;
{
	int count = 1;
	for (CALayer *sublayer in self.sublayers) {
		count += [sublayer deepSublayerCount];
	}
	return count;
}

- (int)depth;
{
	int depth = 0;
	CALayer *sup = self;
	while (sup = sup.superlayer) {
		depth += 1;
	}
	return depth;
}

@end
