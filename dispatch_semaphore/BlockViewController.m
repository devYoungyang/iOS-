//
//  BlockViewController.m
//  dispatch_semaphore
//
//  Created by Yang on 2018/10/17.
//  Copyright © 2018年 Yang. All rights reserved.
//
typedef void (^GlobalBlock)(void);
#import "BlockViewController.h"

@interface BlockViewController ()
@property (nonatomic,retain)GlobalBlock stackBlock;//在MRC模式下，存储在栈区
@property (nonatomic,copy)GlobalBlock heapBlock;//在MRC模式下，用strong或copy，存储在堆区
@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    如果一个block没有访问外界的任何变量或者对象，那么这个block就是一个全局block,但是访问了block自己本身，此时也不再是全局block。全局block既不存储于栈区也不存储于堆区。全局block访问了外界变量，会经历两个过程：全局block -> 栈block -> 堆block
    GlobalBlock __block block=^{
        NSLog(@"%@",block);
    };
    NSLog(@"拷贝前：%@",block);
    GlobalBlock copyBlock = [block copy];
    NSLog(@"拷贝后：%@",copyBlock);
//    MRC下，block属性使用不同的内存管理语义，会有不一样的效果。使用strong/copy，编译器会自动帮我们把block copy到堆内存上。使用retain.assign修饰的block属性依旧是栈block，此时如果有需要延长栈block的生命周期，开发者需要对其手动copy。
//    ARC下，编译器会判断是否有需要将Block从栈复制到堆，如果需要复制到堆上，编译器会自动生成将Block从栈复制到堆上的代码。Block的复制操作执行的是copy实例方法。Block只要调用了copy方法，栈block就会变成堆block。所以再ARC下，开发者不需要对block进行额外的copy操作，编译器会替我们做这些事情。
//    ARC下，只有当block属性使用assign修饰时，block才会是栈block，编译器无论如何都不会对其进行copy操作，因为编译器会认为这是开发者有意而为之，并不会多此一举的进行拷贝
//    不管ARC下我们使用strong/copy/retain中的哪个关键字修饰block属性，如果有需要，最终编译器都会进行优化，把block copy到堆内存上。
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
