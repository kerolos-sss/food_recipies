//
//  HomeViewController.swift
//  Food Recipies
//
//  Created by admin on 9/1/19.
//  Copyright © 2019 kero. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//enum MyError: Error {
//    case runtimeError(String)
//}

class HomeViewController: UIViewController {

    
    var query : String?
    
    let pageSize = 5
    private let maxPages = 100000
    private var lastPageReached = false
    var data: [[RecipeViewData]]?
    
    
    
    let disposeBag = DisposeBag()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: RecipePreviewTableViewCell.nibName, bundle: nil)
        tableView.register( nib, forCellReuseIdentifier:RecipePreviewTableViewCell.reuseIdentifier )
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
//        searchBar.rx.text.subscribe(onNext: { [unowned self] (text) in
//            print(text)
//        }).disposed(by: disposeBag)
//
        searchBar.rx.searchButtonClicked.subscribe(onNext: { [unowned self] in
            self.searchBar.resignFirstResponder()
            self.updateQuery()
            self.getData()
        }).disposed(by: disposeBag)
        
//        searchBar.rx.cancelButtonClicked.subscribe(onNext: { [unowned self] in
//            self.searchBar.resignFirstResponder()
//        }).disposed(by: disposeBag)
        
    }

    func updateQuery(){

        
    }
    func getData(){
        var pageIndex = 0
        if lastPageReached{
            return
        }
        if dataCount % pageSize == 0{
            pageIndex = dataCount / pageSize
            if (pageIndex < maxPages ){
                // will get more data
            } else {
                return
            }
        } else{
            lastPageReached = true
            return
        }
        
        Provider.apiService.search(query: "", page: pageIndex, pageSize: pageSize).subscribe(onNext: { [unowned self] (items) in
            
            if self.data == nil {
                self.data = []
            }
            self.data?.append(items)
            self.tableView.reloadData()
            
        }).disposed(by: disposeBag)
    }
 

    var dataCount: Int {
        get {
            return data?.reduce(0, { (acc, items) -> Int in
                return acc + items.count
            }) ?? 0
        }
    }
    public func getItem(index: Int) -> RecipeViewData?{
        guard let data = self.data else { return nil }

        
        guard data.count  > index / pageSize
            else {
                return nil
        }
        
        let pageIndex = index / pageSize
        
        var page = data[pageIndex]
        let item = page[index % pageSize]
        
        return item
    }
    
}


extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipePreviewTableViewCell.reuseIdentifier) as! RecipePreviewTableViewCell
        
//        guard  let item = getItem(index: indexPath.item)
//            else {
//                throw MyError.runtimeError("Item Should not be nil")
//        }
        
        // should handle the error later if a scinario can reach it
        let item = getItem(index: indexPath.item)!
        
        cell.updateCell(item: item)
        
        if indexPath.item + 1 == dataCount {
            getData()
        }
        
        return cell
    }
    
    
}
