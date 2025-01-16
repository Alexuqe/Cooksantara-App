//
//  extension + UICollectionView.swift
//  Cooksantara App
//
//  Created by Sasha on 16.01.25.
//

import UIKit



extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let availableHeight = collectionView.bounds.height * 0.95
        let width = availableHeight * 0.7 // Ширина чуть меньше высоты для пропорций
        return CGSize(width: width, height: availableHeight)
    }

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        switch kind {
//            case UICollectionView.elementKindSectionHeader:
//                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifer, for: indexPath) as? HeaderCollectionReusableView else { return  UICollectionReusableView() }
//                sectionHeader.headerText.text = HeadersCollectioView.trending.title
//                sectionHeader.headerImage.image = HeadersCollectioView.trending.image
//                return sectionHeader
//            default:
//                return  UICollectionReusableView()
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        let height = collectionView.bounds.height * 0.05
//        let width = collectionView.bounds.width
//        return CGSize(width: width * 0.3, height: height)
//    }
}
