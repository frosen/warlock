//
//  PageMsgCtrllerPh.swift
//  Warlock
//  消息页面
//  Created by 卢乐颜 on 16/2/6.
//  Copyright © 2016年 卢乐颜. All rights reserved.
//

import UIKit

class PageMsgCtrllerPh: BasePageCtrllerPh {
    override func loadView() {
        super.loadView()
        
        let winFrame = view.bounds
        print("page frame: ", winFrame.width, winFrame.height)
    }
}
