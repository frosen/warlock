//
//  ExecutorMgr.swift
//  ExecutorMgr
//  执行者管理器，单例
//  Created by 卢乐颜 on 15/12/26.
//  Copyright © 2015年 卢乐颜. All rights reserved.
//

import Foundation

class ExecutorMgr {

    //管理事件，其相关的所有交流事件的结构，还有时间戳
    //管理事件可以为空，存在不属于某个管理事件的交流事件
    class MEventStruct {
        var M: MEvent?
        var arC: [CEvent] = [CEvent]()
        init(M: MEvent?) {
            self.M = M
        }
    }

    //属性
    var executor: Executor?
    var eventList: [MEventStruct] = [] //事件列表
    var ID2Class: [DataID: DataBase] = [:] //生成list的时候，把对应的dataID和Data的关系注册到这里

    //生成单例
    class var shared: ExecutorMgr {
        struct Static {
            static var ins: ExecutorMgr?
            static var token: dispatch_once_t = 0
        }

        dispatch_once(&Static.token) {
            Static.ins = ExecutorMgr()
        }

        return Static.ins!
    }

    //注册========================================================
    class func show() {
        print("yeyeye")
        Network.show()
    }

    //登录

    //登出

    //找回密码

    //下载执行者信息========================================================

    //更新执行者信息

    //
}



