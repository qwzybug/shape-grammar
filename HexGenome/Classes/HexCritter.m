//
//  HexCritter.m
//  HexGenome
//
//  Created by Devin Chalmers on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HexCritter.h"


@implementation HexCritter

@synthesize genome;

- (void)dealloc;
{
	free(genome);
	genome = NULL;
	
	[super dealloc];
}

- (id)init;
{
	if (!(self = [super init]))
		return nil;
	
	float prob = 0.9;
	float max_size = 100;
	
	int genome_size = 100;
	genome = calloc(genome_size, sizeof(hex_gene));
	
	int gene_count = 0;
	do {
		if (gene_count >= genome_size) {
			genome_size = genome_size * 2;
			genome = (hex_gene *)realloc(genome, genome_size * sizeof(hex_gene));
		}
		genome[gene_count++] = [self randomGene];
	} while ((float)random() / INT_MAX < prob && gene_count < max_size);
	
	genome[gene_count].next_hex = -1;
	
	return self;
}

- (hex_gene)randomGene;
{
	hex_gene gene;
	gene.type = 0;
	gene.next_hex = random() % 6;
	return gene;
}

@end
