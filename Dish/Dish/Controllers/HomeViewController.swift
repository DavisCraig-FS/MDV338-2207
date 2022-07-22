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
    let app_id = "bf5fa51a"
    let app_key = "a0c36c3b123243152c5f4f84d644178c"
    var selectedRecipe: Recipes?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Preparing")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let searchField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .search
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
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.1, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RecipeTVCell.self, forCellReuseIdentifier: RecipeTVCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(searchField)
        scrollView.addSubview(tableView)
        scrollView.addSubview(searchButton)
        //        tableView.reloadData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame  = view.bounds
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: view.height/3)
        searchField.frame = CGRect(x: 30, y: 20, width: scrollView.width-60, height: 52)
        tableView.frame = CGRect(x: 0, y: imageView.bottom, width: scrollView.width, height: view.height/3)
        searchButton.frame = CGRect(x: 150, y: searchField.bottom+10, width: scrollView.width-300, height: 39)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
        
    }
    
    // Alert
    func doAlert(str: String){
        let alert = UIAlertController(title: "Alert", message: str, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //field
    
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        searchRecipes()
    //        return true
    //    }
    @objc private func searchButtonTapped(){
        searchRecipes()
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
        
        //    https://api.edamam.com/search?q=cheese&app_id=bf5fa51a&app_key=a0c36c3b123243152c5f4f84d644178c
        let url = URL(string:"https://api.edamam.com/search?q=\(q)&app_id=\(app_id)&app_key=\(app_key)")
        
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
            
            //update
            let newRecipes = finalResult.hits
            self.data.append(contentsOf: newRecipes)
            
            //update table
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print(finalResult)
        }).resume()
    }
    
    func checkCharInField(str: String) -> Bool{
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
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTVCell.identifier, for: indexPath) as! RecipeTVCell
        cell.configure(with: data[indexPath.row])
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRecipe = data[indexPath.row]
        
        
        performSegue(withIdentifier: "recipeDetails", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetails"{
            let vc: RecipeDetailsViewController = segue.destination as! RecipeDetailsViewController
            vc.recipe = selectedRecipe
            vc.ings = selectedRecipe?.recipe.ingredientLines ?? [""]
        }
    }
}
