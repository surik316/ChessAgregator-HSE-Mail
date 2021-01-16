//
//  EventApplicationPresenter.swift
//  app
//
//  Created by Иван Лизогуб on 28.12.2020.
//  
//

import Foundation

final class EventApplicationPresenter {
	weak var view: EventApplicationViewInput?
    weak var moduleOutput: EventApplicationModuleOutput?
    
	private let router: EventApplicationRouterInput
	private let interactor: EventApplicationInteractorInput
    
    init(router: EventApplicationRouterInput, interactor: EventApplicationInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventApplicationPresenter: EventApplicationModuleInput {
}

extension EventApplicationPresenter: EventApplicationViewOutput {

    func onTapSite() {
        router.showSite(url: interactor.requestEvent().url)
    }

    func eventState() -> Tournament {
        interactor.requestEvent()
    }

    func onTapApplication() {
        interactor.takePart()
        router.showApply()
    }

}

extension EventApplicationPresenter: EventApplicationInteractorOutput {
    func reloadData(players: [PlayerModel], elo: Int, participants: Int) {
        view?.reloadView(
                players: players,
                elo: elo,
                participants: participants
        )
    }
}
