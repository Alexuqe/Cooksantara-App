//
//  extension + UITableViewDelegate.swift
//  Cooksantara App
//
//  Created by Sasha on 20.01.25.
//

import UIKit

extension DetailReceiptViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
