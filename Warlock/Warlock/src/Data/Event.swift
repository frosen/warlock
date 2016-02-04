//
//  IEvent.swift
//  ExecutorMgr
//
//  Created by 卢乐颜 on 15/12/26.
//  Copyright © 2015年 卢乐颜. All rights reserved.
//

import Foundation

class Event: BaseData {
    func getParentEventTypeArray() -> [BaseData.Type] {
        return []
    }

    let createrID: DataID //事件创造者

    var parentEventID: DataID? //父事件 可无
    var arChildCEvent: [DataID] = [DataID]() //子交流事件组 有默认空

    var strDesc: String //事件的基本描述

    init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String) {
        self.createrID = createrID
        self.parentEventID = parentEventID
        self.strDesc = strDesc
        super.init(ID: ID, saverID: saverID, createTime: createTime)
    }
}

//作为判断类型的类
class None: BaseData {}

//管理事件，用于人员管理
class MEvent: Event {
    func getDefaultTagArray() -> [Tag] { //默认设定，便于使用
        return []
    }

    var strName: String //每个管理事件（团队，产品）都会有名字

    struct TagSaver {
        weak var tag: Tag?
        var num: Int = 0
    }
    var arTagSaver: [TagSaver] = [TagSaver]() //记录所有拥有的tag
    var arExecutorData: [ExecutorAuth] //必须有创建者自己

    var arChildMEvent: [DataID] = [DataID]() //子管理事件组 管理事件不得为交流事件的子事件

    init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, strName: String) {
        self.strName = strName
        self.arExecutorData = [ExecutorAuth(executorID: createrID)]

        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc)
    }
}

//交流事件，可以发送给别人
class CEvent: Event {

    typealias RecState = (DataID, CEventState) //接收者以及接受状态
    var arReceiverState: [RecState] = [RecState]()

    var nMaxReceiverNum: Int = 0 //最大接收者数量 如果小于等于0等于全部被发送者 默认为0

    init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        for id in arGetter {
            self.arReceiverState.append((id, .Sent))
        }

        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc)
    }
}

//待处理的生产事件 to be solved
class ToBeSolEvent: CEvent {
    //完成原因：迭代
    var doneIterativeID: DataID?
}

//团队
class Team: MEvent {
    override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Team.self, None.self]
    }

    override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, strName: String) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, strName: strName)
    }
}

//产品
class Product: MEvent {
    override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Team.self, Product.self, None.self]
    }

    override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, strName: String) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, strName: strName)
    }
}

//邀请
class Invite: CEvent {
    override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Team.self, Product.self]
    }

    //自有
    var arAddTag: [Tag] = [Tag]() //要给与的标签 有默认空
    var arAddAuth: AuthList = AuthList() //要给与的权限 有默认空

    //完成原因：无，接受后直接完成

    override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//新需求：新任务，新内容
class NewDemand: ToBeSolEvent {
    override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Product.self, ToBeSolEvent.self]
    }

    //自有
    //完成原因：在ToBeSolEvent

    override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//改进
class Improvement: ToBeSolEvent {
    override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Product.self, ToBeSolEvent.self]
    }

    //自有
    //完成原因：在ToBeSolEvent

    override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//迭代
class Iterative: CEvent {
    override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Product.self]
    }

    //自有
    var iterativeType: IterativeType = .Debug //迭代类型

    //完成原因：下一次迭代
    var doneNextIterativeID: DataID?

    override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//bug
class Bug: ToBeSolEvent {
    override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Product.self, Bug.self]
    }

    //自有
    //完成原因：在ToBeSolEvent

    override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//疑问
class Query: CEvent {
    override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Event.self]
    }

    //自有
    //完成原因：进行了反馈

    override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//讨论会
class Discussion: CEvent {
    override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Event.self]
    }

    //自有
    //完成原因

    override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//对于产品的建议
class Proposal: CEvent {
    override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Product.self]
    }

    //自有
    //完成原因：某个需求，改进或者bug
    var doneToBeSolEventID: DataID?

    override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)
    }
}

//通知
class Notice: CEvent {
    override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Event.self]
    }

    //自有
    //完成原因：无，接受后直接完成

    override init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, strDesc: String, arGetter: [DataID]) {
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: strDesc, arGetter: arGetter)

        let aa: [Int: Int] = [12: 3]
        print(aa.indexForKey(12))
    }
}

//提示 对于任何事件的修改，可以发送提示相关人员
//提示事件被执行后，会删除掉，因为可以通过saver查看修改
class Prompt: CEvent {
    override func getParentEventTypeArray() -> [BaseData.Type] {
        return [Event.self]
    }

    //自有
    var oneSaverStruct: SaverStruct

    init(ID: DataID, saverID: DataID, createTime: Time, createrID: DataID, parentEventID: DataID?, getter: DataID, oneSaverStruct: SaverStruct) {
        self.oneSaverStruct = oneSaverStruct
        super.init(ID: ID, saverID: saverID, createTime: createTime, createrID: createrID, parentEventID: parentEventID, strDesc: "", arGetter: [getter])
    }
}














