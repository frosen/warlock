//
//  PageMsgCtrllerPh.swift
//  Warlock
//  消息页面
//  Created by 卢乐颜 on 16/2/6.
//  Copyright © 2016年 卢乐颜. All rights reserved.
//

import UIKit

class PageMsgCtrllerPh: BasePageCtrllerPh, UITableViewDelegate, UITableViewDataSource {
    var _listView: UITableView!
    var _arTeam : NSArray!

    //------------------------------------
    override func initPage() {
        print("init page msg")
        clearView()
        view.backgroundColor = UIColor.brownColor()

        _listView = UITableView(frame: view.bounds, style: .Plain)
        view.addSubview(_listView)

        _listView.delegate = self
        _listView.dataSource = self

        //设置列表的各种属性
        //_listView.separatorStyle = .None

        let plistPath = NSBundle.mainBundle().pathForResource("team", ofType: "plist", inDirectory: "res")
        //获取属性列表文件中的全部数据
        _arTeam = NSArray(contentsOfFile: plistPath!)!

//        self._listView.contentInset.bottom = 100
    }

    override func getToolbarBtns() -> [UIBarButtonItem]? {
        let btn = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "test1:")
        let btn2 = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "test2:")
        return [btn, btn2]
    }

    func test1(s: AnyObject) {
        print("teest 1")
        UIView.animateWithDuration(3, animations: {_ in
            print("yse")

            self._listView.contentOffset.y = -100
        })
        self._listView.contentInset.top = 100
    }

    func test2(s: AnyObject) {
        print("teest 2")
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }

    //tableView协议---------------------------
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        print("press", indexPath.row)
    }
    

    //tableView数据源--------------------------
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("num")
        return 30
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "aa")

        cell.textLabel?.text = "yoyo" + String(indexPath.row)
        cell.contentView.backgroundColor = UIColor.yellowColor()
//        print("height", indexPath.row, indexPath.section)

        return cell
    }

}

class MsgItem: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//170.800.165.51






