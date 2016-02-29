//
//  DataBase.swift
//  fightGo
//
//  Created by 卢乐颜 on 15/12/22.
//  Copyright © 2015年 卢乐颜. All rights reserved.
//

import Foundation

//辨识所有结构体的标志，由服务器产生，可轻松从服务器中查找
class DataID: Hashable {
    let ID: Int //这个值用于在服务器快速查找该数据的位置

    init(ID: Int) {
        self.ID = ID
    }

    var hashValue: Int {
        return ID
    }
}

func ==(lhs: DataID, rhs: DataID) -> Bool {
    return lhs.ID == rhs.ID
}

//对时间表示的封装
struct Time {
    let time: NSDate?

    //以当前时间初始化
    init() {
        self.time = nil
    }
}

//基本数据
class DataBase {
    let ID: DataID //本结构体的id
    init(ID: DataID) {
        self.ID = ID
    }
}




