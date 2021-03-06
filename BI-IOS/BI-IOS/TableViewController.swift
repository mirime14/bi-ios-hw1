//
//  TableViewController.swift
//  BI-IOS
//
//  Created by Dominik Vesely on 30/10/2017.
//  Copyright © 2017 ČVUT. All rights reserved.
//

import Foundation
import UIKit

class TableViewController : UIViewController {
    
    weak var tableView : UITableView!
    var dataManager = DataManager()
    
    var data = [Recipe]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil);
        self.title = "Table"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView();
        view.backgroundColor = .white
        
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(RecipeTableCell.self, forCellReuseIdentifier: "Cell")
        table.tableFooterView = UIView()
        view.addSubview(table)
        
        table.snp.makeConstraints { (make) in
            make.size.equalTo(view)
        }
        
        tableView = table
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataManager.getRecipes { [weak self] recipes in
            self?.data = recipes
            self?.tableView.reloadData()
        }
    }
    
    
}

//MARK: UITableView data source
extension TableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecipeTableCell
        cell.recipe = data[indexPath.row]
        return cell
    }
    
    
}

//MARK: UITableView delegate
extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var vc = DetailViewController()
        let id = data[indexPath.row].id
        vc._id = id as! String
        self.navigationController?.pushViewController(vc, animated: true)

        return
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}



