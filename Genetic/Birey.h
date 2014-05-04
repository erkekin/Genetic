//
//  Birey.h
//  Genetic
//
//  Created by Erk EKİN on 04/05/14.
//  Copyright (c) 2014 erkekin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Birey : NSObject
@property (strong, nonatomic) NSString * geneticCode;

- (instancetype)initWithGeneticCode:(NSString*)code;
@end
