//
//  CoachDataAccess.swift
//  StashCoach
//
//  Created by Kalpesh Solanki on 7/20/18.
//  Copyright © 2018 Kalpesh Solanki. All rights reserved.
//

import Foundation

protocol CoachDataService {
    func getAchievements(completionBlock: (AchievementList?) -> ())
}

class CoachJSONDataServiceProvider: CoachDataService {
    func getAchievements(completionBlock: (AchievementList?) -> ()) {
        guard let path = Bundle.main.path(forResource: "achievements", ofType: "json") else {
            completionBlock(nil)
            return
        }
        
        var list: AchievementList?
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            list = try? JSONDecoder().decode(AchievementList.self, from: data)
        }
        completionBlock(list)
    }
}
