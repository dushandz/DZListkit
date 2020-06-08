//
//  File.swift
//  
//
//  Created by dushandz on 2021/4/13.
//

import Foundation
import UIKit

@objc
protocol DZBaseListCell where Self: UITableViewCell {
    func config(_ model: DZBaseListModel)
    func cellHeight(_ model: DZBaseListModel) -> CGFloat
}

extension DZBaseListCell {
    func cellHeight(_ model: DZBaseListModel) -> CGFloat { model.cellHeight }
}
