//
//  MySingleton.h
//  MyApp
//
//  Created by DengTianran on 16/10/31.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#ifndef MySingleton_h
#define MySingleton_h

#define MySingletonH(name) + (instancetype)shared##name;

#define MySingletonM(name)\
static id _instance;\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

#endif /* MySingleton_h */
