//
//  Population.m
//  Genetic
//
//  Created by Erk EKİN on 04/05/14.
//  Copyright (c) 2014 erkekin. All rights reserved.
//
#import "Birey.h"
#import "Population.h"

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
            for (int j = 0; j<10; j++) {
                
                [geneticCode appendString:[NSString stringWithFormat:@"%d",arc4random() % 2]];
            }
            Birey * birey = [[Birey alloc] initWithGeneticCode:geneticCode];
            [self.population addObject:birey];
        }

        
        
    }
    return self;
}
- (int) getSumOfOnesInPopulation{
    __block int sum = 0;
    
    [self.population enumerateObjectsUsingBlock:^(Birey * birey, NSUInteger idx, BOOL *stop) {
        
        sum += [birey countOnes];
    }];
    
    return sum;
}

- (void)selection{
    
    int sum = [self getSumOfOnesInPopulation];
    [self.population enumerateObjectsUsingBlock:^(Birey * birey, NSUInteger idx, BOOL *stop) {
        
        birey.probabilityToBeChosen = [birey countOnes]*1.0/sum;
        NSLog(@"%f",birey.probabilityToBeChosen);
        
    }];
    
}
@end
