//
//  CustomSegmentedTableViewCell.swift
//  Cooksantara App
//
//  Created by Sasha on 19.01.25.
//

import UIKit

final class CustomSegmentedTableViewCell: UITableViewCell {

        //MARK: Private Outlets
    private lazy var stepCircleButton: UIButton = {
        let circleButton = UIButton()

        circleButton.backgroundColor = .systemGray6
        circleButton.setImage(UIImage(systemName: ""), for: .normal)
        circleButton.layer.cornerRadius = circleButton.frame.height / 2
        return circleButton
    }()
    private lazy var  stepLabel = UILabel()
    private lazy var  descriptionLabel = UILabel()


        //MARK: Properties
    static let identifer = "CustomSegmentedCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(ingredietns: Recipe) {

    }

}
