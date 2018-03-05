//
//  main.m
//  MassageForward
//
//  Created by 詹明波 on 2018/3/5.
//  Copyright © 2018年 Hoolang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Dog *dog = [Dog new];
        [dog eat];
        // 类方法sleep没有实现
//        [Dog sleep];
        
    }
    return 0;
}
