//
//  extension + UICollectionViewDataSource.swift
//  Cooksantara App
//
//  Created by Sasha on 14.01.25.
//

import Foundation
import UIKit


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendinCollectionViewCell.identifer, for: indexPath)
        guard let cell = cell as? TrendinCollectionViewCell else { return UICollectionViewCell()}
        let receiptOnIndex = recipes[indexPath.item]
        cell.set(with: receiptOnIndex)
        return cell
    }



}
