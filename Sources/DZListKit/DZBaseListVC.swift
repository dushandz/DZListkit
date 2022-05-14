//
//  DZBaseListVC.swift
//  DZListKit
//
//  Created by dushandz on 2022/5/5.
//

import RxSwift

import Foundation
import UIKit

/// TableView 主体的列表
open class DZBaseListVC: UIViewController {
    
    private let _listVM = DZBaseListVM()
    ///虽然声明为 var 只是为了后面 module 外 可以 override
    open var listVM: DZBaseListVM { _listVM }
    public let tableView = UITableView()
    public let disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.registerCell()
        self.setupObserver()
        self.listVM.reload()
    }
    
    open func setupTableView() {
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
            self.tableView.estimatedRowHeight = 0
            self.tableView.estimatedSectionFooterHeight = 0
            self.tableView.estimatedSectionHeaderHeight = 0
        }
        
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        }
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorStyle = .none
//        self.tableView.bounces = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.frame = self.view.bounds
        self.view.addSubview(self.tableView)
    }
    
    ///注册cell 默认从 modelReuserMap 一对一注册
    open func registerCell() {
        for (_, value) in self.listVM.modelReuserMap {
            self.tableView.register(NSClassFromString(value), forCellReuseIdentifier: value)
        }
    }
    
    open func setupObserver() {
        self.listVM.list.asObservable().skip(1).subscribe { [weak self] list in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension DZBaseListVC: UITableViewDataSource & UITableViewDelegate {
    
    open  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { listVM.list.value.count }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            indexPath.row < listVM.list.value.count
        else { return UITableViewCell() }
        
        let model = self.listVM.list.value[indexPath.row]
        
        guard
            let reuser = listVM.modelReuserMap[type(of: model).cellReuseKey],
            let cell = tableView.dequeueReusableCell(withIdentifier: reuser, for: indexPath) as? DZBaseTableViewCell
        else { return UITableViewCell() }

        cell.update(model)
        return cell
        
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard
            indexPath.row < listVM.list.value.count
        else { return 0.0 }
        
        let model = self.listVM.list.value[indexPath.row]
        
        guard
            let cellType = listVM.getCellType(model)
        else { return 0.0 }
        return cellType.getCellHeight(model)
        
    }
    
}
