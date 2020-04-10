//
//  APIData.swift
//  JetFuelTakeHomeProject
//
//  Created by Tayler Moosa on 4/8/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import Foundation

struct Welcome : Codable, Hashable {
    let campaigns: [Campaign]
}

// MARK: - Campaign
struct Campaign : Codable, Hashable {
    let id: Int
    let campaignName: String
    let campaignIconUrl: String
    let payPerInstall: String
    let medias: [Media]
}

// MARK: - Media
struct Media : Codable, Hashable {
    let coverPhotoUrl: String
    let downloadUrl: String
    let trackingLink: String
    let mediaType: String
}


