//
//  RecipeDetailsViewController.swift
//  Dish
//
//  Created by Craig Davis on 7/16/22.
//

import UIKit

class RecipeDetailsViewController: UIViewController {

    var data = [Recipes]()
    var recipe: Recipes?
    var ingredient = [Ingredients]()
    var ings = [String]()
    var url: String?
    
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
    
    private let label: UILabel = {
        let title = UILabel()
        title.text = ""
        title.textColor = UIColor.black
        title.font = UIFont(name:"Nero Bold",size: 20)
        return title
    }()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(IngredientsTVCell.self, forCellReuseIdentifier: IngredientsTVCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recipe Details"
        configureDetails(with: recipe!)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(label)
        scrollView.addSubview(tableView)
        
    }

    func configureDetails(with model: Recipes){
         self.label.text = model.recipe.label
         ings = model.recipe.ingredientLines
         self.url = model.recipe.url
         let url = model.recipe.image
         
         if let data = try? Data(contentsOf: URL(string:url)!){
             self.imageView.image = UIImage(data: data)
         }
     }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame  = view.bounds
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: view.height/3)
        label.frame = CGRect(x: 10, y: imageView.bottom + 10, width: scrollView.width-10, height: 20)
        tableView.frame = CGRect(x: 0, y: label.bottom+5, width: scrollView.width, height: view.height/3.5)
//        searchButton.frame = CGRect(x: 150, y: searchField.bottom+10, width: scrollView.width-300, height: 39)
    }

    
    
}

extension RecipeDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ings.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTVCell.identifier, for: indexPath) as! IngredientsTVCell
        cell.nameLabel.text = ings[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        ingredients = recipe[indexPath.row]
        
//        performSegue(withIdentifier: "recipeDetails", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "recipeDetails"{
//            let vc: RecipeDetailsViewController = segue.destination as! RecipeDetailsViewController
//                vc.recipe = selectedRecipe
//        }
//    }
}
