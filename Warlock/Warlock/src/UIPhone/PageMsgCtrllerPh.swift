//
//  PageMsgCtrllerPh.swift
//  Warlock
//  消息页面
//  Created by 卢乐颜 on 16/2/6.
//  Copyright © 2016年 卢乐颜. All rights reserved.
//

import UIKit

class PageMsgCtrllerPh: BasePageCtrllerPh {


    override func initPage() {
        print("init page msg")
        clearView()
        view.backgroundColor = UIColor.brownColor()

        let tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)

        let plistPath = NSBundle.mainBundle().pathForResource("team", ofType: "plist", inDirectory: "res")
        //获取属性列表文件中的全部数据
        let listTeams: NSArray = NSArray(contentsOfFile: plistPath!)!

        listTeams.map{print($0)}
        
    }

    override func switchToolbarBtn() {

    }
}
//170.800.165.51
