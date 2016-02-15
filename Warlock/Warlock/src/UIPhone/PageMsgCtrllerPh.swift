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

        let plistPath = NSBundle.mainBundle().pathForResource("team", ofType: "plist", inDirectory: "res")
        //获取属性列表文件中的全部数据
        _arTeam = NSArray(contentsOfFile: plistPath!)!

        let btn = UIButton(frame: CGRect(x: 50, y: 50, width: 50, height: 20))
        btn.addTarget(self, action: "v:", forControlEvents: .TouchUpInside)
        btn.backgroundColor = UIColor.redColor()
        view.addSubview(btn)

        //print(_arTeam)


        
    }

    func v(s: AnyObject) {
        UIView.animateWithDuration(3, delay: 3, options: [], animations: { _ in
            self._listView.frame.size = CGSize(
                width: self._listView.frame.width,
                height: self._listView.frame.height / 2
            )
        }, completion: nil)
    }


    override func getToolbarBtn() -> [UIBarButtonItem]? {
        return nil
    }

    //tableView协议---------------------------
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        print("press", indexPath.row)
    }
    

    //tableView数据源--------------------------
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("num")
        return 10
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "aa")
        cell.textLabel?.text = "yoyo" + String(indexPath.row)
        cell.contentView.backgroundColor = UIColor.yellowColor()
        print("height", cell.bounds.height, cell.contentView.bounds.height)

        tableView.beginUpdates()
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






