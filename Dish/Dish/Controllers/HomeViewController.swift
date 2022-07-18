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
    
    
    var data = [Recipes]()
    let app_id = "b3c6ace0"
    let app_key = "3c71f4ec5817e262c94c03100136eff3"
    var selectedRecipe: Recipes?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Preparing")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let searchField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Type Search Here"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.layer.opacity = 0.8
        return field
    }()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(RecipeTVCell.self, forCellReuseIdentifier: RecipeTVCell.identifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .gray
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(searchField)
        scrollView.addSubview(tableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame  = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: size * 2)
        searchField.frame = CGRect(x: 30, y: 20, width: scrollView.width-60, height: 52)
        tableView.frame = CGRect(x: 0, y: imageView.bottom+10, width: scrollView.width, height: view.height/3)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
        
    }
    
    //Alert
    func doAlert(str: String){
        let alert = UIAlertController(title: "Alert", message: str, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //field
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchRecipes()
        return true
    }
    func searchRecipes(){
           searchField.resignFirstResponder()
           guard let searchWord = searchField.text, !searchWord.isEmpty else{
               doAlert(str: "Please enter a recipe")
               return
           }
           if !checkCharInField(str: searchWord){
               return
           }
           let q = searchWord.replacingOccurrences(of: " ", with: "%20")
           data.removeAll()
           
           
           let url = URL(string: "https://api.edamam.com/search?q=\(q)&app_id=\(app_id)&app_key=\(app_key)")
           
           URLSession.shared.dataTask(with:url!, completionHandler: {data, response,error in
               guard let data = data, error == nil  else{
                   return
               }
                            
               //convert data
               var result: Result?
               do{
                   result = try JSONDecoder().decode(Result.self, from: data)
               }
               catch{
                   print("error")
               }
               guard let finalResult = result else{
                    return
               }
                   print(finalResult)
               //update our 
               let newRecipes = finalResult.results
               self.data.append(contentsOf: newRecipes)
               
               //update table
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
           }).resume()
       }

    func checkCharInField(str:String) -> Bool{
        do{
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: str, options: [], range: NSMakeRange(0, str.count)) != nil {
                doAlert(str: "Only english letters & spaces are allowed")
                return false
            }
        }
        catch{
        }
        return true
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTVCell.identifier, for: indexPath)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
