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
    case None //无类型，只用于判断
}

//标签，可以对应某些权限
public class Tag {
    let strContent: String

    init(str: String) {
        self.strContent = str
    }
}

//执行者对应的权限和标签的数据
//团队和产品有着不同的默认权限设定
public class AuthData {
    let executor: Executor
    var arTag: [Tag]?

    init(executor: Executor) {
        self.executor = executor
    }
}

public protocol Event: DataBase {
    static var type: EventType { get }
    static var arParentEventType: [EventType] { get }

    var creater: Executor { get } //事件创造者

    var parentEvent: Event? { set get } //父事件 可无
    var arChildEvent: [Event] { set get } //子事件组 可空

    var strDesc: String { set get } //事件的基本描述 可空
}

//管理事件，用于人员管理
public protocol MEvent: Event {
    static var arDefaultTag: [Tag] { get } //默认设定，便于使用

    var strName: String { set get } //每个管理事件（团队，产品）都会有名字
    var arAuthData: [AuthData] { set get } //必须有创建者自己
}

//交流事件，可以发送给别人
protocol CEvent: Event {
    static var arAcceptStr: [String] { get } //接收文本
    static var arFeedbackStr: [String] { get } //反馈文本

    var arGetter: [Executor] { set get } //获得者组
    var nMaxReceiverNum: Int { set get } //最大接收者数量
    var arReceiver: [Executor] { set get } //接收者组
}

//团队
public class Team: MEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .Team
    public static let arParentEventType = [EventType.Team, .None]

    public let creater: Executor
    public var parentEvent: Event?
    public var arChildEvent: [Event] = [Event]() //可空
    public var strDesc: String = "" //可空

    public static let arDefaultTag: [Tag] = [
        Tag(str: "")
    ]
    public var strName: String
    public var arAuthData: [AuthData]

    public init(ID: DataID, saverID: DataID, createTime: TimeData, creater: Executor, parentEvent: Event?, strName: String) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.creater = creater
        self.parentEvent = parentEvent

        self.strName = strName
        self.arAuthData = [AuthData(executor: creater)]
    }
}

//产品
public class Product: MEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .Product
    public static let arParentEventType = [EventType.Team, .Product, .None]

    public let creater: Executor
    public var parentEvent: Event?
    public var arChildEvent: [Event] = [Event]() //可空
    public var strDesc: String = "" //可空

    public static let arDefaultTag: [Tag] = [
        Tag(str: "")
    ]
    public var strName: String
    public var arAuthData: [AuthData]

    public init(ID: DataID, saverID: DataID, createTime: TimeData, creater: Executor, parentEvent: Event?, strName: String) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.creater = creater
        self.parentEvent = parentEvent

        self.strName = strName
        self.arAuthData = [AuthData(executor: creater)]
    }
}




