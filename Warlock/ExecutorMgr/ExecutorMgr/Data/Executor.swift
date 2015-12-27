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
    public var arTeamID: [DataID] = [DataID]()

    public var arIEventHasID: [DataID] = [DataID]()
    public var arIEventSendID: [DataID] = [DataID]()
    public var arIEventReceiveID: [DataID] = [DataID]()
}

public class Executor: DataBase {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public var token: ExecutorToken
    public var info: ExecutorInfo
    public var level: LevelInfo
    public var related: RelatedData

    public init(ID: DataID, saverID: DataID, createTime: TimeData, token: ExecutorToken, info: ExecutorInfo, level: LevelInfo, related: RelatedData) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.token = token
        self.info = info
        self.level = level
        self.related = related
    }
}






