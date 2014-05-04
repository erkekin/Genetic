//
//  ViewController.m
//  Genetic
//
//  Created by Erk EKİN on 01/05/14.
//  Copyright (c) 2014 erkekin. All rights reserved.
//

#import "ViewController.h"

#import "Birey.h"

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
        Birey * birey = [[Birey alloc] initWithGeneticCode:string];
        [population addObject:birey];
    }
    
    NSLog(@"toplam %d", [self getSumOfOnesInPopulation]);
    
    Birey * cocuk = [self crossOverBirey:population[0] withBirey:population[1] withCrossOverPoint:4];
    NSLog(@"yeni eleman: %@",cocuk.geneticCode);
    
}

- (Birey *)crossOverBirey:(Birey *)birey1
                withBirey:(Birey *)birey2
       withCrossOverPoint:(int)point{
    
    if (birey1.geneticCode.length != birey2.geneticCode.length)
        return nil;
    
    NSRange  range1 = NSMakeRange(0, point);
    NSRange  range2 = NSMakeRange(point, birey2.geneticCode.length-point);
    
    NSString * segment1 = [birey1.geneticCode substringWithRange:range1];
    NSString * segment2 = [birey2.geneticCode substringWithRange:range2];
    
    Birey * yeniBirey = [[Birey alloc] initWithGeneticCode:[NSString stringWithFormat:@"%@%@",segment1,segment2]];
    
    return yeniBirey;
}

- (int)getSumOfOnesInPopulation{
    __block int sum = 0;
    
    [population enumerateObjectsUsingBlock:^(Birey * string, NSUInteger idx, BOOL *stop) {
        
        NSLog(@"str: %@  - %d \n",string,  [self countOnesInBirey:string]);
        sum += [self countOnesInBirey:string];
    }];
    
    return sum;
}

- (int)countOnesInBirey:(Birey*)birey{
    int sum = 0;
    
    for (int i = 0; i<birey.geneticCode.length; i++) {
        
        if ([birey.geneticCode characterAtIndex:i] == '1') {
            
            sum++;
            
        }
        
    }
    
    return sum;
}
@end
