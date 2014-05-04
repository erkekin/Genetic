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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(IBAction)createPopulation:(id)sender{
    
    Population* population = [[Population alloc] initPopulationRandomlyWithBireyCount:10];
    NSLog(@"toplam 1'ler (FITNESS): %d", [population getSumOfFitnessValues]);
    
    [population normalizeFitnessValues];
    [population makeSelection];
    
    __block  NSMutableArray* newPopulation = [NSMutableArray arrayWithCapacity:population.population.count];
    
    [population.population enumerateObjectsUsingBlock:^(Individual * birey1, NSUInteger idx1, BOOL *stop1) {
        [population.population enumerateObjectsUsingBlock:^(Individual * birey2, NSUInteger idx, BOOL *stop) {
            
            if (![birey1 isEqual:birey2]) {
                
                Individual * cocuk = [birey1 crossOverBireyWithBirey:birey2 withCrossOverPoint:birey1.geneticCode.length];
                NSLog(@"Anne: %@",birey1.geneticCode);
                NSLog(@"Baba: %@",birey2.geneticCode);
                NSLog(@"Cocuk: %@",cocuk.geneticCode);
                
                [newPopulation addObject:cocuk];
            }
            
        }];
        
    }];
    
    population.population = newPopulation;
    
    
}


@end
