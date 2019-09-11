//
//  Navigator.swift
//  Food Recipies
//
//  Created by admin on 9/1/19.
//  Copyright © 2019 kero. All rights reserved.
//

import UIKit

protocol  DataReceiver {
    func setData(_ : Any)
}
class Navigator{
    static var window: UIWindow?
    static var navigationController: UINavigationController!

    
    
    static func initialize(window: UIWindow, navigationController: UINavigationController?){
        self.window = window
        if let navigationController = navigationController{
            self.navigationController = navigationController
        } else {
            self.navigationController = UINavigationController()
            window.rootViewController = self.navigationController
            window.makeKeyAndVisible()
        }
    }
    static func navigate(controller: UIViewController){
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    static func navigate<T: UIViewController>(controllerType: T.Type){
        self.navigationController.pushViewController(self.getViewController(controllerType: controllerType), animated: true)
    }
    
    static func navigate<T: UIViewController>(controllerType: T.Type, data: Any) where T : DataReceiver{
        let controller = self.getViewController(controllerType: controllerType)
        controller.setData(data)
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    static func getViewController<T: UIViewController>(controllerType: T.Type ) -> T{
        return controllerType.init(nibName: self.genericName(type: controllerType), bundle: nil)
    }

    static func genericName<T: AnyObject>(type: T.Type) -> String {
        let fullName: String = NSStringFromClass(T.self)
        let components = fullName.components(separatedBy: ".")
        return components.last ?? fullName
        
    }

}

