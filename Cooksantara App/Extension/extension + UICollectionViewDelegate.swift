//
//  extension + UICollectionViewDelegate.swift
//  Cooksantara App
//
//  Created by Sasha on 14.01.25.
//

import Foundation
import UIKit


extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let receiptsDetail = recipes[indexPath.item]

        let detailVC = DetailReceiptViewController()
        detailVC.recipes = receiptsDetail
        detailVC.title = receiptsDetail.name
        detailVC.instructionOnTable = receiptsDetail.instructions
        navigationController?.pushViewController(detailVC, animated: true)
    }


    
}
