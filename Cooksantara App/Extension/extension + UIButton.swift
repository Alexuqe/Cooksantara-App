//
//  extension + UIButton.swift
//  Cooksantara App
//
//  Created by Sasha on 20.01.25.
//


import UIKit


extension UIButton {
    static func createdSegmentedButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        return button
    }
}
