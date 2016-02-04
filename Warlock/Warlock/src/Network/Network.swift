//
//  Network.swift
//  ExecutorMgr
//
//  Created by 卢乐颜 on 16/2/1.
//  Copyright © 2016年 卢乐颜. All rights reserved.
//

import Foundation

class Network {
    class func show() {
        print("it is net work")

        AVOSCloud.setApplicationId("QPW1yJeKPAorks0WcvN6p9eJ-gzGzoHsz", clientKey: "Ig7tiLhuj5CeXKzwE0DIeg4u")

        let a = AVObject(className: "haha")
        a.setObject("one", forKey: "two")
        a.save()
    }
}
