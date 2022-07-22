//
//  RecipeTVCell.swift
//  Dish
//
//  Created by Craig Davis on 7/16/22.
//

import UIKit

class RecipeTVCell: UITableViewCell {
    static let identifier = "RecipeTVCell"
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Ingredients")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.text = "Name"
        return nameLabel
    }()
    
    private let sourceLabel: UILabel = {
        let sourceLabel = UILabel()
        sourceLabel.textColor = .gray
        sourceLabel.font = .systemFont(ofSize: 18, weight: .regular)
        sourceLabel.text = "Source"
        return sourceLabel
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "text.badge.plus"), for: .normal)
        button.tintColor = UIColor(red: 0.0, green: 0.6, blue: 0.1, alpha: 1.0)
        button.layer.masksToBounds = true
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 0.4)
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(addButton)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder) has not been implemented")
    }
    
    func configure(with model: Recipes){
        self.nameLabel.text = model.recipe.label
        self.sourceLabel.text = model.recipe.source
        let url = model.recipe.image
        
        if let data = try? Data(contentsOf: URL(string:url)!){
            self.image.image = UIImage(data: data)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageWidth = contentView.frame.size.height-6
        
        image.frame = CGRect(x: 5, y: 5, width: contentView.frame.size.height-10, height: contentView.frame.size.height-10)
        image.layer.cornerRadius = image.width/3.0
        nameLabel.frame = CGRect(x: 20+image.frame.size.width, y: -20, width: contentView.frame.size.width - 10 - image.frame.size.width - imageWidth, height: contentView.frame.size.height)
        sourceLabel.frame = CGRect(x: 20+image.frame.size.width, y: nameLabel.bottom+40, width: contentView.frame.size.width - 10 - image.frame.size.width - imageWidth, height: contentView.frame.size.height)
        addButton.frame = CGRect(x: image.frame.size.width + nameLabel.frame.size.width + 30, y: image.frame.size.height/2.5, width: 20, height: 20)
    }
}
