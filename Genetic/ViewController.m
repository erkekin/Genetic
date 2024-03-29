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



- (IBAction)createPopulation:(id)sender{
    
    population = [[Population alloc] initPopulationRandomlyWithBireyCount:PopulationSize];
    
    [population print];
}
- (IBAction)makeSelection:(id)sender{
    
    [population makeSelection];
    [population print];
    
}
- (IBAction)recombination {
    
    [population crossOver];
    [population print];
}
- (IBAction)mutation{
    
    [population mutate];
    
    [population print];
}

- (IBAction)iterate:(id)sender{
    
    [self createPopulation:sender];
    
    for (int i = 0; i<40; i++) {
        
        [self makeSelection:sender];
        [self recombination];
        [self mutation];
        
    }
    
    [population print];
}
@end
