//
//  extensions.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/14.
//

import Foundation
import UIKit

extension NSMutableAttributedString {

    func bold(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: fontSize)]
        self.append(NSMutableAttributedString(string: text, attributes: attrs))

        return self
    }

    func normal(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: fontSize)]
        self.append(NSMutableAttributedString(string: text, attributes: attrs))

        return self
    }
}

extension UILabel {

    func countLabelLines() -> Int {
        // Call self.layoutIfNeeded() if your view is uses auto layout
        let myText = self.text! as NSString
        let attributes = [NSAttributedString.Key.font: self.font]
        let labelSize = myText.boundingRect(with: CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)

        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
    }

    func isTruncated() -> Bool {
        guard numberOfLines > 0 else { return false }

        return countLabelLines() > numberOfLines
    }
}
extension UIViewController {
    @objc func keyboardWillShowHandle(notification: NSNotification) {
        print("baseVC - keyboardWillShowHandle() called")
        // 키보드 사이즈 가져오기
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y = self.view.frame.origin.y - keyboardSize.height
            }
            if self.view.safeAreaInsets.bottom > 0 {
                print("safe AreaInsets : \(self.view.safeAreaInsets.bottom)")
                self.view.frame.origin.y = self.view.frame.origin.y + 34
            }
        }
    }

    @objc func keyboardWillHideHandle() {
        print("keyboardWillHide")
        self.view.frame.origin.y = 0
    }
    @objc func goToCommentVC(param: goToCommentTap) {
        print("go to comment vc content id : \(param.contentId)")
        let commentVC = storyboard?.instantiateViewController(withIdentifier: "CommentVC") as! CommentViewController
        commentVC.presenter.setContentConfig(contentId: param.contentId!, isWrite: param.isWrite!)
        self.navigationController?.pushViewController(commentVC, animated: true)
    }
    @objc func goToProfileVC(param: goToProfileTap) {
        print("go to profile vc userid : \(param.userId)")
        let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileViewController
        profileVC.presenter.setProfileConfig(userId: param.userId!)
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
}
