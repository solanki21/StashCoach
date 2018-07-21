//
//  CoachProtocols.swift
//  StashCoach
//
//  Created by Kalpesh Solanki on 7/20/18.
//  Copyright © 2018 Kalpesh Solanki. All rights reserved.
//
import UIKit
import Foundation

// Presenter -> View
protocol CoachViewable: class {
    func update(title: String, achievementList: [AchievementDisplayModel])
}

// View -> Presenter
protocol CoachReactable: class {
    func updateView()
    func achievementSelected(forId id: Int)
    func infoButtonTapped()
}

// Interactor -> Presenter
protocol CoachPresentable: class {}

// Presenter -> Interactor
protocol CoachInteractable: class {
    func fetchCoachInfo(completionBlock: (AchievementList?) -> ())
}

// Presenter -> Router
protocol CoachRoutable: class {
    func presentInfoView()
}

struct AchievementDisplayModel {
    var achievementId: Int
    var levelText: String
    var progressBarLeftLabelText: String
    var progressBarRightLabelText: String
    var progressBarRelativeWidth: CGFloat
    var backgroundImageUrl: String?
    var userInteractionEnabled: Bool
    var transparency: CGFloat
    
    init() {
        achievementId = 0
        levelText = ""
        progressBarLeftLabelText = ""
        progressBarRightLabelText = ""
        progressBarRelativeWidth = 0
        backgroundImageUrl = ""
        userInteractionEnabled = false
        transparency = 0.0
    }
}

