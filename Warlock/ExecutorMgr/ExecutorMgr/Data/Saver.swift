//
//  Saver.swift
//  ExecutorMgr
//
//  Created by 卢乐颜 on 16/1/16.
//  Copyright © 2016年 卢乐颜. All rights reserved.
//

import Foundation

//谁 在什么时候 把什么值 从什么 变成什么 备注
//由于这个是在服务器数据变化时生成，这里只需要记录就好
public class SaverStruct {
    public let executor: DataID
    public let createTime: Time
    public let strValue: String = ""
    public let strFrom: String = ""
    public let strTo: String = ""
    public let strComment: String = ""
    init (executor: DataID, createTime: Time) {
        self.executor = executor
        self.createTime = createTime
    }
}

public class Saver: DataCore {
    public var arSaverStruct: [SaverStruct] = []
}
