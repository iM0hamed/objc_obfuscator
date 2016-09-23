//
//  scrambler.m
//  hasher
//
//  Created by Siebler, Tiago on 23/09/2016.
//  Copyright © 2016 Siebler, Tiago. All rights reserved.
//

#import "scrambler.h"
#import <objc/runtime.h>
NSString *path = nil;
bool startedWriting = 0;

void prepPath(){
    //hardcode location to save this symbols file
    path = @"/Users/self/Documents/Personal/DEV/macOS/Tools/hasher/symbols.h";
}
void prepFile(){
    //if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
    fprintf(stderr,"Creating file at %s",[path UTF8String]);
    //[[NSData data] writeToFile:path atomically:YES];
    [[NSFileManager defaultManager] createFileAtPath:path contents:[NSData data] attributes:nil];

    [[NSFileManager defaultManager] setAttributes:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0777]
                                                                              forKey:NSFilePosixPermissions]
                                     ofItemAtPath:path
                                            error:nil];
}
void writeToFile(NSString *msg){
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:path];
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    [handle writeData:[msg dataUsingEncoding:NSUTF8StringEncoding]];
    [handle closeFile];
    handle = nil;
}

NSString* getTimeStamp(){
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    return [dateFormatter stringFromDate:[NSDate date]];
}

