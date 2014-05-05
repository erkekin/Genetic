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

- (instancetype)initPopulationRandomlyWithBireyCount:(int)bireyCount
{
    self = [super init];
    if (self) {
        
        self.population = [NSMutableArray array];
        
        for (int i = 0; i<bireyCount; i++) {
            NSMutableString * geneticCode = [NSMutableString string];
            for (int j = 0; j<CodeLenght; j++) {
                
                [geneticCode appendString:[NSString stringWithFormat:@"%d",arc4random() % 2]];
            }
            Individual * birey = [[Individual alloc] initWithGeneticCode:geneticCode];
            [self.population addObject:birey];
        }
        
    }
    return self;
}

- (void)print{
    
    NSLog(@"                                       ");
    NSLog(@"********** Nüfus: %d ************ Toplam Fitness: %d ******", self.population.count,[self getSumOfFitnessValues]);
    NSLog(@"                                       ");
    
    [self.population enumerateObjectsUsingBlock:^(Individual * individual, NSUInteger idx, BOOL *stop) {
        
        NSLog(@"Birey:%d kod: '%@'",idx,individual.geneticCode);
        
    }];
}

- (void)crossOver{ // one-cut-point
    
    if (!self.population.count) {
        return;
    }
    int crossOverCount = self.population.count * CrossOverRate;

   NSMutableSet * crossingOverGuys = [NSMutableSet setWithCapacity:crossOverCount];
   
   while (crossingOverGuys.count != crossOverCount) {
       
       Individual * individual = self.population[arc4random() % self.population.count];
       [crossingOverGuys addObject:individual];
       
   }
    
    NSArray * array = crossingOverGuys.allObjects;
        for (int i = 0; i<array.count; i++) {
    
            for (int j = i+1; j<array.count; j++) {
                Individual * individual1 = array[i];
                Individual * individual2 = array[j];
                [individual1 crossOverWithBirey:individual2 withCrossOverPoint:individual1.geneticCode.length/2];
            }
        }
    [self.population addObjectsFromArray:array];
    
//
//    __block  NSMutableArray* newPopulation = [NSMutableArray arrayWithCapacity:self.population.count];
//    
//    int i = 0;
//    
//    while (i<PopulationSize) {
//        if (!self.population.count) {
//            return;
//        }
//        Individual * individual1 =  self.population[arc4random() % self.population.count];
//        Individual * individual2 =  self.population[arc4random() % self.population.count];
//        
//        if (![individual1 isEqual:individual2]) {
//            
//            Individual * cocuk = [individual1 crossOverBireyWithBirey:individual2 withCrossOverPoint:CodeLenght/2];
//            [newPopulation addObject:cocuk];
//            
//        }
//        
//        i++;
//    }
    
    
        //    for (int i = 0; i<population.population.count; i++) {
        //
        //        for (int j = i+1; j<population.population.count; j++) {
        //            Individual * individual1 = population.population[i];
        //            Individual * individual2 = population.population[j];
        //            Individual * cocuk = [individual1 crossOverBireyWithBirey:individual2 withCrossOverPoint:individual1.geneticCode.length/2];
        //            [newPopulation addObject:cocuk];
        //        }
        //    }
        //    
 //   self.population = newPopulation;

}
- (int)getSumOfFitnessValues{
    __block int sum = 0;
    
    [self.population enumerateObjectsUsingBlock:^(Individual * individual, NSUInteger idx, BOOL *stop) {
        
        sum += [individual calculateFitness];
        
    }];
    
    return sum;
}

- (void)normalizeFitnessValues
{
    
    int sum = [self getSumOfFitnessValues];
    [self.population enumerateObjectsUsingBlock:^(Individual * individual, NSUInteger idx, BOOL *stop) {
        
        individual.fitnessProbabilility = [individual calculateFitness]*1.0/sum;
        
    }];
    
}

- (void)sortFitnessValues { // Descending
    
    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fitnessProbabilility" ascending:NO];
    NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
    
    self.population = [[self.population sortedArrayUsingDescriptors:descriptors] mutableCopy];
}

- (void)makeSelection{ //Roulette Wheel
    
    [self normalizeFitnessValues];
    [self sortFitnessValues];
    
    __block  NSMutableArray* selectedPopulation = [NSMutableArray arrayWithCapacity:self.population.count];
    
    __block float sum = 0;
    float cumulativeRandomValue = (float)arc4random() / ARC4RANDOM_MAX;
    
    [self.population enumerateObjectsUsingBlock:^(Individual * individual, NSUInteger idx, BOOL *stop) {
        
        sum+=individual.fitnessProbabilility;
        if (cumulativeRandomValue>sum) {
            [selectedPopulation addObject:individual];
        }
        
    }];
    
    self.population = [NSMutableArray arrayWithArray:selectedPopulation];
}

- (void)mutate{
    if (!self.population.count) {
        return;
    }
    int mutationCount = self.population.count * MutationRate;
    NSMutableSet * mutantGuys = [NSMutableSet setWithCapacity:mutationCount];

    while (mutantGuys.count != mutationCount) {
        
      Individual*individual =  self.population[arc4random() % self.population.count];
        [mutantGuys addObject:individual];
    }
}
@end
