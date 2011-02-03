//
//  HexCritter.m
//  HexGenome
//
//  Created by Devin Chalmers on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HexCritter.h"


@interface HexCritter ()
- (hex_gene *)randomGenome;
- (hex_gene)randomGene;
- (void)setGenome:(hex_gene *)newGenome;
@end



@implementation HexCritter

@synthesize genome;
@synthesize gene_count;

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
	
	hex_gene *newGenome = [self randomGenome];
	[self setGenome:newGenome];
	
	return self;
}

- (hex_gene *)randomGenome;
{
	float prob = 0.9;
	float max_size = 100;
	
	int genome_size = 100;
	hex_gene *newGenome = calloc(genome_size, sizeof(hex_gene));
	
	int geneCount = 0;
	do {
		if (geneCount >= genome_size) {
			genome_size = genome_size * 2;
			newGenome = (hex_gene *)realloc(newGenome, genome_size * sizeof(hex_gene));
		}
		newGenome[geneCount++] = [self randomGene];
	} while ((float)random() / INT_MAX < prob && geneCount < max_size);
	
	newGenome[geneCount - 1].next_hex = -1;
	NSLog(@"%d genes", geneCount);
	
	return newGenome;
}

- (hex_gene)randomGene;
{
	hex_gene gene;
	gene.type = 0;
	gene.size = random() % 10 + 5;
	gene.next_hex = random() % 6;
	return gene;
}

+ (HexCritter *)critterByBreeding:(HexCritter *)critter with:(HexCritter *)otherCritter;
{
	int firstFlip = random() % (critter.gene_count - 1);
	int secondFlip = random() % otherCritter.gene_count;
	int genome_size = firstFlip + (otherCritter.gene_count - secondFlip);
	
	hex_gene *newGenome = calloc(genome_size, sizeof(hex_gene));
	
	for (int i = 0; i < firstFlip; i++) {
		newGenome[i] = critter.genome[i];
	}
	for (int i = 0; i < (otherCritter.gene_count - secondFlip); i++) {
		newGenome[firstFlip + i] = otherCritter.genome[secondFlip + i];
	}
	
	HexCritter *child = [[self alloc] init];
	[child setGenome:newGenome];
	return [child autorelease];
}

- (void)setGenome:(hex_gene *)newGenome;
{
	if (genome)	free(genome), genome = NULL;
	
	genome = newGenome;
	
	gene_count = 0;
	hex_gene gene;
	do {
		gene = genome[gene_count++];
	} while (gene.next_hex != -1);
}

@end
