//
//  CoachPresenter.swift
//  StashCoach
//
//  Created by Kalpesh Solanki on 7/20/18.
//  Copyright © 2018 Kalpesh Solanki. All rights reserved.
//

import Foundation
import UIKit

class CoachPresenter: CoachPresentable {
    fileprivate weak var view: CoachViewable?
    fileprivate let interactor: CoachInteractable
    fileprivate let router: CoachRoutable
    
    init(view: CoachViewable, interactor: CoachInteractable, router: CoachRoutable) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension CoachPresenter: CoachReactable {
    func updateView() {
        interactor.fetchCoachInfo { [weak self] list in
            guard let title = list?.overview.title,
                  let achievements = list?.achievements
            else {
                return
            }
            
            var displayItems = [AchievementDisplayModel]()
            for achievement in achievements {
                guard let level = achievement.level,
                      let progress = achievement.progress,
                      let total = achievement.total,
                      let accessible = achievement.accessible
                else {
                    continue
                }
                
                var item = AchievementDisplayModel()
                item.achievementId = achievement.id
                item.levelText = "\(level)"
                item.progressBarLeftLabelText = "\(progress)"
                item.progressBarRightLabelText = "\(total)"
                item.progressBarRelativeWidth = CGFloat(progress) / CGFloat(total)
                item.userInteractionEnabled = accessible
                item.transparency = (accessible == true) ? 1.0: 0.4
                item.backgroundImageUrl = achievement.imageUrl
                displayItems.append(item)
            }
            self?.view?.update(title: title, achievementList: displayItems)
        }
    }
    
    func achievementSelected(forId id: Int) {
        print("Item \(id) Selected")
    }
    
    func infoButtonTapped() {
        router.presentInfoView()
    }
}
