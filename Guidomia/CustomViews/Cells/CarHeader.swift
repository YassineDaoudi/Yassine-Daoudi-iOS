//
//  CarHeader.swift
//  Guidomia
//
//  Created by Yassine DAOUDI on 24/7/2022.
//

import UIKit
import Cosmos

class CarHeader: UITableViewCell {
    static let reuseID = "CarHeader"
    let titleLabel = TitleLabel(textAlignment: .left, fontSize: 20)
    let priceLabel = SecondaryTitleLabel(fontSize: 17)
    let carImageView = CarImageView(frame: .zero)
    
    let starRatingView: CosmosView = {
        let cosmosView = CosmosView()
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.filledColor = UIColor(hex: 0xFC6016)
        cosmosView.settings.totalStars = 5
        cosmosView.settings.starSize = 17
        cosmosView.settings.fillMode = .full
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        return cosmosView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with car: Car) {
        titleLabel.text = car.model
        priceLabel.text = "Price: \(car.marketPrice)"
        carImageView.image = UIImage(named: car.make.replacingOccurrences(of: " ", with: "_"))
        starRatingView.rating = Double(car.rating)
    }
    
    func configure() {
        
        selectionStyle = .none
        backgroundColor = UIColor(hex: 0xD5D5D5)

        addSubviews(carImageView, titleLabel, priceLabel, starRatingView)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            carImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            carImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            carImageView.widthAnchor.constraint(equalToConstant: 150),
            carImageView.heightAnchor.constraint(equalToConstant: 100),
            carImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),

            titleLabel.topAnchor.constraint(equalTo: carImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: padding),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            starRatingView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            starRatingView.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: padding),
            starRatingView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }
}
