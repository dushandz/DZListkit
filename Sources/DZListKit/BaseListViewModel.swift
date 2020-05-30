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
    open var isLoading = false
    open var listData = [BaseListModel]()
    open var reuserCellMap = [String : BaseListViewCell.Type]()
    
    //Override init this method when you need custom  dataModel -> cellResuerIdentifier map.
    open func findCellReuser(_ cellModel: BaseListModel) -> String {
        return "\(type(of: cellModel))"
    }
}
