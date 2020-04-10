//
//  File.swift
//  JetFuelTakeHomeProject
//
//  Created by Tayler Moosa on 4/8/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

struct CollectionViewLayouts {
    
        static func layout() -> UICollectionViewLayout {
            let layout = UICollectionViewCompositionalLayout {
                (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) //width and height of item relative to group
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.35))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem:item, count: 1)
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0) //Insets for each cell
                

                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous   // scrolling method
                section.interGroupSpacing = 5                      // distance between individual GROUPS within a SECTION
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

                
                            //set the header view
    //
                let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(100))

                let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: titleSize,
                    elementKind: PlugsVC.titleElementKind, alignment: .top)   //set this in the viewController
                section.boundarySupplementaryItems = [titleSupplementary]
                
                  return section
            }
            return layout
        }
    
}
