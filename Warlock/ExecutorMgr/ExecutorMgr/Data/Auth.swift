//
//  Auth.swift
//  ExecutorMgr
//  权限
//  Created by 卢乐颜 on 16/1/10.
//  Copyright © 2016年 卢乐颜. All rights reserved.
//

import Foundation

//各种权限
public enum Auth {
    case a
    case b
}

//权限列表 为列表中项目保持唯一而封装
public class AuthList {
    private var dicAuth: [Auth:Bool] = [Auth:Bool]()

    //增
    public func add(auth: Auth) {
        dicAuth[auth] = true
    }

    public func add(authList: AuthList) {
        for auth in authList.dicAuth {
            dicAuth[auth.0] = true
        }
    }

    //删 成功返回true
    public func remove(auth: Auth) ->Bool {
        let auth = dicAuth.removeValueForKey(auth)
        return (auth != nil)
    }

    //查
    public func at(auth: Auth) -> Bool {
        let auth = dicAuth[auth]
        return (auth != nil)
    }

    public func list() -> [Auth] {
        var list = [Auth]()
        for auth in dicAuth {
            list.append(auth.0)
        }
        return list
    }
}

//标签，可以对应某些权限 
//因为权限不可重复，所以使用字典
public class Tag {
    public let strContent: String
    public let authList: AuthList = AuthList()

    public init(str: String) {
        self.strContent = str
    }
}

//执行者对应的权限和标签的数据
//团队和产品有着不同的默认权限设定
public class ExecutorAuth {
    public let executorID: DataID
    public var arTag: [Tag] = [Tag]()
    public var authList: AuthList = AuthList()

    public init(executorID: DataID) {
        self.executorID = executorID
    }
}






