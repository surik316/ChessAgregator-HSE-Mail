//
//  SearchTournamentsPresenter.swift
//  app
//
//  Created by Иван Лизогуб on 21.11.2020.
//  
//

import Foundation

final class SearchTournamentsPresenter {
	weak var view: SearchTournamentsViewInput?
    weak var moduleOutput: SearchTournamentsModuleOutput?
    
	private let router: SearchTournamentsRouterInput
	private let interactor: SearchTournamentsInteractorInput

    private var sections: [EventViewModel] = []
    
    init(router: SearchTournamentsRouterInput, interactor: SearchTournamentsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SearchTournamentsPresenter: SearchTournamentsModuleInput {
}

extension SearchTournamentsPresenter: SearchTournamentsViewOutput {
    func refreshOnline() {
        interactor.refreshEvents()
    }

    func showInfo(event: EventViewModel) {
        router.showInfo(event: event)
    }

    func showApply() {
        router.showApply()
    }

    func configureView() {
        interactor.loadEvents()
    }
    
}

extension SearchTournamentsPresenter: SearchTournamentsInteractorOutput {
    func updateView(with events: [Tournament]) {
        let viewModels = EventParser.eventsToEventViewModel(events)
        view?.updateViewModels(with: viewModels)
    }
}

private extension SearchTournamentsPresenter {
    func makeViewModels(_ events: [Tournament]) -> [EventViewModel] {
        EventParser.eventsToEventViewModel(events)
    }
}