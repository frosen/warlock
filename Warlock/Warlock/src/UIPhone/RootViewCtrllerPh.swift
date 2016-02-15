//
//  RootViewCtrllerPh.swift
//  Warlock
//  Ph 就是phone
//  Created by 卢乐颜 on 16/2/4.
//  Copyright © 2016年 卢乐颜. All rights reserved.
//

import UIKit

class RootViewCtrllerPh: UIViewController, UIScrollViewDelegate {

    //变量--------------------------------------------------------------
    var _mainView: UIView!
    var _pageView: UIScrollView!
    var _subviews: [BasePageCtrllerPh]!
    var _toolbar: UIToolbar! //工具条
    var _tabbar: UIToolbar! //下面的选择条

    var _nCurPage: Int = 0

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
        _pageView = UIScrollView(frame: CGRect(x: 0, y: 44, width: frame.width, height: frame.height - 44)) //TODO：是不是不用隐藏toolbar了，与里面table展开有冲突？
        _mainView.addSubview(_pageView)

        _pageView.backgroundColor = UIColor.orangeColor()
        _pageView.pagingEnabled = true
        _pageView.bounces = false
        _pageView.showsHorizontalScrollIndicator = false

        _pageView.delegate = self

        let sSize = _pageView.bounds.size

        //加载页面
        _subviews = [
            PageMsgCtrllerPh(rootCtrller: self),
            PageProductCtrllerPh(rootCtrller: self),
            PageTeamCtrllerPh(rootCtrller: self),
            PageYouCtrllerPh(rootCtrller: self),
        ]

        _pageView.contentSize = CGSize(width: sSize.width * CGFloat(_subviews.count), height: sSize.height)

        for i in 0 ..< _subviews.count {
            _pageView.addSubview(_subviews[i].view)
            _subviews[i].view.frame = CGRect(x: sSize.width * CGFloat(i), y: 0, width: sSize.width, height: sSize.height)
        }
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

        let i1 = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "add1:")
        let i2 = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "add2:")
        let i3 = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "add3:")
        let i4 = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "add4:")
        let s = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)

        _tabbar.items = [s, i1, s, s, i2, s, s, i3, s, s, i4, s]
    }

    func createStautsbar(frame: CGRect) {
        let status = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 20))
        view.addSubview(status)

        status.backgroundColor = UIColor.redColor()
    }

    override func viewDidLoad() {
        //初始时在第一个页面，所以调用其进入函数
        _nCurPage = 0
        onDoneMovePageTo(_nCurPage)
    }

    //回调函数-----------------------------------------------------------
    func add1(s: AnyObject) {
        movePage(0)
    }

    func add2(s: AnyObject) {
        movePage(1)
    }

    func add3(s: AnyObject) {
        movePage(2)
    }

    func add4(s: AnyObject) {
        movePage(3)
    }

    //代理函数-----------------------------------------------------------
    private var _fBeginOffsetX: Float? = nil
    func scrollViewWillBeginDecelerating(scroll: UIScrollView) {
        _fBeginOffsetX = Float(scroll.contentOffset.x)
    }

    func scrollViewDidScroll(scroll: UIScrollView) {
        if _fBeginOffsetX != nil {
            let bMoveRight = _fBeginOffsetX < Float(scroll.contentOffset.x)
            let bAtRight = CGFloat(_nCurPage) * scroll.bounds.width < scroll.contentOffset.x
            if bMoveRight && bAtRight {
                ++_nCurPage
            } else if !bMoveRight && !bAtRight {
                --_nCurPage
            }
            _nCurPage = min(max(0, _nCurPage), _subviews.count)
            _fBeginOffsetX = nil

            print("开始滑动到", _nCurPage)
            onBeganMovePageTo(_nCurPage)
        }
    }

    func scrollViewDidEndDecelerating(scroll: UIScrollView) {
        print("滑动到", scroll.contentOffset.x)
        onDoneMovePageTo(_nCurPage)
    }

    //移动page--------------------
    private func movePage(index: Int) {
        print("按钮移动到", index)
        _nCurPage = index
        onBeganMovePageTo(index)
        UIView.animateWithDuration(0.2, animations: {

            self._pageView.contentOffset = CGPoint(
                x: self._pageView.bounds.size.width * CGFloat(index),
                y: 0
            )

            }, completion: {
                _ in self.onDoneMovePageTo(index)
        })
    }

    private func onBeganMovePageTo(index: Int) {
        //动画保护
        view.userInteractionEnabled = false
    }

    private func onDoneMovePageTo(index: Int) {
        //解除保护
        view.userInteractionEnabled = true

        //切换toolbar上按钮
        switchToolbarBtn(index)

        //进入页面
        _subviews[index].enterPage()
    }

    private func switchToolbarBtn(index: Int) {
        let arToolBtn = _subviews[index].getToolbarBtn()
        if arToolBtn != nil {
            
        }
    }

    //------------------------------------------------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
