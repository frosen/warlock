//
//  IEvent.swift
//  ExecutorMgr
//
//  Created by 卢乐颜 on 15/12/26.
//  Copyright © 2015年 卢乐颜. All rights reserved.
//

import Foundation

public protocol Event: DataBase {
    static var type: EventType { get }
    static var arParentEventType: [EventType] { get }

    var createrID: DataID { get } //事件创造者

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

//待处理的生产事件 to be solved
protocol ToBeSolEvent: CEvent {

}

//团队
public class Team: MEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .Team
    public static let arParentEventType = [EventType.Team, .None]

    public var createrID: DataID
    public var parentEvent: Event?
    public var arChildEvent: [Event] = [Event]() //有默认空
    public var strDesc: String = "" //有默认空

    public static let arDefaultTag: [Tag] = [
        Tag(str: "")
    ]
    public var strName: String
    public var arExecutorData: [ExecutorAuth]

    public init(ID: DataID, saverID: DataID, createTime: TimeData, createrID: DataID, parentEvent: Event?, strName: String) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.createrID = createrID
        self.parentEvent = parentEvent

        self.strName = strName
        self.arExecutorData = [ExecutorAuth(executorID: createrID)]
    }
}

//产品
public class Product: MEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .Product
    public static let arParentEventType = [EventType.Team, .Product, .None]

    public var createrID: DataID
    public var parentEvent: Event?
    public var arChildEvent: [Event] = [Event]() //有默认空
    public var strDesc: String = "" //有默认空

    public static let arDefaultTag: [Tag] = [
        Tag(str: "")
    ]
    public var strName: String
    public var arExecutorData: [ExecutorAuth]

    public init(ID: DataID, saverID: DataID, createTime: TimeData, createrID: DataID, parentEvent: Event?, strName: String) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.createrID = createrID
        self.parentEvent = parentEvent

        self.strName = strName
        self.arExecutorData = [ExecutorAuth(executorID: createrID)]
    }
}

//邀请
public class Invite: CEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .Invite
    public static let arParentEventType = [EventType.Team, .Product]

    public var createrID: DataID
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

    //完成原因：无，接受后直接完成

    public init(ID: DataID, saverID: DataID, createTime: TimeData, createrID: DataID, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.createrID = createrID
        self.parentEvent = parentEvent
        self.strDesc = strDesc

        self.arGetter = arGetter
    }
}

//新需求：新任务，新内容
public class NewDemand: ToBeSolEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .NewDemand
    public static let arParentEventType = [EventType.Product, .NewDemand, .Improvement, .Bug]

    public var createrID: DataID
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
    //完成原因：迭代
    public var doneIterativeID: DataID?

    public init(ID: DataID, saverID: DataID, createTime: TimeData, createrID: DataID, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.createrID = createrID
        self.parentEvent = parentEvent

        self.strDesc = strDesc
        self.arGetter = arGetter
    }
}

//改进
public class Improvement: ToBeSolEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .Improvement
    public static let arParentEventType = [EventType.Product, .NewDemand, .Improvement, .Bug]

    public var createrID: DataID
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
    //完成原因：迭代
    public var doneIterativeID: DataID?

    public init(ID: DataID, saverID: DataID, createTime: TimeData, createrID: DataID, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.createrID = createrID
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

    public var createrID: DataID
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
    public var iterativeType: IterativeType = .Debug //迭代类型

    //完成原因：下一次迭代
    public var doneNextIterativeID: DataID?

    public init(ID: DataID, saverID: DataID, createTime: TimeData, createrID: DataID, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.createrID = createrID
        self.parentEvent = parentEvent

        self.strDesc = strDesc
        self.arGetter = arGetter
    }
}

//bug
public class Bug: ToBeSolEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public static let type: EventType = .Bug
    public static let arParentEventType = [EventType.Product, .Bug]

    public var createrID: DataID
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
    //完成原因：迭代
    public var doneIterativeID: DataID?

    public init(ID: DataID, saverID: DataID, createTime: TimeData, createrID: DataID, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.createrID = createrID
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

    public var createrID: DataID
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
    //完成原因：进行了反馈

    public init(ID: DataID, saverID: DataID, createTime: TimeData, createrID: DataID, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.createrID = createrID
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

    public let createrID: DataID
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
    //完成原因

    public init(ID: DataID, saverID: DataID, createTime: TimeData, createrID: DataID, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.createrID = createrID
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

    public let createrID: DataID
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
    //完成原因：某个需求，改进或者bug
    public var doneToBeSolEventID: DataID?

    public init(ID: DataID, saverID: DataID, createTime: TimeData, createrID: DataID, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.createrID = createrID
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

    public let createrID: DataID
    public var parentEvent: Event?
    public var arChildEvent: [Event] = [Event]() //有默认空
    public var strDesc: String

    public static let arFeedbackStr: [String] = []
    public var state: CEventState = .Sent //有默认
    public var arGetter: [Executor]
    public var nMaxReceiverNum: Int = 0 //有默认
    public var arReceiver: [Executor] = [Executor]() //有默认空

    //自有
    //完成原因：无，接受后直接完成

    public init(ID: DataID, saverID: DataID, createTime: TimeData, createrID: DataID, parentEvent: Event?, strDesc: String, arGetter: [Executor]) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime

        self.createrID = createrID
        self.parentEvent = parentEvent

        self.strDesc = strDesc
        self.arGetter = arGetter
    }
}














