//
//  Recipe.swift
//  Dish
//
//  Created by Craig Davis on 7/14/22.
//

import Foundation

class Recipe: Codable{
    
    let label: String
    let image: String
    let source: String
    let url: String
    let ingredientLines: [String]
}
