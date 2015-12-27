//
//  IEvent.swift
//  ExecutorMgr
//
//  Created by 卢乐颜 on 15/12/26.
//  Copyright © 2015年 卢乐颜. All rights reserved.
//

import Foundation

public enum IEventType {
    case CreateTeam //创建团队
    case CreateProduct //创建产品
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

protocol IEvent: DataBase {
    var type: IEventType { get }
    var strDesc: String { get } //事件类型描述

    var arAcceptStr: [String] { get }
    var arFeedbackStr: [String] { get }

    var arSubIEventType: [IEventType] { get }
}

public class CreateTeam: IEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public let type: IEventType = .CreateTeam

    public init(ID: DataID, saverID: DataID, createTime: TimeData) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime
    }
}

public class CreateProduct: IEvent {
    public let ID: DataID
    public let saverID: DataID
    public let createTime: TimeData

    public let type: IEventType = .CreateProduct

    public init(ID: DataID, saverID: DataID, createTime: TimeData) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime
    }
}




