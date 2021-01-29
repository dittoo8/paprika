//
//  FoFTableViewCell.swift
//  paprikas
//
//  Created by user on 2021/01/27.
//

import UIKit

class FoFTableViewCell: UITableViewCell {

    @IBOutlet weak var fofCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fofCollectionView.delegate = self
        fofCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
 extension FoFTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select cell \(indexPath.row)")
        let FarmVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: CONSTANT_VC.FARM) as! FarmViewController
        FarmVC.goToProfile(userId: 1)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = fofCollectionView.dequeueReusableCell(withReuseIdentifier: "FoFCollectionViewCell", for: indexPath) as! FoFCollectionViewCell
        cell.config()
        return cell
    }
    func collectionView(_ collectionVieÒw: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsize = CGSize(width: 90, height: 100)
        return cellsize
    }

 }
