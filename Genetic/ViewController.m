//
//  ViewController.m
//  Genetic
//
//  Created by Erk EKİN on 01/05/14.
//  Copyright (c) 2014 erkekin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray* population;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    population = [NSMutableArray array];
    
    for (int i = 0; i<6; i++) {
        NSMutableString * string = [NSMutableString string];
        for (int j = 0; j<10; j++) {
            
            [string appendString:[NSString stringWithFormat:@"%d",arc4random() % 2]];
        }
        [population addObject:string];
    }
    
    NSLog(@"toplam %d", [self getSumOfOnesInPopulation]);
   
    
}
- (int)getSumOfOnesInPopulation{
    __block int sum = 0;
    
    [population enumerateObjectsUsingBlock:^(NSString * string, NSUInteger idx, BOOL *stop) {
        
        NSLog(@"str: %@  - %d \n",string,  [self countOnesInString:string]);
        sum += [self countOnesInString:string];
    }];
    
    return sum;
}
- (int)countOnesInString:(NSString*)string{
    int sum = 0;
    
    for (int i = 0; i<string.length; i++) {
        
        if ([string characterAtIndex:i] == '1') {
            
            sum++;
            
        }
        
    }
    
    return sum;
}
@end
