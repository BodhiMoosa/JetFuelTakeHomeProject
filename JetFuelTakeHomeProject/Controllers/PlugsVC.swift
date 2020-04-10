//
//  PlugsVC.swift
//  JetFuelTakeHomeProject
//
//  Created by Tayler Moosa on 4/8/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit



class PlugsVC: UIViewController {
    var isViewReady = false
    var localData : [Campaign] = []
    var datasource : UICollectionViewDiffableDataSource<Campaign,Media>!
    var currentSnapshot : NSDiffableDataSourceSnapshot<Campaign,Media>!
    static let titleElementKind = "title-element-kind"
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configure()
        configureCollectionView()
        getData()
        configureCollectionViewDataSource()
      
        
    }
    

    private func configure() {
        view.backgroundColor = .systemBackground
    }
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayouts.layout())
        collectionView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        collectionView.register(PlugsCell.self, forCellWithReuseIdentifier: PlugsCell.reuseID)
        collectionView.register(HeaderViewCollectionReusableView.self, forSupplementaryViewOfKind: PlugsVC.titleElementKind, withReuseIdentifier: HeaderViewCollectionReusableView.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureCollectionViewDataSource() {
        datasource = UICollectionViewDiffableDataSource<Campaign,Media>(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, campaign) -> PlugsCell? in
            guard let self = self, let snapshot = self.currentSnapshot else { return nil }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlugsCell.reuseID, for: indexPath) as! PlugsCell
            let campaign = snapshot.sectionIdentifiers[indexPath.section]
            cell.set(coverPhotoURL: campaign.medias[indexPath.row].coverPhotoUrl, downloadLink: campaign.medias[indexPath.row].downloadUrl, trackingLink: campaign.medias[indexPath.row].trackingLink, isVideo: campaign.medias[indexPath.row].mediaType == "video")
            return cell
        })
        
        datasource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let self = self, let snapshot = self.currentSnapshot else { return nil }
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderViewCollectionReusableView.reuseID, for: indexPath) as? HeaderViewCollectionReusableView {
                let campaign = snapshot.sectionIdentifiers[indexPath.section]
                headerView.set(title: campaign.campaignName, price: campaign.payPerInstall, iconURL: campaign.campaignIconUrl)
                return headerView
            } else {
                fatalError()
            }
        }
        updateData()
    }
    
    private func updateData() {
        currentSnapshot = NSDiffableDataSourceSnapshot<Campaign,Media>()
        localData.forEach {
            let campaign = $0
            currentSnapshot.appendSections([campaign])
            currentSnapshot.appendItems(campaign.medias)
        }
        datasource.apply(currentSnapshot)
        
    }
    
    private func getData() {
        displayLoadingView()
        collectionView.isScrollEnabled = false
        NetworkManager.shared.getPlugs { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let welcome):
                self.localData = welcome.campaigns
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.updateData()
                    self.dismissLoadingView()
                    self.collectionView.isScrollEnabled = true
                }

            case .failure(_):
                print("help")
            }
        }
    }
}


extension PlugsVC : UICollectionViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if collectionView.contentOffset.y < 0 {
            getData()
        }
    }
}
