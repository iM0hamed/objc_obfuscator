//
//  scrambler.h
//  hasher
//
//  Created by Siebler, Tiago on 23/09/2016.
//  Copyright © 2016 Siebler, Tiago. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void scrambleAll(Class clz);
extern void genObfuscatedStrings();
extern void extractNSVarsFromFile(NSString* file);

extern void prepPath();
extern void prepFile();
extern void writeStr(NSString* format, ...);
extern void endWriting();
