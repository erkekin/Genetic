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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)recombination {
    __block  NSMutableArray* newPopulation = [NSMutableArray arrayWithCapacity:population.population.count];
    
    [population.population enumerateObjectsUsingBlock:^(Individual * birey1, NSUInteger idx1, BOOL *stop1) {
        [population.population enumerateObjectsUsingBlock:^(Individual * birey2, NSUInteger idx, BOOL *stop) {
            
            if (![birey1 isEqual:birey2]) {
                
                Individual * cocuk = [birey1 crossOverBireyWithBirey:birey2 withCrossOverPoint:birey1.geneticCode.length/2];
                
                [newPopulation addObject:cocuk];
            }
            
        }];
        
    }];
    
    population.population = newPopulation;
    NSLog(@"sayi: %d",population.population.count);
}

-(IBAction)makeSelection:(id)sender{
    
    [population makeSelection];
    NSLog(@"%d selected...: %d",population.population.count, [population getSumOfFitnessValues]);
    
}
-(IBAction)createPopulation:(id)sender{
    
    population = [[Population alloc] initPopulationRandomlyWithBireyCount:10];
    NSLog(@"%d bireyde toplam 1'ler (FITNESS): %d",population.population.count, [population getSumOfFitnessValues]);
    
    [population normalizeFitnessValues];
    
}

-(IBAction)mutation{
    
    [population.population enumerateObjectsUsingBlock:^(Individual * birey2, NSUInteger idx, BOOL *stop) {
        
            [birey2 mutateWithRatio:0.1];
          //  NSLog(@"sonra genetik kod: %@",birey2.geneticCode);
        
    }];
    
}

@end
