//
//  IEvent.swift
//  ExecutorMgr
//
//  Created by 卢乐颜 on 15/12/26.
//  Copyright © 2015年 卢乐颜. All rights reserved.
//

import Foundation

public enum EventType {
    case Team //团队
    case Product //产品
    case Invite //邀请
    case NewDemand //新功能、内容
    case Improvement //改进
    case Iterative //产品迭代
    case Bug //bug
    case Query //疑问
    case Discussion //讨论会
    case DemandProposal //需求建议
    case Notice //通知
    case Assistance //协助
}

//标签，可以对应某些权限
public class Tag {
    let strContent: String

    init(str: String) {
        self.strContent = str
    }
}

//执行者对应的权限和标签的数据
public class AuthData {
    let executor: Executor
    var arTag: [Tag]?

    init(executor: Executor) {
        self.executor = executor
    }
}

protocol Event: DataBase {
    var type: EventType { get }
    var strDesc: String { get } //事件类型描述

    var arParentEventType: [EventType] { get }
}

//管理事件，用于人员管理
protocol MEvent: Event {
    var arAuthData: [AuthData] { set get }
}

//交流事件，可以发送给别人
protocol CEvent: Event {
    var arAcceptStr: [String] { get } //接收文本
    var arFeedbackStr: [String] { get } //反馈文本
}

public class Team: MEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public let type: EventType = .Team
    public let strDesc: String = NSLocalizedString("TeamDesc", comment: "")

    public init(ID: DataID, saverID: DataID, createTime: TimeData) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime
    }
}

public class Product: MEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public let type: EventType = .Product

    public init(ID: DataID, saverID: DataID, createTime: TimeData) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime
    }
}




