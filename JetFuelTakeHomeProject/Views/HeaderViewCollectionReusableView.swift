//
//  HeaderViewCollectionReusableView.swift
//  JetFuelTakeHomeProject
//
//  Created by Tayler Moosa on 4/8/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class HeaderViewCollectionReusableView: UICollectionReusableView {
    
    var icon : UIImageView!
    var label : TitleLabel!
    var priceLabel : PriceLabel!
    static let reuseID = "HeaderID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func set(title: String, price: String, iconURL: String) {
        label.text = title
        priceLabel.text = price + " per install"
        getIcon(url: iconURL)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        label                                           = TitleLabel()
        priceLabel                                      = PriceLabel()
        label.text                                      = "Hey there"
        addSubview(priceLabel)
        addSubview(label)
        icon                                            = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints  = false
        icon.clipsToBounds                              = true
        icon.layer.cornerRadius                         = 10
        addSubview(icon)
        
        NSLayoutConstraint.activate([
            
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            icon.heightAnchor.constraint(equalToConstant: 60),
            icon.widthAnchor.constraint(equalToConstant: 60),
            
            label.topAnchor.constraint(equalTo: icon.topAnchor),
            label.bottomAnchor.constraint(equalTo: icon.centerYAnchor, constant: -1),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -1),
            
            priceLabel.topAnchor.constraint(equalTo: label.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -1),
            priceLabel.bottomAnchor.constraint(equalTo: icon.bottomAnchor)
        ])
        
    }
    
    private func getIcon(url: String) {
        NetworkManager.shared.getImage(url: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.icon.image = image
                }
            case .failure(_):
                print("sad panda")
            }
        }
    }
}
