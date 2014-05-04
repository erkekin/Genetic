//
//  Birey.m
//  Genetic
//
//  Created by Erk EKİN on 04/05/14.
//  Copyright (c) 2014 erkekin. All rights reserved.
//

#import "Individual.h"

@implementation Individual

- (instancetype)initWithGeneticCode:(NSString*)code
{
    self = [super init];
    if (self) {
        self.geneticCode = code;
        self.fitnessProbabilility = 0;
    }
    return self;
}

- (int)calculateFitness{
    int sum = 0;
    
    for (int i = 0; i<self.geneticCode.length; i++)
        if ([self.geneticCode characterAtIndex:i] == '1')
            sum++;
    
    return sum;
}

- (Individual *)crossOverBireyWithBirey:(Individual *)birey2
       withCrossOverPoint:(int)point{
    
    if (self.geneticCode.length != birey2.geneticCode.length) return nil;
    if (point<0 || point>self.geneticCode.length) return nil;
    
    NSRange  range1 = NSMakeRange(0, point);
    NSRange  range2 = NSMakeRange(point, birey2.geneticCode.length-point);
    
    NSString * segment1 = [self.geneticCode substringWithRange:range1];
    NSString * segment2 = [birey2.geneticCode substringWithRange:range2];
    
    Individual * yeniBirey = [[Individual alloc] initWithGeneticCode:
                         [NSString stringWithFormat:@"%@%@",segment1,segment2]];
    
    return yeniBirey;
}

- (NSString *)description
{
    return self.geneticCode;
}

@end
