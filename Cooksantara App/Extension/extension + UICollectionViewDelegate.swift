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
//        detailVC.dishImage.image = UIImage(named: receiptsDetail.image) ?? UIImage(systemName: "tray")
//        detailVC.ratingDishLabel.text = "\(receiptsDetail.rating) ★"
//        detailVC.minutesLabel.text = "\(receiptsDetail.cookTimeMinutes) Min"
        detailVC.recipe = receiptsDetail

        navigationController?.pushViewController(detailVC, animated: true)
    }


    
}
