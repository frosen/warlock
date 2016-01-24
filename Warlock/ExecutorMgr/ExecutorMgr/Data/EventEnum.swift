//
//  EventEnum.swift
//  ExecutorMgr
//  事件的枚举类型
//  Created by 卢乐颜 on 16/1/10.
//  Copyright © 2016年 卢乐颜. All rights reserved.
//

import Foundation

//交流状态
public enum CEventState {
    case Sent //发送中，接收者还没处理 撤回；接受，反馈
    case Received //接收者接受了事件
    case Done //接受后并完成的事件 一个人done则全部receive变成done 无
    case PartlyDone //部分完成，用于有子需求的需求（或改进，bug）一人Pd则全部r变成Pd
    case Feedback //不接收的反馈
    case Resent //重新发送 同sent
    case Closed //关闭未被接受的 无
}

//迭代状态
public enum IterativeType {
    case Debug
    case RC
    case Release
}




