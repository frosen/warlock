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
    case Proposal //需求建议
    case Notice //通知
    case Assistance //协助
    case None //无类型，只用于判断
    case All //所有类型，只用于判断
}

//交流状态
public enum CEventState {
    case Sent //发送中，接收者还没处理
    case Received //接收者接受了事件
    case Done //接受后并完成的事件
    case PartlyDone //部分完成，用于有子需求的需求（或改进，bug）
    case Feedback(String) //不接收的反馈，并附上理由
    case Resent //重新发送
    case Closed //关闭未被接受的
}

public protocol Event: DataBase {
    static var type: EventType { get }
    static var arParentEventType: [EventType] { get }

    var creater: Executor { get } //事件创造者

    var parentEvent: Event? { set get } //父事件 可无
    var arChildEvent: [Event] { set get } //子事件组 有默认空

    var strDesc: String { set get } //事件的基本描述
}

//管理事件，用于人员管理
public protocol MEvent: Event {
    static var arDefaultTag: [Tag] { get } //默认设定，便于使用

    var strName: String { set get } //每个管理事件（团队，产品）都会有名字
    var arExecutorData: [ExecutorAuth] { set get } //必须有创建者自己
}

//交流事件，可以发送给别人
protocol CEvent: Event {
    static var arFeedbackStr: [String] { get } //反馈文本

    var state: CEventState {set get} //状态 有默认
    var arGetter: [Executor] { set get } //获得者组，被发送的人
    var nMaxReceiverNum: Int { set get } //最大接收者数量 如果小于等于0等于全部被发送者 默认为0
    var arReceiver: [Executor] { set get } //接收者组，被发送后接受的人 //有默认空
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
    public var arChildEvent: [Event] = [Event]() //有默认空
    public var strDesc: String = "" //有默认空

    public static let arDefaultTag: [Tag] = [
        Tag(str: "")
    ]
    public var strName: String
    public var arExecutorData: [ExecutorAuth]

    public init(ID: DataID, saverID: DataID, createTime: TimeData, creater: Executor, parentEvent: Event?, strName: String) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.creater = creater
        self.parentEvent = parentEvent

        self.strName = strName
        self.arExecutorData = [ExecutorAuth(executor: creater)]
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
    public var arChildEvent: [Event] = [Event]() //有默认空
    public var strDesc: String = "" //有默认空

    public static let arDefaultTag: [Tag] = [
        Tag(str: "")
    ]
    public var strName: String
    public var arExecutorData: [ExecutorAuth]

    public init(ID: DataID, saverID: DataID, createTime: TimeData, creater: Executor, parentEvent: Event?, strName: String) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.creater = creater
        self.parentEvent = parentEvent

        self.strName = strName
        self.arExecutorData = [ExecutorAuth(executor: creater)]
    }
}

//邀请
public class Invite: CEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .Invite
    public static let arParentEventType = [EventType.Team, .Product]

    public let creater: Executor
    public var parentEvent: Event?
    public var arChildEvent: [Event] = [Event]() //有默认空
    public var strDesc: String

    public static let arFeedbackStr: [String] = [
        NSLocalizedString("feedback_refuse", comment: "拒绝"),
    ]
    public var state: CEventState = .Sent //有默认
    public var arGetter: [Executor]
    public var nMaxReceiverNum: Int = 0 //有默认
    public var arReceiver: [Executor] = [Executor]() //有默认空

    //自有
    public var arAddTag: [Tag] = [Tag]() //要给与的标签 有默认空
    public var arAddAuth: AuthList = AuthList() //要给与的权限 有默认空

    public init(ID: DataID, saverID: DataID, createTime: TimeData, creater: Executor, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.creater = creater
        self.parentEvent = parentEvent
        self.strDesc = strDesc

        self.arGetter = arGetter
    }
}

//新需求：新任务，新内容
public class NewDemand: CEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .NewDemand
    public static let arParentEventType = [EventType.Product, .NewDemand, .Improvement, .Bug]

    public let creater: Executor
    public var parentEvent: Event?
    public var arChildEvent: [Event] = [Event]() //有默认空
    public var strDesc: String

    public static let arFeedbackStr: [String] = [
        NSLocalizedString("feedback_refuse", comment: "拒绝"),
    ]

    public var state: CEventState = .Sent //有默认
    public var arGetter: [Executor]
    public var nMaxReceiverNum: Int = 0 //有默认
    public var arReceiver: [Executor] = [Executor]() //有默认空

    //自有

    public init(ID: DataID, saverID: DataID, createTime: TimeData, creater: Executor, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.creater = creater
        self.parentEvent = parentEvent

        self.strDesc = strDesc
        self.arGetter = arGetter
    }
}

