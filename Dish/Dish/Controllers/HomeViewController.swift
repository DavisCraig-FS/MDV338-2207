//
//  ViewController.swift
//  Dish
//
//  Created by Craig Davis on 7/7/22.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

//    private let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
       
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = SigninViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
    

}

