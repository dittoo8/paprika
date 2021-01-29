//
//  FoFTableViewCell.swift
//  paprikas
//
//  Created by user on 2021/01/27.
//

import UIKit

class FoFTableViewCell: UITableViewCell {
    var fofList = [User]()
    @IBOutlet weak var fofCollectionView: UICollectionView!
    @IBOutlet weak var noFoFLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        fofCollectionView.delegate = self
        fofCollectionView.dataSource = self
    }

}
 extension FoFTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if fofList.count == 0 {
            noFoFLabel.isHidden = false
        } else {
            noFoFLabel.isHidden = true
        }
        return fofList.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let FarmVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: CONSTANT_VC.FARM) as! FarmViewController
        FarmVC.goToProfile(userId: fofList[indexPath.row].userid!)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = fofCollectionView.dequeueReusableCell(withReuseIdentifier: "FoFCollectionViewCell", for: indexPath) as! FoFCollectionViewCell
        let user = fofList[indexPath.row]

        let photoUrl = URL(string: user.userphoto!)!
        cell.configureFofCollectionCell(userId: user.userid!, nickname: user.nickname!, userProto: photoUrl, acquaintance: user.acquaintance!)
        return cell
    }
    func collectionView(_ collectionVieÒw: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsize = CGSize(width: 100, height: 120)
        return cellsize
    }

 }
