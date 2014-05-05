//
//  Population.h
//  Genetic
//
//  Created by Erk EKİN on 04/05/14.
//  Copyright (c) 2014 erkekin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Population : NSObject

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSMutableArray * population;

- (instancetype)initWithPopulation:(NSArray*)population;
- (instancetype)initPopulationRandomlyWithBireyCount:(int)bireyCount;

- (int)getSumOfFitnessValues;
- (void)normalizeFitnessValues;
- (void)makeSelection;
- (void)print;
- (void)crossOver;

@end
