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

- (Individual *)crossOverBireyWithBirey:(Individual *)individual
                     withCrossOverPoint:(int)point{
    
    if (self.geneticCode.length != individual.geneticCode.length) return nil;
    if (point<0 || point>self.geneticCode.length) return nil;
    
    NSRange  range1 = NSMakeRange(0, point);
    NSRange  range2 = NSMakeRange(point, individual.geneticCode.length-point);
    
    NSString * locus1 = [self.geneticCode substringWithRange:range1];
    NSString * locus2 = [individual.geneticCode substringWithRange:range2];
    
    Individual * yeniBirey = [[Individual alloc] initWithGeneticCode:
                              [NSString stringWithFormat:@"%@%@",locus1,locus2]];
    
    return yeniBirey;
}
- (void)crossOverWithBirey:(Individual *)individual
        withCrossOverPoint:(int)point{
    
    if (self.geneticCode.length != individual.geneticCode.length) return ;
    if (point<0 || point>self.geneticCode.length) return ;
    
    NSRange  range1 = NSMakeRange(0, point);
    NSRange  range2 = NSMakeRange(point, individual.geneticCode.length-point);
    
    NSString * locus1 = [self.geneticCode substringWithRange:range1];
    NSString * locus2 = [individual.geneticCode substringWithRange:range2];
    
    self.geneticCode =[NSString stringWithFormat:@"%@%@",locus1,locus2];

}
- (NSString *)description
{
    return self.geneticCode;
}

- (void)mutate{
    
        int bit = arc4random() % self.geneticCode.length;
        NSRange range = NSMakeRange(bit,1);
        
        if ([[self.geneticCode substringWithRange:range] intValue]){
            self.geneticCode = [self.geneticCode   stringByReplacingOccurrencesOfString:@"1" withString:@"0" options:NSLiteralSearch range:range];
        }  else{
            self.geneticCode =  [self.geneticCode   stringByReplacingOccurrencesOfString:@"0" withString:@"1" options:NSLiteralSearch range:range];
        }
    
}
@end

