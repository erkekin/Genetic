//
//  Birey.m
//  Genetic
//
//  Created by Erk EKİN on 04/05/14.
//  Copyright (c) 2014 erkekin. All rights reserved.
//

#import "Birey.h"

@implementation Birey

- (instancetype)initWithGeneticCode:(NSString*)code
{
    self = [super init];
    if (self) {
        self.geneticCode = code;
    }
    return self;
}
- (NSString *)description
{
    return self.geneticCode;
}
@end

