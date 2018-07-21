//
//  CoachModule.swift
//  StashCoach
//
//  Created by Solanki on 7/20/18.
//  Copyright © 2018 Kalpesh Solanki. All rights reserved.
//

import Foundation
import UIKit

class CoachNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class CoachModule: CoachRoutable {
    fileprivate var navigationController: CoachNavigationController?
    fileprivate var storyboard = UIStoryboard(name: "Coach", bundle: nil)

    func presentCoachView(forWindow window: UIWindow?) {
        guard let view = storyboard.instantiateViewController(withIdentifier: "CoachViewController") as? CoachViewController else {
            return
        }

        let interactor = CoachInteractor(dataService: CoachJSONDataServiceProvider())
        let presenter = CoachPresenter(view: view, interactor: interactor, router: self)
        view.presenter = presenter

        navigationController = CoachNavigationController(rootViewController: view)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
    }

    func presentInfoView() {
        print("Presenting info view")
    }
}
