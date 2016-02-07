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

    init(rootCtrller: RootViewCtrllerPh) {
        super.init(nibName: nil, bundle: nil)
        _rootCtrller = rootCtrller
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
