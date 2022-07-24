//
//  CarCell.swift
//  Guidomia
//
//  Created by Yassine DAOUDI on 22/7/2022.
//

import UIKit

class CarCell: UITableViewCell {
    static let reuseID = "CarCell"
    let prosLabel = TitleLabel(textAlignment: .left, fontSize: 17)
    let prosStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let consLabel = TitleLabel(textAlignment: .left, fontSize: 17)
    let consStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
        selectionStyle = .none
        backgroundColor = UIColor(hex: 0xD5D5D5)
        
        prosLabel.text = "Pros :"
        consLabel.text = "Cons :"
        
        addSubviews(prosLabel, prosStackView, consLabel, consStackView)
        
        NSLayoutConstraint.activate([
            prosLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            prosLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            prosLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            prosLabel.heightAnchor.constraint(equalToConstant: 22),
            
            prosStackView.topAnchor.constraint(equalTo: prosLabel.bottomAnchor),
            prosStackView.leadingAnchor.constraint(equalTo: prosLabel.leadingAnchor, constant: 10),
            prosStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            consLabel.topAnchor.constraint(equalTo: prosStackView.bottomAnchor),
            consLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            consLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            consStackView.topAnchor.constraint(equalTo: consLabel.bottomAnchor),
            consStackView.leadingAnchor.constraint(equalTo: consLabel.leadingAnchor, constant: 10),
            consStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            consStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    func setPros(with pros: [String]) {
        prosStackView.arrangedSubviews.forEach {
            prosStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        pros.forEach {
            let label = UILabel()
            label.text = "• \($0)"
            label.font = .boldSystemFont(ofSize: 15)
            prosStackView.addArrangedSubview(label)
        }
        
    }
    
    func setCons(with cons: [String]) {
        consStackView.arrangedSubviews.forEach {
            consStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        cons.forEach {
            let label = UILabel()
            label.text = "• \($0)"
            label.font = .boldSystemFont(ofSize: 15)
            consStackView.addArrangedSubview(label)
        }
    }
}