//改进
public class Improvement: CEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .Improvement
    public static let arParentEventType = [EventType.Product, .NewDemand, .Improvement, .Bug]

    public let creater: Executor
    public var parentEvent: Event?
    public var arChildEvent: [Event] = [Event]() //有默认空
    public var strDesc: String

    public static let arFeedbackStr: [String] = [
        NSLocalizedString("feedback_refuse", comment: "拒绝"),
    ]

    public var state: CEventState = .Sent //有默认
    public var arGetter: [Executor]
    public var nMaxReceiverNum: Int = 0 //有默认
    public var arReceiver: [Executor] = [Executor]() //有默认空

    //自有

    public init(ID: DataID, saverID: DataID, createTime: TimeData, creater: Executor, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.creater = creater
        self.parentEvent = parentEvent

        self.strDesc = strDesc
        self.arGetter = arGetter
    }
}

//迭代
public class Iterative: CEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .Iterative
    public static let arParentEventType = [EventType.Product]

    public let creater: Executor
    public var parentEvent: Event?
    public var arChildEvent: [Event] = [Event]() //有默认空
    public var strDesc: String

    public static let arFeedbackStr: [String] = [
        NSLocalizedString("feedback_refuse", comment: "拒绝"),
    ]

    public var state: CEventState = .Sent //有默认
    public var arGetter: [Executor]
    public var nMaxReceiverNum: Int = 0 //有默认
    public var arReceiver: [Executor] = [Executor]() //有默认空

    //自有

    public init(ID: DataID, saverID: DataID, createTime: TimeData, creater: Executor, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.creater = creater
        self.parentEvent = parentEvent

        self.strDesc = strDesc
        self.arGetter = arGetter
    }
}

//疑问
public class Query: CEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .Query
    public static let arParentEventType = [EventType.All]

    public let creater: Executor
    public var parentEvent: Event?
    public var arChildEvent: [Event] = [Event]() //有默认空
    public var strDesc: String

    public static let arFeedbackStr: [String] = [
        NSLocalizedString("feedback_refuse", comment: "拒绝"),
    ]

    public var state: CEventState = .Sent //有默认
    public var arGetter: [Executor]
    public var nMaxReceiverNum: Int = 0 //有默认
    public var arReceiver: [Executor] = [Executor]() //有默认空

    //自有

    public init(ID: DataID, saverID: DataID, createTime: TimeData, creater: Executor, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.creater = creater
        self.parentEvent = parentEvent

        self.strDesc = strDesc
        self.arGetter = arGetter
    }
}

//讨论会
public class Discussion: CEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .Discussion
    public static let arParentEventType = [EventType.All]

    public let creater: Executor
    public var parentEvent: Event?
    public var arChildEvent: [Event] = [Event]() //有默认空
    public var strDesc: String

    public static let arFeedbackStr: [String] = [
        NSLocalizedString("feedback_refuse", comment: "拒绝"),
    ]

    public var state: CEventState = .Sent //有默认
    public var arGetter: [Executor]
    public var nMaxReceiverNum: Int = 0 //有默认
    public var arReceiver: [Executor] = [Executor]() //有默认空

    //自有

    public init(ID: DataID, saverID: DataID, createTime: TimeData, creater: Executor, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.creater = creater
        self.parentEvent = parentEvent

        self.strDesc = strDesc
        self.arGetter = arGetter
    }
}

//对于产品的建议
public class Proposal: CEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .Proposal
    public static let arParentEventType = [EventType.Product]

    public let creater: Executor
    public var parentEvent: Event?
    public var arChildEvent: [Event] = [Event]() //有默认空
    public var strDesc: String

    public static let arFeedbackStr: [String] = [
        NSLocalizedString("feedback_refuse", comment: "拒绝"),
    ]

    public var state: CEventState = .Sent //有默认
    public var arGetter: [Executor]
    public var nMaxReceiverNum: Int = 0 //有默认
    public var arReceiver: [Executor] = [Executor]() //有默认空

    //自有

    public init(ID: DataID, saverID: DataID, createTime: TimeData, creater: Executor, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.creater = creater
        self.parentEvent = parentEvent

        self.strDesc = strDesc
        self.arGetter = arGetter
    }
}

//通知
public class Notice: CEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .Notice
    public static let arParentEventType = [EventType.All]

    public let creater: Executor
    public var parentEvent: Event?
    public var arChildEvent: [Event] = [Event]() //有默认空
    public var strDesc: String

    public static let arFeedbackStr: [String] = []
    public var state: CEventState = .Sent //有默认
    public var arGetter: [Executor]
    public var nMaxReceiverNum: Int = 0 //有默认
    public var arReceiver: [Executor] = [Executor]() //有默认空

    //自有

    public init(ID: DataID, saverID: DataID, createTime: TimeData, creater: Executor, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.creater = creater
        self.parentEvent = parentEvent

        self.strDesc = strDesc
        self.arGetter = arGetter
    }
}














