//
//  PriceLabel.swift
//  JetFuelTakeHomeProject
//
//  Created by Tayler Moosa on 4/8/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class PriceLabel: UILabel {

        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func configure() {
            textAlignment                               = .left
            font                                        = UIFont.systemFont(ofSize: 18, weight: .regular)
            textColor                                   = .systemGreen
            translatesAutoresizingMaskIntoConstraints   = false
            
        }

    
}
