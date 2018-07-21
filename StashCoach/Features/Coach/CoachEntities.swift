//
//  CoachModels.swift
//  StashCoach
//
//  Created by Kalpesh Solanki on 7/20/18.
//  Copyright © 2018 Kalpesh Solanki. All rights reserved.
//

import Foundation

struct Achievement: Codable {
    var id: Int
    var level: String?
    var progress: Int?
    var total: Int?
    var imageUrl: String?
    var accessible: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case level
        case progress
        case total
        case imageUrl = "bg_image_url"
        case accessible
    }
}

struct Overview: Codable {
    var title: String?
}

struct AchievementList: Codable {
    var overview: Overview
    var achievements: [Achievement]?
}


