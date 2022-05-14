//
//  DZBaseListVM.swift
//  DZListKit
//
//  Created by dushandz on 2022/5/5.
//

import Foundation
import UIKit

import RxRelay
import RxSwift


///列表模型协议
public protocol DZListBsaeModelType {
    ///返回数据类型对应 Cell 的 复用标识
   static var cellReuseKey: String { get }
}

///列表模型协议-默认实现
public extension DZListBsaeModelType {
    
    static var cellReuseKey: String { String(describing: type(of: self) ) }
}


/// UITableViewCell & UICollectionViewCell 都可实现此协议
public protocol DZListBaseCellType: AnyObject {
    func update(_ model: DZListBsaeModelType)
    static func getCellHeight(_ model: DZListBsaeModelType) -> CGFloat
    static func getCellSize(_ model: DZListBsaeModelType) -> CGSize
}

/// 基础 listVM
open class DZBaseListVM {
    
    /// 列表主体数据是否在请求中
    open var isloading = BehaviorRelay<Bool>(value: false)
    /// 列表主体数据是否还有更多
    open var isEnd = BehaviorRelay<Bool>(value: false)
    /// 列表主体数据请求error
    open var error = BehaviorRelay<Error?>(value: nil)
    /// 列表数据源
    public let list = BehaviorRelay<[DZListBsaeModelType]>(value: [])
    
    public let disposeBag = DisposeBag()
    
    ///模型类型名-Cell复用标识 Map
    open var modelReuserMap: [String : String] { [:] }
    
    ///Cell复用标识-Cell类型名 Map
    open var reuserCellMap: [String : String] { [:] }
    
    /// 通过 list 中的元素返回对应的 cell 类型 此处举例为单一例 一种模型类型对应一种cell
    /// - Parameter model: list 中的元素
    /// - Returns: 返回对应的 Cell 的 类型
    open func getCellType(_ model: DZListBsaeModelType) -> DZListBaseCellType.Type?  {
        guard
            let resuser = self.modelReuserMap[type(of: model).cellReuseKey],
            let listCellType = NSClassFromString(resuser) as? DZListBaseCellType.Type
        else { return nil }
        return listCellType
    }
    
    /// 重新加载数据
    open func reload() {
        if isloading.value { return }
        isloading.accept(true)
    }
    /// 加载更多数据
    open func loadMore() {
        if isloading.value { return }
        isloading.accept(true)
    }
}
