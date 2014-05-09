//
//  ViewController.m
//  ThreadExample
//
//  Created by Henry on 14-5-8.
//  Copyright (c) 2014年 Henry. All rights reserved.
//

#import "ViewController.h"
#import "Thread.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

/**
 *  Four different ways to use NSThread Method
 */
- (void)NSThreadMethod {
    //Method One 使用NSThread类方法+detachNewThreadSelector:toTarget:withObject:创建线程并执行
    [NSThread detachNewThreadSelector:@selector(myThreadMainMethod:) toTarget:self withObject:Nil];
    
    //Method Two 使用NSObject的线程扩展（NSThreadPerformAdditions）方法+performSelectorInBackground:withObject:创建并执行线程
    NSObject *obj = [[NSObject alloc] init];
    [obj performSelectorInBackground:@selector(myThreadMainMethod:) withObject:Nil];
    
    //Method Three 创建一个NSThread对象，然后调用start方法执行
    NSThread *aThread = [[NSThread alloc] initWithTarget:self selector:@selector(myThreadMainMethod:) object:nil];
    //配置NSThread参数
    //配置线程栈空间，
    [aThread setStackSize:100];
    
    [aThread start];
    
    //Method Four 创建一个NSThread子类，然后实例化调用start方法
    //#import "Thread.h"
    Thread *thread = [[Thread alloc] init];
    [thread start];
}

/**
 *  GCD (Grand Central Dispatch)
 */
- (void)GCDMethod {
    
    /**
     *  Dispatch Queue是执行处理的FIFO(先进先出)等待队列，按照执行处理的方式分为Serial Dispatch Queue和Concurrent Dispatch Queue
     *  Serial Dispatch Queue 只使用一个线程来执行处理，要等待现在执行中的处理结束才会执行下一个处理
     *  Concurrent Dispatch Queue 采用多个线程来执行处理，不等待现在执行中的处理结束
     */
    
    //Serial Dispatch Queue
    dispatch_get_main_queue();
    
    //Concurrent Dispatch Queue 有四个执行优先级，分别是高优先级（High Priority）、默认优先级（Default Priority）、低优先级（Low Priority）和后台优先级（Background Priority）
    dispatch_object_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    //dispatch_sync会阻塞当前函数调用的线程直到追加的Block执行完成
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        
    });
    
    //dispatch_async是异步的追加Block到指定的Dispatch Queue中，不会阻塞当前函数的线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    });
}

- (void)NSOperationMethod {
    //NSInvocationOperation
    
    //NSBlockOperation
}

- (void)NSRunloopMethod {
    /**
     *  由于主线程的NSRunloop默认自动运行，所以只有第二线程才需要我们自己运行NSRunloop
     *  并不是所有使用线程的情况都要运行NSRunloop，下面一些情况你需要运行NSRunloop:
     *  需要使用Port或者自定义Input Source与其他线程进行通讯
     *  需要在线程中使用Timer
     *  需要在线程上使用performSelectorInBackground方法
     *  需要让线程执行周期性的工作
     *  NSURLConnection在子线程中发起异步请求
     */
    
    
}

- (void)myThreadMainMethod:(id)obj {
    @autoreleasepool {
        /*  在线程的入口处我们需要创建一个Autorelease Pool，当线程退出的时候释放这个Autorelease Pool。
         *  这样在线程中创建的autorelease对象就可以在线程结束的时候释放，避免过多的延迟释放造成程序占用过多的内存。
         */
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
