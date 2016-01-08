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
public protocol DataBase {
    var ID: DataID { get } //本结构体的id
    var saverID: DataID { get } //变化记录器的id

    var createTime: TimeData { get } //创建时间
}





