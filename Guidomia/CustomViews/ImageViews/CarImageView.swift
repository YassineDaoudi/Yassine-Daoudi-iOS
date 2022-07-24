//
//  CarImageView.swift
//  Guidomia
//
//  Created by Yassine DAOUDI on 23/7/2022.
//

import UIKit

class CarImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds     = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
