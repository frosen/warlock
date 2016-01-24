//
//  IEvent.swift
//  ExecutorMgr
//
//  Created by 卢乐颜 on 15/12/26.
//  Copyright © 2015年 卢乐颜. All rights reserved.
//

import Foundation

public class Event: BaseData {
    public func getParentEventTypeArray() -> [BaseData.Type] {
        return []
    }

    public let createrID: DataID //事件创造者

    public var parentEventID: DataID? //父事件 可无
    public var arChildCEvent: [DataID] = [DataID]() //子交流事件组 有默认空

    public var strDesc: String //事件的基本描述

    init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String) {
        self.createrID = createrID
        self.parentEventID = parentEventID
        self.strDesc = strDesc
        super.init(ID: ID, saverID: saverID, createTime: createTime)
    }
}

//作为判断类型的类
public class None: BaseData {}

//管理事件，用于人员管理
public class MEvent: Event {
    public func getDefaultTagArray() -> [Tag] { //默认设定，便于使用
        return []
    }

    public var strName: String //每个管理事件（团队，产品）都会有名字

    public struct TagSaver {
        weak var tag: Tag?
        var num: Int = 0
    }
    public var arTagSaver: [TagSaver] = [TagSaver]() //记录所有拥有的tag
    public var arExecutorData: [ExecutorAuth] //必须有创建者自己

    public var arChildMEvent: [DataID] = [DataID]() //子管理事件组 管理事件不得为交流事件的子事件

    init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, strName: String) {
        self.strName = strName
        self.arExecutorData = [ExecutorAuth(executorID: createrID)]

        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc)
    }
}

//交流事件，可以发送给别人
public class CEvent: Event {

    public typealias RecState = (DataID, CEventState) //接收者以及接受状态
    public var arReceiverState: [RecState] = [RecState]()

    public var nMaxReceiverNum: Int = 0 //最大接收者数量 如果小于等于0等于全部被发送者 默认为0

    init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        for id in arGetter {
            self.arReceiverState.append((id, .Sent))
        }

        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc)
    }
}

//待处理的生产事件 to be solved
public class ToBeSolEvent: CEvent {
    //完成原因：迭代
    public var doneIterativeID: DataID?
}

//团队
public class Team: MEvent {
    public override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Team.self, None.self]
    }

    public override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, strName: String) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, strName: strName)
    }
}

//产品
public class Product: MEvent {
    public override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Team.self, Product.self, None.self]
    }

    public override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, strName: String) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, strName: strName)
    }
}

//邀请
public class Invite: CEvent {
    public override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Team.self, Product.self]
    }

    //自有
    public var arAddTag: [Tag] = [Tag]() //要给与的标签 有默认空
    public var arAddAuth: AuthList = AuthList() //要给与的权限 有默认空

    //完成原因：无，接受后直接完成

    public override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//新需求：新任务，新内容
public class NewDemand: ToBeSolEvent {
    public override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Product.self, ToBeSolEvent.self]
    }

    //自有
    //完成原因：在ToBeSolEvent

    public override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//改进
public class Improvement: ToBeSolEvent {
    public override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Product.self, ToBeSolEvent.self]
    }

    //自有
    //完成原因：在ToBeSolEvent

    public override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//迭代
public class Iterative: CEvent {
    public override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Product.self]
    }

    //自有
    public var iterativeType: IterativeType = .Debug //迭代类型

    //完成原因：下一次迭代
    public var doneNextIterativeID: DataID?

    public override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//bug
public class Bug: ToBeSolEvent {
    public override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Product.self, Bug.self]
    }

    //自有
    //完成原因：在ToBeSolEvent

    public override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//疑问
public class Query: CEvent {
    public override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Event.self]
    }

    //自有
    //完成原因：进行了反馈

    public override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//讨论会
public class Discussion: CEvent {
    public override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Event.self]
    }

    //自有
    //完成原因

    public override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//对于产品的建议
public class Proposal: CEvent {
    public override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Product.self]
    }

    //自有
    //完成原因：某个需求，改进或者bug
    public var doneToBeSolEventID: DataID?

    public override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//通知
public class Notice: CEvent {
    public override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Event.self]
    }

    //自有
    //完成原因：无，接受后直接完成

    public override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)

        let aa: [Int: Int] = [12: 3]
        print(aa.indexForKey(12))
    }
}

//提示 对于任何事件的修改，可以发送提示相关人员
//提示事件被执行后，会删除掉，因为可以通过saver查看修改
public class Prompt: CEvent {
    public override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Event.self]
    }

    //自有
    public var oneSaverStruct: SaverStruct

    public init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, getter: DataID, oneSaverStruct: SaverStruct) {
        self.oneSaverStruct = oneSaverStruct
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: "", arGetter: [getter])
    }
}














