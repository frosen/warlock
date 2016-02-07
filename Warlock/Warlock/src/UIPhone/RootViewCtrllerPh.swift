//
//  RootViewCtrllerPh.swift
//  Warlock
//  Ph 就是phone
//  Created by 卢乐颜 on 16/2/4.
//  Copyright © 2016年 卢乐颜. All rights reserved.
//

import UIKit

class RootViewCtrllerPh: UIViewController {

    //变量--------------------------------------------------------------
    var _mainView: UIView!
    var _pageView: UIScrollView!
    var _toolbar: UIToolbar! //工具条
    var _tabbar: UIToolbar! //下面的选择条

    //创建函数-----------------------------------------------------------
    override func loadView() {
        super.loadView()

        let winFrame = view.bounds
        print("root frame: ", winFrame.width, winFrame.height)

        //按照层级创建基本视图
        createMainView(winFrame)
        createToolbarInMainView(winFrame)
        // createPopView(winFrame)
        createTabbar(winFrame)
        createStautsbar(winFrame)

    }

    func createMainView(frame: CGRect) {
        _mainView = UIView(frame: CGRect(x: 0, y: 20, width: frame.width, height: frame.height - (20 + 49)))
        view.addSubview(_mainView)

        createPageViewInMainView(_mainView.bounds)
        createToolbarInMainView(_mainView.bounds)
    }

    func createPageViewInMainView(frame: CGRect) {
        _pageView = UIScrollView(frame: CGRect(x: 0, y: 44, width: frame.width, height: frame.height - 44)) //TODO：先不实现隐藏toolbar，所以不让toolbar遮挡住page
        _mainView.addSubview(_pageView)

        _pageView.backgroundColor = UIColor.orangeColor()
        _pageView.pagingEnabled = true
        _pageView.bounces = false

        let sSize = _pageView.bounds.size

        //4个页面
        _pageView.contentSize = CGSize(width: sSize.width * 4, height: sSize.height)

        let v1 = PageMsgCtrllerPh(rootCtrller: self)
        v1.view.frame = CGRect(x: 0, y: 0, width: sSize.width, height: sSize.height)
        _pageView.addSubview(v1.view)



    }

    func createToolbarInMainView(frame: CGRect) {
        _toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 44))
        _mainView.addSubview(_toolbar)

        _toolbar.backgroundColor = UIColor.blueColor()

        let item1 = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "add:")
        _toolbar.items = [item1]
    }

    func createTabbar(frame: CGRect) {
        _tabbar = UIToolbar(frame: CGRect(x: 0, y: frame.height - 49, width: frame.width, height: 49))
        view.addSubview(_tabbar)

        _tabbar.backgroundColor = UIColor.brownColor()

        let i1 = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "add:")
        let i2 = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "add:")
        let i3 = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "add:")
        let i4 = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "add:")
        let s = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)

        _tabbar.items = [s, i1, s, s, i2, s, s, i3, s, s, i4, s]
    }

    func createStautsbar(frame: CGRect) {
        let status = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 20))
        view.addSubview(status)

        status.backgroundColor = UIColor.redColor()
    }

    //回调函数-----------------------------------------------------------
    func add(s: AnyObject) {
        print("add")
    }

    //------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
