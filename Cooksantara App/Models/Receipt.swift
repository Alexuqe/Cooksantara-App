//
//  Receipt.swift
//  Cooksantara App
//
//  Created by Sasha on 12.01.25.
//

import Foundation

struct Receipt: Decodable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let prepTimeMinutes: Int
    let cookTimeMinutes: Int
    let servings: Int
    let difficulty: String
    let cuisine: String
    let caloriesPerServing: Int
    let tags: [String]
    let userId: Int
    let image: String
    let rating: Double
    let reviewCount: Int
    let mealType: [String]
}

struct Receiptes: Decodable {
    let recipes: [Receipt]
}
