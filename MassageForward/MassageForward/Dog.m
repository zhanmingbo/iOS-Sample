//
//  Dog.m
//  MassageForward
//
//  Created by 詹明波 on 2018/3/5.
//  Copyright © 2018年 Hoolang. All rights reserved.
//

#import "Dog.h"
#import <objc/runtime.h>
#import "Pig.h"

@implementation Dog

void eatSomthing(id self, SEL sel)
{
    NSLog(@"%@ %s 【eat something】", self, sel_getName(sel));
}

// 决定选择哪个实例方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"%s %@",__func__,NSStringFromSelector(sel));

//    动态添加一个方法，如果不添加跳到Step 2
//        if(sel == @selector(eat))
//        {
//            // 添加一个代替eat实现的方法
//            class_addMethod(self, sel, (IMP)eatSomthing, "v@:");
//            return YES;
//        }

    return [super resolveInstanceMethod:sel];
}



//当类方法不存在时调用 如： +eat()没有实现的话
+ (BOOL)resolveClassMethod:(SEL)sel
{
    NSLog(@"%s %s",__func__, sel_getName(sel));

    return [super resolveClassMethod:sel];
}


//=============================================Step 2=========================================================

-(id)forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"%s %@",__func__,NSStringFromSelector(aSelector));
    
    //转发给Pig的实例，调用pig的eat方法，如果不转发则跳到Step 3
    //    return [Pig new];
    
    return [super forwardingTargetForSelector:aSelector];
}

//=============================================Step 3=========================================================
// 签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSLog(@"%s %@",__func__,NSStringFromSelector(aSelector));
    
    if(aSelector == @selector(eat))
    {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"%s",__func__);

    SEL selector = [anInvocation selector];
    Pig *pig = [Pig new];

    if([pig respondsToSelector:selector])
    {
        [anInvocation invokeWithTarget:pig];
    }
}

@end
