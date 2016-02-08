//
//  BasePageCtrllerPh.swift
//  Warlock
//
//  Created by 卢乐颜 on 16/2/6.
//  Copyright © 2016年 卢乐颜. All rights reserved.
//

import UIKit

class BasePageCtrllerPh: UIViewController {
    var _rootCtrller: RootViewCtrllerPh!
    var _bPageInit = false

    //-----------------------------------------------------------

    init(rootCtrller: RootViewCtrllerPh) {
        super.init(nibName: nil, bundle: nil)
        _rootCtrller = rootCtrller
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //所有页面基本初始化都是一致的，直到调用各自的enterPage再加载各自的页面
    final override func loadView() {
        super.loadView()
        view.bounds = _rootCtrller._pageView.bounds

        let center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        let label: UILabel = UILabel(frame: CGRect(x: center.x, y: center.y, width: 100, height: 20))

        view.addSubview(label)

        label.text = "wahaha"
    }

    //进入页面，需要继承加载各自的页面
    func enterPage() {
        if !_bPageInit {
            _bPageInit = true
            initPage()
        }
    }

    //页面初始化
    func initPage() {
        fatalError("initPage need inherit")
    }
}
