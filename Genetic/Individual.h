//
//  Birey.h
//  Genetic
//
//  Created by Erk EKİN on 04/05/14.
//  Copyright (c) 2014 erkekin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Individual : NSObject
@property (strong, nonatomic) NSString * geneticCode;
@property (readwrite) float fitnessProbabilility;

- (instancetype)initWithGeneticCode:(NSString*)code;
- (int)calculateFitness;
- (Individual *)crossOverBireyWithBirey:(Individual *)individual
                withCrossOverPoint:(int)point;
- (void)crossOverWithBirey:(Individual *)individual
                     withCrossOverPoint:(int)point;

- (void)mutate;

@end