void writeStr(NSString* format, ...){
    if(!startedWriting){
        prepPath();
        prepFile();
        startedWriting = 1;
        
        writeToFile(@"#ifndef symbols_h\n");
        writeToFile(@"#define symbols_h\n\n");
    }
    va_list args;
    va_start(args, format);
    format = [format stringByAppendingString:@"\n"];
    
    NSString *message = [[NSString alloc] initWithFormat:format
                                               arguments:args];
    va_end(args);
    
    writeToFile(message);
}
void endWriting(){
    NSString *postFix = @"\n#endif /* symbols_h */";
    writeToFile(postFix);
}
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
    
    writeStr(@"//---- Found %d methods on '%s'", methodCount, class_getName(clz));
    
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        
        NSString *unfilteredString = [NSString stringWithCString:sel_getName(method_getName(method)) encoding:NSUTF8StringEncoding];
        
        NSArray *subStrs = [unfilteredString componentsSeparatedByString:@":"];
        
        //accounts for multiple names in method
        for(NSString* str in subStrs){
            //NSLog(@"str: %@",str);
            if(str.length)
                writeStr(@"#define %s %s",[str UTF8String],randomStringWithLength(12));
        }
    }
    free(methods);
    
    writeStr(@"");
}
void DumpObjIvars(Class clz){
    unsigned int ivarCount = 0;
    Ivar* ivars = class_copyIvarList(clz, &ivarCount);
    writeStr(@"//---- Found %d ivars on '%s'", ivarCount, class_getName(clz));
    
    for (unsigned int i = 0; i < ivarCount; i++) {
        
        NSString *unfilteredString = [NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSUTF8StringEncoding];
        NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
        NSString *resultString = [[unfilteredString componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
        
        
        writeStr(@"#define %s %s",
               [resultString UTF8String],
               randomStringWithLength(12));
    }
    free(ivars);
    
    writeStr(@"");
}

void genObfuscatedStrings(){
    writeStr(@"#define a %s",randomStringWithLength(12));
    writeStr(@"#define b %s",randomStringWithLength(12));
    writeStr(@"#define c %s",randomStringWithLength(12));
    writeStr(@"#define d %s",randomStringWithLength(12));
    writeStr(@"#define e %s",randomStringWithLength(12));
    writeStr(@"#define f %s",randomStringWithLength(12));
    writeStr(@"#define g %s",randomStringWithLength(12));
    writeStr(@"#define h %s",randomStringWithLength(12));
    writeStr(@"#define i %s",randomStringWithLength(12));
    writeStr(@"#define j %s",randomStringWithLength(12));
    writeStr(@"#define k %s",randomStringWithLength(12));
    writeStr(@"#define l %s",randomStringWithLength(12));
    writeStr(@"#define m %s",randomStringWithLength(12));
    writeStr(@"#define n %s",randomStringWithLength(12));
    writeStr(@"#define o %s",randomStringWithLength(12));
    writeStr(@"#define p %s",randomStringWithLength(12));
    writeStr(@"#define q %s",randomStringWithLength(12));
    writeStr(@"#define r %s",randomStringWithLength(12));
    writeStr(@"#define s %s",randomStringWithLength(12));
    writeStr(@"#define t %s",randomStringWithLength(12));
    writeStr(@"#define u %s",randomStringWithLength(12));
    writeStr(@"#define v %s",randomStringWithLength(12));
    writeStr(@"#define w %s",randomStringWithLength(12));
    writeStr(@"#define x %s",randomStringWithLength(12));
    writeStr(@"#define y %s",randomStringWithLength(12));
    writeStr(@"#define z %s",randomStringWithLength(12));
    
    writeStr(@"#define A %s",randomStringWithLength(12));
    writeStr(@"#define B %s",randomStringWithLength(12));
    writeStr(@"#define C %s",randomStringWithLength(12));
    writeStr(@"#define D %s",randomStringWithLength(12));
    writeStr(@"#define E %s",randomStringWithLength(12));
    writeStr(@"#define F %s",randomStringWithLength(12));
    writeStr(@"#define G %s",randomStringWithLength(12));
    writeStr(@"#define H %s",randomStringWithLength(12));
    
    writeStr(@"#define _I %s",randomStringWithLength(12));
    writeStr(@"#define J %s",randomStringWithLength(12));
    writeStr(@"#define K %s",randomStringWithLength(12));
    writeStr(@"#define L %s",randomStringWithLength(12));
    writeStr(@"#define M %s",randomStringWithLength(12));
    writeStr(@"#define N %s",randomStringWithLength(12));
    writeStr(@"#define O %s",randomStringWithLength(12));
    writeStr(@"#define P %s",randomStringWithLength(12));
    writeStr(@"#define Q %s",randomStringWithLength(12));
    writeStr(@"#define R %s",randomStringWithLength(12));
    writeStr(@"#define S %s",randomStringWithLength(12));
    writeStr(@"#define T %s",randomStringWithLength(12));
    writeStr(@"#define U %s",randomStringWithLength(12));
    writeStr(@"#define V %s",randomStringWithLength(12));
    writeStr(@"#define W %s",randomStringWithLength(12));
    writeStr(@"#define X %s",randomStringWithLength(12));
    writeStr(@"#define Y %s",randomStringWithLength(12));
    writeStr(@"#define Z %s",randomStringWithLength(12));
    
    writeStr(@"#define _1 %s",randomStringWithLength(12));
    writeStr(@"#define _2 %s",randomStringWithLength(12));
    writeStr(@"#define _3 %s",randomStringWithLength(12));
    writeStr(@"#define _4 %s",randomStringWithLength(12));
    writeStr(@"#define _5 %s",randomStringWithLength(12));
    writeStr(@"#define _6 %s",randomStringWithLength(12));
    writeStr(@"#define _7 %s",randomStringWithLength(12));
    writeStr(@"#define _8 %s",randomStringWithLength(12));
    writeStr(@"#define _9 %s",randomStringWithLength(12));
    writeStr(@"#define _0 %s",randomStringWithLength(12));
    
    writeStr(@"#define space         %s",randomStringWithLength(12));
    writeStr(@"#define point         %s",randomStringWithLength(12));
    writeStr(@"#define dash          %s",randomStringWithLength(12));
    writeStr(@"#define comma         %s",randomStringWithLength(12));
    writeStr(@"#define semicolon     %s",randomStringWithLength(12));
    writeStr(@"#define colon         %s",randomStringWithLength(12));
    writeStr(@"#define apostrophe    %s",randomStringWithLength(12));
    writeStr(@"#define quotation     %s",randomStringWithLength(12));
    writeStr(@"#define plus          %s",randomStringWithLength(12));
    writeStr(@"#define equals        %s",randomStringWithLength(12));
    writeStr(@"#define paren_left    %s",randomStringWithLength(12));
    writeStr(@"#define paren_right   %s",randomStringWithLength(12));
    writeStr(@"#define asterisk      %s",randomStringWithLength(12));
    writeStr(@"#define ampersand     %s",randomStringWithLength(12));
    writeStr(@"#define caret         %s",randomStringWithLength(12));
    writeStr(@"#define percent       %s",randomStringWithLength(12));
    writeStr(@"#define $             %s",randomStringWithLength(12));
    writeStr(@"#define pound         %s",randomStringWithLength(12));
    writeStr(@"#define at            %s",randomStringWithLength(12));
    writeStr(@"#define exclamation   %s",randomStringWithLength(12));
    writeStr(@"#define question_mark %s",randomStringWithLength(12));
    writeStr(@"#define back_slash    %s",randomStringWithLength(12));
    writeStr(@"#define forward_slash %s",randomStringWithLength(12));
    writeStr(@"#define curly_left    %s",randomStringWithLength(12));
    writeStr(@"#define curly_right   %s",randomStringWithLength(12));
    writeStr(@"#define bracket_left  %s",randomStringWithLength(12));
    writeStr(@"#define bracket_right %s",randomStringWithLength(12));
    writeStr(@"#define bar           %s",randomStringWithLength(12));
    writeStr(@"#define less_than     %s",randomStringWithLength(12));
    writeStr(@"#define greater_than  %s",randomStringWithLength(12));
    writeStr(@"#define underscore    %s",randomStringWithLength(12));
    writeStr(@"#define tilde         %s",randomStringWithLength(12));

}

void extractNSVarsFromFile(NSString* file){
    //extracts all variable names that match the starting regex NSxxxxxx *varname
    NSError* error = nil;
    NSString *string = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error];
    
    NSString *pattern = @"(?m)^[ ]*NS\\w+\\s*\\*\\s*(\\w+)";
    NSRange range = NSMakeRange(0, string.length);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    NSArray *matches = [regex matchesInString:string options:0 range:range];
    writeStr(@"//-----NS* matches: %lu",(unsigned long)matches.count);
    
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match rangeAtIndex:1];
        writeStr(@"#define %s %s", [[string substringWithRange:matchRange] UTF8String],randomStringWithLength(12));
    }
}

void scrambleAll(Class clz){
    writeStr(@"#define %s %s",
           class_getName(clz),
           randomStringWithLength(12));
    
    DumpObjcMethods(clz);
    DumpObjcMethods(object_getClass(clz));
    
    DumpObjIvars(clz);
    DumpObjIvars(object_getClass(clz));
    
    //NSString *path = @"/Users/tsiebler/Documents/Personal/DEV/macOS/Tools/hasher/hasher/AppDelegate.m";
    //extractNSVarsFromFile(path);
}
