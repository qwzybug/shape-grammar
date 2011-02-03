//
//  HexCritterView.m
//  HexGenome
//
//  Created by Devin Chalmers on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HexCritterView.h"
#import "HexCritter.h"

#define SCALE 10.0

#define V_H(sz) CGPointMake((sz) + (sz) * sqrt(3) / 4, 0)
#define V_V(sz) CGPointMake(0, (sz) * sqrt(3) / 2)

@implementation HexCritterView

@synthesize critter;

- (void)dealloc;
{
	[critter release], critter = nil;
	
    [super dealloc];
}

- (void)drawRect:(CGRect)rect;
{
	if (!self.critter)
		return;
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithWhite:0.0 alpha:0.6].CGColor);
	CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:0.0 alpha:0.3].CGColor);
	
	CGPoint p = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
	int gene_num = 0;
	hex_gene gene;
	do {
		gene = self.critter.genome[gene_num];
		
		int sz = gene.size;
		
		CGRect thisRect = CGRectMake(p.x - sz, p.y - sz, 2 * sz, 2 * sz);
		CGContextFillEllipseInRect(ctx, thisRect);
		CGContextStrokeEllipseInRect(ctx, thisRect);
		
		switch (gene.next_hex) {
			case 0:
				p = CGPointMake(p.x - 2 * V_V(sz).x, p.y - 2 * V_V(sz).y);
				break;
			case 1:
				p = CGPointMake(p.x - V_H(sz).x - V_V(sz).x, p.y - V_H(sz).y - V_V(sz).y);
				break;
			case 2:
				p = CGPointMake(p.x - V_H(sz).x + V_V(sz).x, p.y - V_H(sz).y + V_V(sz).y);
				break;
			case 3:
				p = CGPointMake(p.x + 2 * V_V(sz).x, p.y + 2 * V_V(sz).y);
				break;
			case 4:
				p = CGPointMake(p.x + V_H(sz).x + V_V(sz).x, p.y + V_H(sz).y + V_V(sz).y);
				break;
			case 5:
				p = CGPointMake(p.x + V_H(sz).x - V_V(sz).x, p.y + V_H(sz).y - V_V(sz).y);
				break;
		}
		
		gene_num++;
	} while (gene.next_hex != -1);
}


@end
