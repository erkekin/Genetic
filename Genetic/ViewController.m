//
//  ViewController.m
//  Genetic
//
//  Created by Erk EKİN on 01/05/14.
//  Copyright (c) 2014 erkekin. All rights reserved.
//

#import "ViewController.h"

#import "Birey.h"
#import "Population.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Population* population = [[Population alloc] initPopulationRandomlyWithBireyCount:10];
    NSLog(@"toplam 1'ler (FITNESS): %d", [population getSumOfOnesInPopulation]);
    
    [population selection];
    
    Birey * birey1 = population.population[0];
    Birey * birey2 = population.population[1];
    
    Birey * cocuk = [birey1 crossOverBireyWithBirey:birey2 withCrossOverPoint:4];
    
    NSLog(@"Anne: %@",birey1.geneticCode);
    NSLog(@"Baba: %@",birey2.geneticCode);
    NSLog(@"Cocuk: %@",cocuk.geneticCode);
    
}


@end
