//
//  Receipt.swift
//  Cooksantara App
//
//  Created by Sasha on 12.01.25.
//

import Foundation

struct Recipe: Decodable {
    let id: Int
    let name: String // название
    let ingredients: [String] // ингредиенты
    let instructions: [String] // инструкции
    let prepTimeMinutes: Int // время подготовки в минутах
    let cookTimeMinutes: Int // Время приготовления в минутах
    let servings: Int // количество порций
    let difficulty: String // сложность
    let cuisine: String // Чья кухня
    let caloriesPerServing: Int // калорийность на порцию
    let tags: [String] // теги
    let userId: Int // идентификатор пользователя
    let image: String //
    let rating: Double //
    let reviewCount: Int // отзыв
    let mealType: [String] // Тип блюда
}

struct Recipes: Decodable {
    let recipes: [Recipe]
}
