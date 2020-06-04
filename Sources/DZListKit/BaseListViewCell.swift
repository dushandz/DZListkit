//
//  File.swift
//  
//
//  Created by dushandz on 2020/5/23.
//
import UIKit

open class BaseListViewCell: UITableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setSelected(false, animated: false)
    }
    
    required public init?(coder: NSCoder) {
        super.init(style: .default, reuseIdentifier: nil)
    }
    
    /// update UI with `cellModel`.
    /// - Parameter cellModel: cell update use it.
    open func configWithModel(_ cellModel: BaseListModel) {
        
    }

}
