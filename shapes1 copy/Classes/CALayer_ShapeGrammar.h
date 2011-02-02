//
//  CALayer_ShapeGrammar.h
//  shapes1
//
//  Created by Devin Chalmers on 8/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface CALayer (ShapeGrammar)

- (NSArray *)flattenedSublayers;
- (void)replaceDeepSublayer:(CALayer *)layer with:(CALayer *)layer2;
- (int)deepSublayerCount;
- (int)depth;

@end
