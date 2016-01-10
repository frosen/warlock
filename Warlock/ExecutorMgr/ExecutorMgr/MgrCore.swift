//
//  MgrCore.swift
//  ExecutorMgr
//  执行者管理器，单例
//  Created by 卢乐颜 on 15/12/26.
//  Copyright © 2015年 卢乐颜. All rights reserved.
//

import Foundation

public class ExecutorMgr {
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


}



