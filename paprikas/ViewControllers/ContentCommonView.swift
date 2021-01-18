//
//  ContentView.swift
//  paprikas
//
//  Created by 박소현 on 2021/01/13.
//

import UIKit

class ContentCommenView: UIView {

    @IBOutlet weak var userNameLabel: UILabel!
    private let xibName = "ContentCommenView"
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    private func commonInit() {
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
