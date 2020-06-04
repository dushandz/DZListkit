//
//  BaseListViewModel.swift
//  
//
//  Created by dushandz on 2020/5/23.
//

import Foundation
import UIKit.UIGraphics

public protocol BaseListModel {
    var cellHeight: CGFloat { get }
}

open class BaseListViewModel {
    /// when `isLoading` is true `load()` will return immediately.
    open var isLoading = false
    /// when `isEnd` is true `load()` will return immediately.
    open var isEnd = false
    /// the tableView dataSource. obeserver this list, when it changes  `tableView` of `BaseListViewController` should call `reloadData()`
    open var listData = [BaseListModel]()
    /// storage cell reuseIdentifier. eg: ["exampleCellReuser" : exampleCell]
    open var reuserCellMap = [String : BaseListViewCell.Type]()
    /// Override init this method when you need custom  dataModel -> cellResuerIdentifier map.
    open func findCellReuser(_ cellModel: BaseListModel) -> String {
        return "\(type(of: cellModel))"
    }
    
    /// `load()` you can resolve request data here.
    open func load() {
        guard !isLoading && !isEnd else {
            return
        }
        //load data here.
    }
}
