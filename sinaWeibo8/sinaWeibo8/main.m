//
//  main.m
//  sinaWeibo8
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}


/*
 程序的启动过程  首先会执行main函数 在执行UIApplicationMain 
 UIApplicationMain：1 创建一个UIApplication对象
                    2 创建一个AppDelegate对象并指定为UIApplication的代理
                    3 开启一个主运行循环，加载infoPlist
                    4 判断有没有指定Main.storyboard 如果有 就从Main.storyboard进行加载，Main.storyboard先会创建一个窗口，在创建一个箭头指向的控制器并成为窗口的根控制器，最后在吧窗口显示出来
 
 
 内存管理：使用alloc、copy、retain创建的对象 都需要release，一般系统自带的类方法，就不需要我管理，系统会自动管理 
 
 控制器之间的传值： 代理 
    代理：什么时候使用代理？ 传值、封装控件的时候会经常使用到代理，为了程序的扩展性（苹果就是这么干的）
 
    什么时候用block：一般开发中block经常是用来传值的。AFN也是用block，一般网络请求是异步请求，并不会马上返回数据，也就表示一个方法不可能直接返回数据，必须通过block回调，因为block是用来保存一段代码，可以先把请求成功的代码保存在block里面 等请求成功的时候直接调用block，
    block 使用注意点：block要想保存到模型里面，在MRC中一般使用copy，因为在MRC中只有copy才会把block放在堆内存中，栈内存只要方法一过就会被销毁，堆内存根据对象在，它就在。在ARC中可以使用strong,copy目的都是把block放在堆内存中
 
    通知： 一般也是可以传值的，但是更多的时候是通知其他的对象做事情
    什么时候使用通知？一般两个没有关系的对象要进行交流的时候就使用通知。
    使用通知注意点： 使用通知一定要记得移除通知
 
    事件处理：事件是怎么传递的？-> 事件的产生 会交给事件循环，也就是会放在UIApplication事件队列中，为什么要用队列，先进先出，先产生事件就先处理。事件的传递是 首先事件会交给UIApplication，UIApplication传递给窗口，在传递给根控制器的view 在传递给子控件
    响应者链：先判断当前的view是不是控制器的view 如果不是上一级响应者就是它的父控件，就会将事件抛给它的父控件 知道找到控制器的view来处理事件  如果控制器的view不能处理 就会去传给窗口，在传给UIApplication
 
    网络和多线程：网络通讯协议 tcp udp http
    AFN和SDwebImage 底层实现原理
    静态库：把自己的核心代码打包成为静态库
 
    MVVM：解决什么问题？解决比较复杂的界面，而且界面中的 控件尺寸是由模型数据确定
            作用：存储 模型 和 所有控件的frame 以后只要给控件传递一个视图模型，视图就知道展示什么样的数据，而且还知道展示在哪个位置
            好处：如果一个控件循环利用，可以避免重复计算控件的尺寸
 
 
 
 
 */