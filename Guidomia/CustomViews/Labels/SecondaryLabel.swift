//
//  SecondaryLabel.swift
//  Guidomia
//
//  Created by Yassine DAOUDI on 23/7/2022.
//

import UIKit

class SecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
    }
    
    private func configure() {
        textColor            = UIColor(hex: 0x858585)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor      = 0.90
        lineBreakMode          = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
