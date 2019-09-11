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

class HomeViewController: UIViewController {

    
    var query : String?
    
    
    let disposeBag = DisposeBag()
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
    }
 

}


