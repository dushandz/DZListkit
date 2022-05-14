//
//  DZBaseListCell.swift
//  DZListKit
//
//  Created by dushandz on 2022/5/5.
//

import Foundation
import UIKit

///List 组件 TableViewCell 基类
open class DZBaseTableViewCell: UITableViewCell, DZListBaseCellType {
    
    open func update(_ model: DZListBsaeModelType) { }

    open class func getCellHeight(_ model: DZListBsaeModelType) -> CGFloat { 0 }
    open class func getCellSize(_ model: DZListBsaeModelType) -> CGSize { CGSize.zero }
}
///List 组件 UICollectionViewCell 基类
open class DZBaseCollectionViewCell: UICollectionViewCell, DZListBaseCellType {
    
    open func update(_ model: DZListBsaeModelType) { }

    open class func getCellHeight(_ model: DZListBsaeModelType) -> CGFloat { 0 }
    open class func getCellSize(_ model: DZListBsaeModelType) -> CGSize { CGSize.zero }
}
