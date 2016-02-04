//
//  Executor.swift
//  fightGo
//
//  Created by 卢乐颜 on 15/12/22.
//  Copyright © 2015年 卢乐颜. All rights reserved.
//

import Foundation

class ExecutorToken {
    var strEmail: String = ""
    var nPhone: Int = 0
    var strToken: String = ""
}

class ExecutorInfo {
    var strName: String = "Peter"
    var strSign: String = ""
}

class LevelInfo {
    var nExp: Int = 0
}

class RelatedData {
    var arMEventID: [DataID] = [DataID]() //管理事件组，也就是根事件

    var arCEventSendID: [DataID] = [DataID]()
    var arCEventReceiveID: [DataID] = [DataID]()
}

class Executor: BaseData {
    var token: ExecutorToken
    var info: ExecutorInfo
    var level: LevelInfo
    var related: RelatedData

    init(ID: DataID, saverID: DataID, createTime: Time, token: ExecutorToken, info: ExecutorInfo, level: LevelInfo, related: RelatedData) {
        self.token = token
        self.info = info
        self.level = level
        self.related = related

        super.init(ID: ID, saverID: saverID, createTime: createTime)
    }
}






