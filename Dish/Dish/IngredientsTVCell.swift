//
//  IngredientsTVCell.swift
//  Dish
//
//  Created by Craig Davis on 7/20/22.
//

import UIKit

class IngredientsTVCell: UITableViewCell {

    static let identifier = "IngredientsTVCell"

    let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Ingredients")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.text = "Name"
        return nameLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
       }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configureDetails(with model: Recipes){
//        for i in model.recipe.ingredientLines{
//            self.nameLabel.text = i
//        }
//        let imageUrl = model.ingredient.image
//        
//        if let data = try? Data(contentsOf: URL(string:imageUrl)!){
//            self.image.image = UIImage(data: data)
//        }
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageWidth = contentView.frame.size.height-6
        
        image.frame = CGRect(x: 5, y: 5, width: contentView.frame.size.height-10, height: contentView.frame.size.height-10)
        image.layer.cornerRadius = image.width/3.0
        nameLabel.frame = CGRect(x: 20+image.frame.size.width, y: -20, width: contentView.frame.size.width - 10 - image.frame.size.width - imageWidth, height: contentView.frame.size.height)
    }
}
