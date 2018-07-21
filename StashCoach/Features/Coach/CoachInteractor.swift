//
//  CoachInteractor.swift
//  StashCoach
//
//  Created by Kalpesh Solanki on 7/20/18.
//  Copyright © 2018 Kalpesh Solanki. All rights reserved.
//

import Foundation

class CoachInteractor: CoachInteractable {
    fileprivate let dataService: CoachDataService
    fileprivate weak var presenter: CoachPresentable?
    
    init(dataService: CoachDataService) {
        self.dataService = dataService
    }
    
    func fetchCoachInfo(completionBlock: (AchievementList?) -> ()) {
        dataService.getAchievements(completionBlock: completionBlock)
    }
}
