//
//  DZBaseListViewController.swift
//  
//
//  Created by dushandz on 2021/2/3.
//

import Foundation
import UIKit


@objc
class DZBaseListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView
    var listVM: DZBaseListViewModel
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ listVM: DZBaseListViewModel) {
        self.tableView = UITableView()
        self.listVM = listVM
        super.init(nibName: nil, bundle: nil)
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
        self.listVM.reuserCellMap.forEach { [weak self] (reuser, cellClass) in
            self?.tableView.register(cellClass, forCellReuseIdentifier: reuser)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listVM.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < self.listVM.list.count {
            let model = self.listVM.list[indexPath.row]
            let reuser = self.listVM.getReuser(model)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuser) as? DZBaseListCell else {
                return UITableViewCell()
            }
            cell.config(model)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < self.listVM.list.count {
            let model = self.listVM.list[indexPath.row]
            let reuser = self.listVM.getReuser(model)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuser) as? DZBaseListCell else {
                return 0
            }
            return cell.cellHeight(model)
        } else {
            return 0
        }
    }
}
