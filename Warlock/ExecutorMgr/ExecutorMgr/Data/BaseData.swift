//
//  BaseData.swift
//  fightGo
//
//  Created by 卢乐颜 on 15/12/22.
//  Copyright © 2015年 卢乐颜. All rights reserved.
//

import Foundation

//辨识所有结构体的标志，由服务器产生，可轻松从服务器中查找
public class DataID: Hashable {
    public let ID: Int //这个值用于在服务器快速查找该数据的位置

    public init(ID: Int) {
        self.ID = ID
    }

    public var hashValue: Int {
        return ID
    }
}

public func ==(lhs: DataID, rhs: DataID) -> Bool {
    return lhs.ID == rhs.ID
}

//对时间表示的封装
public struct Time {
    public let time: NSDate?

    //以当前时间初始化
    public init() {
        self.time = nil
    }
}

//所有数据类的核心
public class DataCore {
    public let ID: DataID //本结构体的id
    init(ID: DataID) {
        self.ID = ID
    }
}

//基本数据
public class BaseData: DataCore {
    public let saverID: DataID //变化记录器的id
    public let createTime: Time //创建时间

    init(ID: DataID, saverID: DataID, createTime: Time) {
        self.saverID = saverID
        self.createTime = createTime
        super.init(ID: ID)
    }
}




