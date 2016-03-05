//
//  UnfoldableTable.swift
//  Warlock
//
//  Created by 卢乐颜 on 16/2/22.
//  Copyright © 2016年 卢乐颜. All rights reserved.
//

import Foundation

private enum SourceType {
    case Head
    case Body
    case Tail
    case Detail
}

private enum CellPosState {
    case In
    case Out
    case TopHalf //在上边露出一半
    case BottomHalf //在下边露出一半
    case BothHalf //两边都露出一半
}

class UnfoldableTable: UIScrollView, UIScrollViewDelegate {

    //事件列表
    private var _arSource: [AnyObject] = []
    private var _arSourceType: [SourceType] = []

    //事件相关记录值
    private var _nUnfoldNum: Int = 0 //展开的数量
    private var _nShowNum: Int = 0 //展示详情的数量

    //cell
    private class Cell {
        let view: UIView
        let sourceIndex: Int
        var posState: CellPosState = .Out {
            willSet {
                view.hidden = (newValue == .Out) ? true : false
            }
        }
        
        init(view: UIView, sourceIndex: Int) {
            self.view = view
            self.sourceIndex = sourceIndex
        }
    }
    private var _arCell: [Cell] = []

    //cell属性 可以设置
    var nHeadHeight: Int = 33 //默认值
    var nBodyHeight: Int = 99
    var nTailHeight: Int = 33

    //代理
    private let _delegate: UTDelegate

    //辅助值
    private var _nLastPos: CGFloat = 0

    //初始化---------------------------------------------------
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect, utDelegate: UTDelegate) {
        self._delegate = utDelegate
        super.init(frame: frame)

        //设置scrollView
        delegate = self
    }

    //--------------------------------------------------------
    //首次进入，可以快速把布局完成
    func enterFirst() {
        //获取初始事件加入列表中
        _arSource = _delegate.UTgetAllCellSources(self)
        _arSourceType = Array(count: _arSource.count, repeatedValue: .Body)

        //计算内层高度 初始只有body
        contentSize.height = CGFloat(_arSource.count * nBodyHeight)

        //码放cell
        putCellFromPos(0, formSourceIndex: 0)
    }

    //快速展开某个事件的详情
    func seeEventDetailFast(event: Event) {

    }

    //----------------------------------------------------------
    private func putCellFromPos(pos: CGFloat, formSourceIndex index: Int, dirIsDown bIsDown: Bool = true) {
        var curPos = pos
        var curIndex = index

        //第一个cell检查开始端是否超出了视框
        var cell = getCell(curIndex)
        if bIsDown && curPos - contentOffset.y < 0.00001 {
            cell.posState = .TopHalf
        } else if !bIsDown && bounds.height - 0.00001 < curPos + cell.view.bounds.height - contentOffset.y {
            cell.posState = .BottomHalf
        }

        //循环
        while true {
            if bIsDown {
                cell.view.frame.origin = CGPoint(x: curPos, y: 0)
                curPos += cell.view.bounds.height
                if bounds.height < CGFloat(curPos) - contentOffset.y {
                    if cell.posState != .TopHalf {
                        cell.posState = .BottomHalf
                    } else {
                        cell.posState = .BothHalf
                    }
                    break
                }
                curIndex += 1
            } else {
                cell.view.frame.origin = CGPoint(x: curPos - cell.view.frame.height, y: 0)
                curPos -= cell.view.bounds.height
                if CGFloat(curPos) - contentOffset.y < 0 {
                    if cell.posState != .BottomHalf {
                        cell.posState = .TopHalf
                    } else {
                        cell.posState = .BothHalf
                    }
                    break
                }
                curIndex -= 1
            }

            if cell.posState == .Out {
                cell.posState = .In
            }

            cell = getCell(curIndex)
        }
    }

    //获取cell，参数：source的索引
    private func getCell(index: Int) -> Cell {
        //查找未使用的cell
        var unusedCell: Cell?
        for cellStru in _arCell {
            if cellStru.posState == .Out {
                unusedCell = cellStru
                break
            }
        }

        //如果没有则创建cell
        if unusedCell == nil {
            let v = UIView(frame: CGRect(x: 0, y: 0, width: Int(bounds.width), height: nBodyHeight))
            self._delegate.UTcreateCellItem(self, InView: v)
            v.hidden = true

            unusedCell = Cell(view: v, sourceIndex: index)
            _arCell.append(unusedCell!)
        }

        self._delegate.UTsetCell(self, forView: unusedCell!.view, BySource: _arSource[index])

        return unusedCell!
    }

    //滚动 遍历cell struct 如果in或者half的移出视框，则变成out
    //如果half完全进入视框，则变为in，同时加载新的cell
    func scrollViewDidScroll(scroll: UIScrollView) {
//        for cell in _arCell {
//            if cell.posState == .Out {
//                continue
//            }
//
//            let curPos = cell.view.frame.origin.y - contentOffset.y
//            if curPos < 0 || bounds.height < curPos + frame.height {
//                cell.posState = .Out
//            }
//
//            if cell.posState == .Half {
//                if _nLastPos < contentOffset.y && curPos < frame.height { //向上拖拽全部进入视框
//                    cell.posState = .In
//                    putCellFromPos(curPos + frame.height, formSourceIndex: cell.sourceIndex + 1)
//                } else if contentOffset.y < _nLastPos && 0 < curPos {
//                    cell.posState = .In
//                    putCellFromPos(curPos, formSourceIndex: cell.sourceIndex - 1, dirIsDown: false)
//                }
//            }
//
//        }
    }
}

protocol UTDelegate {
    func UTgetAllCellSources(table: UnfoldableTable) -> [AnyObject]
    func UTcreateCellItem(table: UnfoldableTable, InView view: UIView)
    func UTsetCell(table: UnfoldableTable, forView view: UIView, BySource source: AnyObject)
}










