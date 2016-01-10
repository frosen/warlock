//
//  EventEnum.swift
//  ExecutorMgr
//  事件的枚举类型
//  Created by 卢乐颜 on 16/1/10.
//  Copyright © 2016年 卢乐颜. All rights reserved.
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

//迭代状态
public enum IterativeType {
    case Debug
    case RC
    case Release
}




