//
//  CategoryCollectionViewCell.swift
//  paprikas
//
//  Created by user on 2021/01/27.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryNameLabel: UILabel!
    var cellCategory: String?
    func configureCell(categoryName: String) {
        categoryNameLabel.text = categoryName
        cellCategory = categoryName
        self.contentView.layer.cornerRadius = 10
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = UIColor.systemGray2
    }
    func selectCell() {
        self.contentView.backgroundColor = UIColor.systemGreen
    }
    func unselectCell() {
        self.contentView.backgroundColor = UIColor.systemGray2
    }
}
