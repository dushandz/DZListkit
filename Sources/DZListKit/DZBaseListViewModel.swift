//
//  File.swift
//  
//
//  Created by dushandz on 2021/4/27.
//

import Foundation


@objc
class DZBaseListViewModel: NSObject {
  
    var isLoading = false
    var list: [DZBaseListModel] = []
    // key:cell-reuser model: Model type
    let reuserCellMap : [String : DZBaseListCell.Type]
    
    override init() {
        self.reuserCellMap = [:]
        super.init()
    }
    
    func load() {
        guard !isLoading else {
            return
        }
        isLoading.toggle()
    }
    
    func loadMore() {
        guard !isLoading else {
            return
        }
        isLoading.toggle()
    }
    
    // override this method. if you model need
    func getReuser(_ model: DZBaseListModel) -> String { model.typeName }

}
