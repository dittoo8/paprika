//
//  Customs.swift
//  paprikas
//
//  Created by user on 2021/01/20.
//

import Foundation
import UIKit

class goToProfileTap: UITapGestureRecognizer {
    var userId: Int?
}
class goToCommentTap: UITapGestureRecognizer {
    var contentId: Int?
    var isWrite: Bool?
}
