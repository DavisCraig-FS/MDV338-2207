//
//  IngredeintsListViewController.swift
//  Dish
//
//  Created by Craig Davis on 7/16/22.
//

import UIKit

class IngredeintsListViewController: UIViewController {

   
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "INGREDIENT PICTURE!!!!!!!!!!")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(IngredientsTVCell.self, forCellReuseIdentifier: IngredientsTVCell.identifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ingredients"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(tableView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame  = view.bounds
        imageView.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: view.height/3)
        tableView.frame = CGRect(x: 0, y: imageView.bottom+10, width: scrollView.width, height: view.height/3)
    }

}

extension IngredeintsListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTVCell.identifier, for: indexPath)
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
