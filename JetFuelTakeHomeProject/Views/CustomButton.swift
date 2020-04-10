//
//  CustomButton.swift
//  JetFuelTakeHomeProject
//
//  Created by Tayler Moosa on 4/9/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(buttonImage: UIImage) {
        super.init(frame: .zero)
        configure()
        setImage(buttonImage, for: .normal)
        
    }
    
    private func configure() {
        backgroundColor                             = .white
        tintColor                                   = .systemGray2
        translatesAutoresizingMaskIntoConstraints   = false
        
    }

}
