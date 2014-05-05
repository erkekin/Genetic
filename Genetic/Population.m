    //
    //  Population.m
    //  Genetic
    //
    //  Created by Erk EKİN on 04/05/14.
    //  Copyright (c) 2014 erkekin. All rights reserved.
    //
#import "Individual.h"
#import "Population.h"

#define ARC4RANDOM_MAX      0x100000000

@implementation Population

- (instancetype)initWithPopulation:(NSArray*)population
{
    self = [super init];
    if (self) {
        self.population = [population mutableCopy];
        
    }
    return self;
}
- (void)print{
    
    NSLog(@"********** Nüfus: %d ************ Toplam Fitness: %d ******", self.population.count,[self getSumOfFitnessValues]);
    [self.population enumerateObjectsUsingBlock:^(Individual * birey, NSUInteger idx, BOOL *stop) {
        
        NSLog(@"Birey:%d kod: '%@'",idx,birey.geneticCode);
        
    }];
}
- (instancetype)initPopulationRandomlyWithBireyCount:(int)bireyCount
{
    self = [super init];
    if (self) {
        
        self.population = [NSMutableArray array];
        
        for (int i = 0; i<bireyCount; i++) {
            NSMutableString * geneticCode = [NSMutableString string];
            for (int j = 0; j<10; j++) {
                
                [geneticCode appendString:[NSString stringWithFormat:@"%d",arc4random() % 2]];
            }
            Individual * birey = [[Individual alloc] initWithGeneticCode:geneticCode];
            [self.population addObject:birey];
        }
        
    }
    return self;
}
- (int)getSumOfFitnessValues{
    __block int sum = 0;
    
    [self.population enumerateObjectsUsingBlock:^(Individual * birey, NSUInteger idx, BOOL *stop) {
        
        sum += [birey calculateFitness];
        
    }];
    
    return sum;
}

- (void)normalizeFitnessValues
{
    
    int sum = [self getSumOfFitnessValues];
    [self.population enumerateObjectsUsingBlock:^(Individual * birey, NSUInteger idx, BOOL *stop) {
        
        birey.fitnessProbabilility = [birey calculateFitness]*1.0/sum;
        
    }];
    
}
- (void)sortFitnessValues {
    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fitnessProbabilility" ascending:NO];
    NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
    
    self.population = [[self.population sortedArrayUsingDescriptors:descriptors] mutableCopy];
}

- (void)makeSelection{
    [self normalizeFitnessValues];
    [self sortFitnessValues];
    
    __block  NSMutableArray* selectedPopulation = [NSMutableArray arrayWithCapacity:self.population.count];
    
    __block float sum = 0;
    float cumulativeRandomValue = (float)arc4random() / ARC4RANDOM_MAX;
    
    [self.population enumerateObjectsUsingBlock:^(Individual * birey, NSUInteger idx, BOOL *stop) {
        
        sum+=birey.fitnessProbabilility;
        if (cumulativeRandomValue>sum) {
            [selectedPopulation addObject:birey];
        }
        
    }];
    
    self.population = [NSMutableArray arrayWithArray:selectedPopulation];
}
@end
