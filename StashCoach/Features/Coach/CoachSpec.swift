//
//  CoachSpec.swift
//  StashCoach
//
//  Created by Solanki on 7/20/18.
//  Copyright © 2018 Kalpesh Solanki. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import StashCoach

class CoachInteractorSpec: QuickSpec {
    override func spec() {
        var subject: CoachInteractor!
        var dataServiceMock: CoachDataServiceMock!


        beforeEach {
            dataServiceMock = CoachDataServiceMock()
            subject = CoachInteractor(dataService: dataServiceMock)
        }

        describe("fetchCoachInfo") {
            beforeEach {
                subject.fetchCoachInfo(completionBlock: {_ in })
            }

            it("calls data service") {
                expect(dataServiceMock.didCallGetAchievements) == true
            }
        }
    }
}


class CoachPresenterSpec: QuickSpec {
    override func spec() {
        var subject: CoachPresenter!
        var viewMock: CoachViewMock!
        var interactorMock: CoachInteractorMock!
        var routerMock: CoachRouterMock!

        beforeEach {
            viewMock = CoachViewMock()
            interactorMock = CoachInteractorMock()
            routerMock = CoachRouterMock()
            subject = CoachPresenter(view: viewMock, interactor: interactorMock, router: routerMock)
        }

        describe("updateView") {
            beforeEach {
                subject.updateView()
            }
            it("fetches data from the interactor and updates the view") {
                expect(interactorMock.didCallFetchCoachInfo) == true
                expect(viewMock.didCallUpdateAchievementList) == true
            }
        }

        describe("achievementSelected") {
            beforeEach {
                subject.achievementSelected(forId: 1)
            }
            // Nothing to test yet
        }

        describe("infoButtonTapped") {
            beforeEach {
                subject.infoButtonTapped()
            }
            it("calls router to present info view") {
                expect(routerMock.didCallPresentInfoView) == true
            }
        }
    }
}

// Mocks
class CoachViewMock: CoachViewable {

    var didCallUpdateAchievementList = false
    func update(title: String, achievementList: [AchievementDisplayModel]) {
        didCallUpdateAchievementList = true
    }
}

class CoachPresenterMock: CoachReactable, CoachPresentable {

    var didCallUpdateView = false
    func updateView() {
        didCallUpdateView = true
    }

    var didCallAchievementSelected = false
    func achievementSelected(forId id: Int) {
        didCallAchievementSelected = true
    }

    var didCallInfoButtonTapped = false
    func infoButtonTapped() {
        didCallInfoButtonTapped = true
    }
}

class CoachInteractorMock: CoachInteractable {

    var didCallFetchCoachInfo = false
    func fetchCoachInfo(completionBlock: (AchievementList?) -> ()) {
        didCallFetchCoachInfo = true
        completionBlock(AchievementList(overview: Overview(title: "title"), achievements: [Achievement]()))
    }
}

class CoachRouterMock: CoachRoutable {

    var didCallPresentInfoView = false
    func presentInfoView() {
        didCallPresentInfoView = true
    }
}

class CoachDataServiceMock: CoachDataService {

    var didCallGetAchievements = false
    func getAchievements(completionBlock: (AchievementList?) -> ()) {
        didCallGetAchievements = true
    }
}

