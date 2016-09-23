//
//  scrambler.m
//  hasher
//
//  Created by Siebler, Tiago on 23/09/2016.
//  Copyright © 2016 Siebler, Tiago. All rights reserved.
//

#import "scrambler.h"
#import <objc/runtime.h>

const char* randomStringWithLength(int len) {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return [randomString UTF8String];
}
void DumpObjcMethods(Class clz) {
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(clz, &methodCount);
    
    printf("//---- Found %d methods on '%s'\n", methodCount, class_getName(clz));
    
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        
        NSString *unfilteredString = [NSString stringWithCString:sel_getName(method_getName(method)) encoding:NSUTF8StringEncoding];
        
        NSArray *subStrs = [unfilteredString componentsSeparatedByString:@":"];
        
        //accounts for multiple names in method
        for(NSString* str in subStrs){
            //NSLog(@"str: %@",str);
            if(str.length)
                printf("\t#define %s %s\n",[str UTF8String],randomStringWithLength(12));
        }
    }
    free(methods);
    
    printf("\n");
}
void DumpObjIvars(Class clz){
    unsigned int ivarCount = 0;
    Ivar* ivars = class_copyIvarList(clz, &ivarCount);
    printf("//---- Found %d ivars on '%s'\n", ivarCount, class_getName(clz));
    
    for (unsigned int i = 0; i < ivarCount; i++) {
        
        NSString *unfilteredString = [NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSUTF8StringEncoding];
        NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
        NSString *resultString = [[unfilteredString componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
        
        
        printf("\t#define %s %s\n",
               [resultString UTF8String],
               randomStringWithLength(12));
    }
    free(ivars);
    
    printf("\n");
}

void genObfuscatedStrings(){
    printf("#define a %s\n",randomStringWithLength(12));
    printf("#define b %s\n",randomStringWithLength(12));
    printf("#define c %s\n",randomStringWithLength(12));
    printf("#define d %s\n",randomStringWithLength(12));
    printf("#define e %s\n",randomStringWithLength(12));
    printf("#define f %s\n",randomStringWithLength(12));
    printf("#define g %s\n",randomStringWithLength(12));
    printf("#define h %s\n",randomStringWithLength(12));
    printf("#define i %s\n",randomStringWithLength(12));
    printf("#define j %s\n",randomStringWithLength(12));
    printf("#define k %s\n",randomStringWithLength(12));
    printf("#define l %s\n",randomStringWithLength(12));
    printf("#define m %s\n",randomStringWithLength(12));
    printf("#define n %s\n",randomStringWithLength(12));
    printf("#define o %s\n",randomStringWithLength(12));
    printf("#define p %s\n",randomStringWithLength(12));
    printf("#define q %s\n",randomStringWithLength(12));
    printf("#define r %s\n",randomStringWithLength(12));
    printf("#define s %s\n",randomStringWithLength(12));
    printf("#define t %s\n",randomStringWithLength(12));
    printf("#define u %s\n",randomStringWithLength(12));
    printf("#define v %s\n",randomStringWithLength(12));
    printf("#define w %s\n",randomStringWithLength(12));
    printf("#define x %s\n",randomStringWithLength(12));
    printf("#define y %s\n",randomStringWithLength(12));
    printf("#define z %s\n",randomStringWithLength(12));
    
    printf("#define A %s\n",randomStringWithLength(12));
    printf("#define B %s\n",randomStringWithLength(12));
    printf("#define C %s\n",randomStringWithLength(12));
    printf("#define D %s\n",randomStringWithLength(12));
    printf("#define E %s\n",randomStringWithLength(12));
    printf("#define F %s\n",randomStringWithLength(12));
    printf("#define G %s\n",randomStringWithLength(12));
    printf("#define H %s\n",randomStringWithLength(12));
    
    printf("#define _I %s\n",randomStringWithLength(12));
    printf("#define J %s\n",randomStringWithLength(12));
    printf("#define K %s\n",randomStringWithLength(12));
    printf("#define L %s\n",randomStringWithLength(12));
    printf("#define M %s\n",randomStringWithLength(12));
    printf("#define N %s\n",randomStringWithLength(12));
    printf("#define O %s\n",randomStringWithLength(12));
    printf("#define P %s\n",randomStringWithLength(12));
    printf("#define Q %s\n",randomStringWithLength(12));
    printf("#define R %s\n",randomStringWithLength(12));
    printf("#define S %s\n",randomStringWithLength(12));
    printf("#define T %s\n",randomStringWithLength(12));
    printf("#define U %s\n",randomStringWithLength(12));
    printf("#define V %s\n",randomStringWithLength(12));
    printf("#define W %s\n",randomStringWithLength(12));
    printf("#define X %s\n",randomStringWithLength(12));
    printf("#define Y %s\n",randomStringWithLength(12));
    printf("#define Z %s\n",randomStringWithLength(12));
    
    printf("#define _1 %s\n",randomStringWithLength(12));
    printf("#define _2 %s\n",randomStringWithLength(12));
    printf("#define _3 %s\n",randomStringWithLength(12));
    printf("#define _4 %s\n",randomStringWithLength(12));
    printf("#define _5 %s\n",randomStringWithLength(12));
    printf("#define _6 %s\n",randomStringWithLength(12));
    printf("#define _7 %s\n",randomStringWithLength(12));
    printf("#define _8 %s\n",randomStringWithLength(12));
    printf("#define _9 %s\n",randomStringWithLength(12));
    printf("#define _0 %s\n",randomStringWithLength(12));
    
    printf("#define space         %s\n",randomStringWithLength(12));
    printf("#define point         %s\n",randomStringWithLength(12));
    printf("#define dash          %s\n",randomStringWithLength(12));
    printf("#define comma         %s\n",randomStringWithLength(12));
    printf("#define semicolon     %s\n",randomStringWithLength(12));
    printf("#define colon         %s\n",randomStringWithLength(12));
    printf("#define apostrophe    %s\n",randomStringWithLength(12));
    printf("#define quotation     %s\n",randomStringWithLength(12));
    printf("#define plus          %s\n",randomStringWithLength(12));
    printf("#define equals        %s\n",randomStringWithLength(12));
    printf("#define paren_left    %s\n",randomStringWithLength(12));
    printf("#define paren_right   %s\n",randomStringWithLength(12));
    printf("#define asterisk      %s\n",randomStringWithLength(12));
    printf("#define ampersand     %s\n",randomStringWithLength(12));
    printf("#define caret         %s\n",randomStringWithLength(12));
    printf("#define percent       %s\n",randomStringWithLength(12));
    printf("#define $             %s\n",randomStringWithLength(12));
    printf("#define pound         %s\n",randomStringWithLength(12));
    printf("#define at            %s\n",randomStringWithLength(12));
    printf("#define exclamation   %s\n",randomStringWithLength(12));
    printf("#define question_mark %s\n",randomStringWithLength(12));
    printf("#define back_slash    %s\n",randomStringWithLength(12));
    printf("#define forward_slash %s\n",randomStringWithLength(12));
    printf("#define curly_left    %s\n",randomStringWithLength(12));
    printf("#define curly_right   %s\n",randomStringWithLength(12));
    printf("#define bracket_left  %s\n",randomStringWithLength(12));
    printf("#define bracket_right %s\n",randomStringWithLength(12));
    printf("#define bar           %s\n",randomStringWithLength(12));
    printf("#define less_than     %s\n",randomStringWithLength(12));
    printf("#define greater_than  %s\n",randomStringWithLength(12));
    printf("#define underscore    %s\n",randomStringWithLength(12));
    printf("#define tilde         %s\n",randomStringWithLength(12));

}

void extractNSVarsFromFile(NSString* file){
    //extracts all variable names that match the starting regex NSxxxxxx *varname
    NSError* error = nil;
    NSString *string = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error];
    
    NSString *pattern = @"(?m)^[ \t]*NS\\w+\\s*\\*\\s*(\\w+)";
    NSRange range = NSMakeRange(0, string.length);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    NSArray *matches = [regex matchesInString:string options:0 range:range];
    printf("//-----NS* matches: %lu\n",(unsigned long)matches.count);
    
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match rangeAtIndex:1];
        printf("\t#define %s %s\n", [[string substringWithRange:matchRange] UTF8String],randomStringWithLength(12));
    }
}

void scrambleAll(Class clz){
    printf("#define %s %s\n",
           class_getName(clz),
           randomStringWithLength(12));
    
    DumpObjcMethods(clz);
    DumpObjcMethods(object_getClass(clz));
    
    DumpObjIvars(clz);
    DumpObjIvars(object_getClass(clz));
    
    NSString *path = @"/Users/self/Documents/Personal/DEV/macOS/Tools/hasher/hasher/AppDelegate.m";
    extractNSVarsFromFile(path);
}
