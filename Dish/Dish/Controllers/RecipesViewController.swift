//
//  RecipesViewController.swift
//  Dish
//
//  Created by Craig Davis on 7/21/22.
//

import UIKit

class RecipesViewController: UIViewController {

    var savedRecipes: [Recipes]?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(RecipeTVCell.self, forCellReuseIdentifier: RecipeTVCell.identifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipes"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        view.addSubview(scrollView)
        scrollView.addSubview(tableView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame  = view.bounds
        tableView.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
    }

}

extension RecipesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedRecipes?.count ?? 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTVCell.identifier, for: indexPath) as! RecipeTVCell
        cell.configure(with: savedRecipes![indexPath.row])
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
