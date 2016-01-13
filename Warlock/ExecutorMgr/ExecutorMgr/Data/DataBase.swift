//
//  DataBase.swift
//  fightGo
//
//  Created by 卢乐颜 on 15/12/22.
//  Copyright © 2015年 卢乐颜. All rights reserved.
//

import Foundation

//辨识所有结构体的标志，由服务器产生，可轻松从服务器中查找
public struct DataID {
    public let ID: Int

    public init(ID: Int) {
        self.ID = ID
    }
}

//对时间表示的封装
public struct TimeData {
    let time: NSDate

    //以当前时间初始化
}

//所有数据类的基类
public class DataBase {
    public let ID: DataID //本结构体的id
    public let saverID: DataID //变化记录器的id

    public let createTime: TimeData //创建时间

    init(ID: DataID, saverID: DataID, createTime: TimeData) {
        self.ID = ID
        self.saverID = saverID
        self.createTime = createTime
    }
}





