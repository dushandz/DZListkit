//
//  File.swift
//  
//
//  Created by dushandz on 2021/4/13.
//

import Foundation
import UIKit

@objc
protocol NameDescribable {
    var typeName: String { get }
    static var typeName: String { get }
}

extension NameDescribable {
    var typeName: String {
        return String(describing: type(of: self))
    }

    static var typeName: String {
        return String(describing: self)
    }
}

@objc
protocol DZBaseListModel : NameDescribable {
    /// Describe TableView Cell Height
    var cellHeight: CGFloat { get set }
}

extension DZBaseListModel {
    var cellHeight: CGFloat {
        get { return 0 }
        set { cellHeight = newValue }
        
    }
}
