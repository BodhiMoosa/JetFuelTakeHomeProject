//
//  PlugsCell.swift
//  JetFuelTakeHomeProject
//
//  Created by Tayler Moosa on 4/8/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class PlugsCell: UICollectionViewCell {
    var trackingLink : String!
    var downloadLink : String!
    var buttonView : UIView!
    var dividerView : UIView!
    var coverPhoto : UIImageView!
    var coverPhotoOverlay : UIView!
    var image : UIImageView!
    var stackView : UIStackView!
    var playButton      = UIImageView(image: UIImage(systemName: "play.fill"))
    var isVideo         = false
    var copyButton      = CustomButton(buttonImage: UIImage(systemName: "link")!)
    var downloadButton  = CustomButton(buttonImage: UIImage(systemName: "arrow.down")!)
    static let reuseID  = "PlugsCell"


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    func set(coverPhotoURL: String, downloadLink: String, trackingLink: String, isVideo: Bool) {
        self.downloadLink = downloadLink
        self.trackingLink = trackingLink
        getCoverPhoto(url: coverPhotoURL)
        if !isVideo {
            coverPhotoOverlay.isHidden = true
        }
    }
    
    private func configureOverlay() {
        coverPhotoOverlay = UIView()
        coverPhotoOverlay.translatesAutoresizingMaskIntoConstraints = false
        coverPhoto.addSubview(coverPhotoOverlay)
        coverPhotoOverlay.backgroundColor = UIColor.systemGray.withAlphaComponent(0.65)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.tintColor = .white
        coverPhotoOverlay.addSubview(playButton)
    }
    
    private func configure() {
        backgroundColor = .clear
        setCoverView()
        setBothButtons()
        setCollectiveButtonView()
        configureOverlay()
        setAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setCoverView() {
        coverPhoto = UIImageView()
        coverPhoto.translatesAutoresizingMaskIntoConstraints = false
        coverPhoto.clipsToBounds = true
        coverPhoto.layer.cornerRadius = 10
        addSubview(coverPhoto)
    }
    
    
    private func setBothButtons() {
        downloadButton.addTarget(self, action: #selector(downloadButtonClick), for: .touchUpInside)
        copyButton.addTarget(self, action: #selector(copyLinkToClipboard), for: .touchUpInside)

    }
    
    private func setCollectiveButtonView() {
        buttonView                                              = UIView()
        buttonView.addSubview(copyButton)
        buttonView.addSubview(downloadButton)
        dividerView                                             = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints   = false
        buttonView.addSubview(dividerView)
        dividerView.backgroundColor                             = .systemGray
        buttonView.translatesAutoresizingMaskIntoConstraints    = false
        buttonView.layer.borderWidth                            = 1
        buttonView.layer.borderColor                            = UIColor.lightGray.cgColor
        buttonView.clipsToBounds                                = true
        buttonView.layer.cornerRadius                           = 8
        addSubview(buttonView)
    }
    
    private func setAllConstraints() {
        NSLayoutConstraint.activate([
            
            coverPhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            coverPhoto.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            coverPhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            buttonView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            buttonView.topAnchor.constraint(equalTo: coverPhoto.bottomAnchor, constant: 5),
            buttonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            buttonView.heightAnchor.constraint(equalToConstant: 50),
            
            copyButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
            copyButton.topAnchor.constraint(equalTo: buttonView.topAnchor),
            copyButton.trailingAnchor.constraint(equalTo: buttonView.centerXAnchor),
            copyButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
            
            dividerView.leadingAnchor.constraint(equalTo: copyButton.trailingAnchor),
            dividerView.heightAnchor.constraint(equalTo: buttonView.heightAnchor),
            dividerView.widthAnchor.constraint(equalToConstant: 1),
            dividerView.centerYAnchor.constraint(equalTo: copyButton.centerYAnchor),
            
            downloadButton.leadingAnchor.constraint(equalTo: dividerView.trailingAnchor),
            downloadButton.topAnchor.constraint(equalTo: buttonView.topAnchor),
            downloadButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor),
            downloadButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
            
            coverPhotoOverlay.topAnchor.constraint(equalTo: coverPhoto.topAnchor),
            coverPhotoOverlay.bottomAnchor.constraint(equalTo: coverPhoto.bottomAnchor),
            coverPhotoOverlay.leadingAnchor.constraint(equalTo: coverPhoto.leadingAnchor),
            coverPhotoOverlay.trailingAnchor.constraint(equalTo: coverPhoto.trailingAnchor),
            
            playButton.centerYAnchor.constraint(equalTo: coverPhotoOverlay.centerYAnchor),
            playButton.centerXAnchor.constraint(equalTo: coverPhotoOverlay.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 25),
            playButton.widthAnchor.constraint(equalToConstant: 25)
            
        ])
    }
    
    private func getCoverPhoto(url: String) {
        NetworkManager.shared.getImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.coverPhoto.image = image
                }
            case .failure(_):
                print("uh oh")
            }
        }
    }
    
    @objc private func downloadButtonClick() {
        NetworkManager.shared.downloadData(url: downloadLink)
    }
    
    @objc private func copyLinkToClipboard() {
        UIPasteboard.general.string = trackingLink
    }
}
