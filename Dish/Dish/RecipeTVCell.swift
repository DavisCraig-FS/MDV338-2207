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
        sourceLabel.textColor = .black
        sourceLabel.font = .systemFont(ofSize: 18, weight: .bold)
        sourceLabel.text = "Source"
        return sourceLabel
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .lightGray
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(sourceLabel)
    }

    required init?(coder: NSCoder){
        fatalError("init(coder) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageWidth = contentView.frame.size.height-6
        
        image.frame = CGRect(x: 5, y: 5, width: contentView.frame.size.height-10, height: contentView.frame.size.height-10)
        nameLabel.frame = CGRect(x: 10+image.frame.size.width, y: 0, width: contentView.frame.size.width - 10 - image.frame.size.width - imageWidth, height: contentView.frame.size.height)
        sourceLabel.frame = CGRect(x: 10+nameLabel.frame.size.width, y: 0, width: contentView.frame.size.width - 10 - image.frame.size.width - imageWidth, height: contentView.frame.size.height)
    }
}
