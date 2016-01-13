//
//  Executor.swift
//  fightGo
//
//  Created by 卢乐颜 on 15/12/22.
//  Copyright © 2015年 卢乐颜. All rights reserved.
//

import Foundation

public class ExecutorToken {
    public var strEmail: String = ""
    public var nPhone: Int = 0
    public var strToken: String = ""
}

public class ExecutorInfo {
    public var strName: String = "Peter"
    public var strSign: String = ""
}

public class LevelInfo {
    public var nExp: Int = 0
}

public class RelatedData {
    public var arMEventID: [DataID] = [DataID]() //管理事件组，也就是根事件

    public var arCEventSendID: [DataID] = [DataID]()
    public var arCEventReceiveID: [DataID] = [DataID]()
}

public class Executor: DataBase {
    public var token: ExecutorToken
    public var info: ExecutorInfo
    public var level: LevelInfo
    public var related: RelatedData

    public init(ID: DataID, saverID: DataID, createTime: TimeData, token: ExecutorToken, info: ExecutorInfo, level: LevelInfo, related: RelatedData) {
        self.token = token
        self.info = info
        self.level = level
        self.related = related

        super.init(ID: ID, saverID: saverID, createTime: createTime)
    }
}






