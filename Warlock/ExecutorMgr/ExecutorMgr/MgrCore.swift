//
//  MgrCore.swift
//  ExecutorMgr
//  执行者管理器，单例
//  Created by 卢乐颜 on 15/12/26.
//  Copyright © 2015年 卢乐颜. All rights reserved.
//

import Foundation

public class ExecutorMgr {

    //管理事件，其相关的所有交流事件的结构，还有时间戳
    public class MEventStruct {
        var M: MEvent
        var arC: [CEvent] = [CEvent]()
        init(M: MEvent) {
            self.M = M
        }
    }

    //属性
    var executor: Executor?
    var eventList: [MEventStruct] = [] //事件列表
    var ID2Class: [DataID: DataCore] = [:]

    //生成单例
    public class var shared: ExecutorMgr {
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

    //登录

    //登出

    //找回密码

    //下载执行者信息========================================================

    //更新执行者信息

    //
}



