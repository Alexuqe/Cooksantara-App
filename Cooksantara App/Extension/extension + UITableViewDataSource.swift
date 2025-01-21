//
//  extension + UITableViewDataSource.swift
//  Cooksantara App
//
//  Created by Sasha on 20.01.25.
//

import UIKit

extension DetailReceiptViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes?.instructions.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomSegmentedTableViewCell.identifer, for: indexPath)
        guard let cell = cell as? CustomSegmentedTableViewCell else { return UITableViewCell() }

        let recipesText = instructionOnTable[indexPath.row]
        cell.set(ingredients: recipesText)
        cell.selectionStyle = .none
        return cell
    }


}

