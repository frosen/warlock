//
//  Auth.swift
//  ExecutorMgr
//  权限
//  Created by 卢乐颜 on 16/1/10.
//  Copyright © 2016年 卢乐颜. All rights reserved.
//

import Foundation

//各种权限
enum Auth {
    case a
    case b
}

//权限列表 为列表中项目保持唯一而封装
class AuthList {
    private var dicAuth: [Auth:Bool] = [Auth:Bool]()

    //增
    func add(auth: Auth) {
        dicAuth[auth] = true
    }

    func add(authList: AuthList) {
        for auth in authList.dicAuth {
            dicAuth[auth.0] = true
        }
    }

    //删 成功返回true
    func remove(auth: Auth) ->Bool {
        let auth = dicAuth.removeValueForKey(auth)
        return (auth != nil)
    }

    //查
    func at(auth: Auth) -> Bool {
        let auth = dicAuth[auth]
        return (auth != nil)
    }

    func list() -> [Auth] {
        var list = [Auth]()
        for auth in dicAuth {
            list.append(auth.0)
        }
        return list
    }
}

//标签，可以对应某些权限 
//因为权限不可重复，所以使用字典
class Tag {
    let strContent: String
    let authList: AuthList = AuthList()

    init(str: String) {
        self.strContent = str
    }
}

//执行者对应的权限和标签的数据
//团队和产品有着不同的默认权限设定
class ExecutorAuth {
    let executorID: DataID
    var arTag: [Tag] = [Tag]()
    var authList: AuthList = AuthList()

    init(executorID: DataID) {
        self.executorID = executorID
    }
}






