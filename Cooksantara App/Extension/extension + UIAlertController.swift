//
//  extension + UIAlertController.swift
//  Cooksantara App
//
//  Created by Sasha on 13.01.25.
//

import Foundation
import UIKit


extension UIViewController {
    private func showAlert(with status: Alert) {
        let alert = UIAlertController(
            title: status.title,
            message: status.message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

