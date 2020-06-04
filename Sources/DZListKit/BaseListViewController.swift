import UIKit


open class BaseListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    open var tableView: UITableView
    open var listViewModel: BaseListViewModel
    /// `Default is true`. when `isAutoRegister` is true. ViewContoller will call `registerCellReuser()` in `ViewDidLoad`
    open var isAutoRegister = true
    /// `Default is true`. when `autoLoad` is true. ViewContoller will call `listViewModel's load()` in `ViewDidLoad`
    open var autoLoad = true
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        tableView = UITableView()
        listViewModel = BaseListViewModel()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabView()
    }
    
    required public convenience init?(coder: NSCoder) {
        self.init(nibName: nil, bundle: nil)
    }
    
    func setupTabView() {
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.delegate = self
        self.tableView.dataSource = self;
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.frame = self.view.bounds
        self.view.addSubview(self.tableView)
        if self.isAutoRegister {
            self.registerCellReuser()
        }
        
        if self.autoLoad {
            self.listViewModel.load()
        }
    }
    
    open func registerCellReuser() {
         for item in self.listViewModel.reuserCellMap {
             self.tableView.register(item.value, forCellReuseIdentifier: item.key)
         }
     }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.listViewModel.listData.count
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.row < self.listViewModel.listData.count {
             return self.listViewModel.listData[indexPath.row].cellHeight
         } else {
             return 0
         }
     }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if indexPath.row < self.listViewModel.listData.count {
                // find the dataModel.
                let cellModel = self.listViewModel.listData[indexPath.row]
                // get cell reuseIdentifier.
                let reuser = self.listViewModel.findCellReuser(cellModel)
                let cell = tableView.dequeueReusableCell(withIdentifier: reuser, for: indexPath)
                if cell is BaseListViewCell {
                    let baseCell = cell as! BaseListViewCell
                    //update cell with model.
                    baseCell.configWithModel(cellModel)
                }
                return cell
            } else {
                //out of range.
                return  UITableViewCell()
            }
     }
    
}
