//
//  ProfileViewController.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/04.
//

import UIKit

class ProfileViewController: BaseViewController {

    let presenter = ProfilePresenter(profileService: ProfileService())
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
    }
    @IBOutlet weak var profileCollectionView: UICollectionView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        self.navigationItem.title = "username"
    }

}
extension ProfileViewController: ProfileView {
//    func setProfileViewData(Profile: Profile){
//
//    }
}
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - Profile Header Methods
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = profileCollectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionFeedCell", for: indexPath) as! ProfileCollectionFeedCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProfileHeaderCell", for: indexPath) as! ProfileHeaderCell
            return headerView
        default:
            assert(false)
        }
    }

    // MARK: - Profile Feed Methods

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        profileCollectionView.bounces = profileCollectionView.contentOffset.y > 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contentVC = storyboard?.instantiateViewController(withIdentifier: "ContentDetailVC") as! ContentDetailViewController
        self.navigationController?.pushViewController(contentVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width/3)-1
        let cellsize = CGSize(width: width, height: width)
        return cellsize
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
}
