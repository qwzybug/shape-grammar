//
//  GrammarShapeLayer.h
//  shapes1
//
//  Created by Devin Chalmers on 8/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface GrammarShapeLayer : CALayer <NSCopying> {

}

@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) float pos;
@property (nonatomic, assign) float subPos;
@property (nonatomic, assign) float theta;

+ (GrammarShapeLayer *)randomShape;
+ (GrammarShapeLayer *)randomShapeAtDepth:(int)depth;

- (GrammarShapeLayer *)mutateWithShape:(GrammarShapeLayer *)other;

- (id)initWithWidth:(float)width height:(float)height pos:(float)inPos subPos:(float)inSubPos theta:(float)inTheta;

- (CGPoint)relativePointForPosition:(CGFloat)position;
- (CGPoint)pointForPosition:(CGFloat)position;

@end
