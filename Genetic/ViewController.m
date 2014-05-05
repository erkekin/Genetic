    //
    //  ViewController.m
    //  Genetic
    //
    //  Created by Erk EKİN on 01/05/14.
    //  Copyright (c) 2014 erkekin. All rights reserved.
    //

#import "ViewController.h"

#import "Individual.h"
#import "Population.h"


@interface ViewController ()
{
    Population*population;
}
@end

@implementation ViewController

- (IBAction)recombination {
    
    __block  NSMutableArray* newPopulation = [NSMutableArray arrayWithCapacity:population.population.count];
    
    for (int i = 0; i<population.population.count; i++) {
        
        for (int j = i+1; j<population.population.count; j++) {
            Individual * birey1 = population.population[i];
            Individual * birey2 = population.population[j];
            Individual * cocuk = [birey1 crossOverBireyWithBirey:birey2 withCrossOverPoint:birey1.geneticCode.length/2];
            [newPopulation addObject:cocuk];
        }
    }
    population.population = newPopulation;
    [population print];
}

- (IBAction)makeSelection:(id)sender{
    
    [population makeSelection];
    [population print];
    
}
- (IBAction)createPopulation:(id)sender{
    
    population = [[Population alloc] initPopulationRandomlyWithBireyCount:100];
    
    [population print];
}

- (IBAction)mutation{
    
    [population.population enumerateObjectsUsingBlock:^(Individual * birey2, NSUInteger idx, BOOL *stop) {
        
        [birey2 mutateWithRatio:0.1];
        
    }];
    
    [population print];
}

@end
