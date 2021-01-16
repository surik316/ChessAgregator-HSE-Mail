//
//  MyEventsPresenter.swift
//  app
//
//  Created by Иван Лизогуб on 08.12.2020.
//  
//

import Foundation

final class MyEventsPresenter {
	weak var view: MyEventsViewInput?
    weak var moduleOutput: MyEventsModuleOutput?
    
	private let router: MyEventsRouterInput
	private let interactor: MyEventsInteractorInput

    private var isReloading = false
    private var isNextPageLoading = false
    private var completedEvents: [Tournament] = []
    private var completedEventsInDatabaseCount: Int = 0
    
    init(router: MyEventsRouterInput, interactor: MyEventsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MyEventsPresenter: MyEventsModuleInput {
}

extension MyEventsPresenter: MyEventsViewOutput {
    func willDisplay(at index: Int, segmentIndex: Int) {
        guard segmentIndex == 2,
              !isReloading,
              !isNextPageLoading,
              (completedEvents.count - index) < 5,
              completedEvents.count < completedEventsInDatabaseCount else {
            return }
        isNextPageLoading = true
        interactor.loadCompleted()
    }

    func viewDidLoad() {
        isReloading = true
        interactor.reload()
        interactor.loadCompleted()
    }

}

extension MyEventsPresenter: MyEventsInteractorOutput {

    func didLoadCurrent(with events: [Tournament], loadType: LoadingDataType) {
        isReloading = false
        let viewModels = makeEventViewModels(events)
        view?.updateCurrentView(with: viewModels)
    }

    func didLoadForthcoming(with events: [Tournament], loadType: LoadingDataType) {
        isReloading = false
        let viewModels = makeEventViewModels(events)
        view?.updateForthcomingView(with: viewModels)
    }

    func didLoadCompleted(with events: [Tournament], eventsCountInDB: Int, loadType: LoadingDataType) {
        isNextPageLoading = false
        completedEventsInDatabaseCount = eventsCountInDB
        completedEvents = events
        let viewModels = makeEventViewModels(events)
        view?.updateCompletedView(with: viewModels)
    }

}

private extension MyEventsPresenter {
    func makeViewModels(_ events: [Tournament]) -> [MyEventViewModel] {
        let dateFormatter = DateFormatter()
        return events.map { event in
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let openDate = dateFormatter.date(from: event.openDate)
            let closeDate = dateFormatter.date(from: event.closeDate)
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return MyEventViewModel(
                    name: event.name,
                    image: "image",
                    tourType: event.mode.rawValue,
                    prize: String(event.prizeFund),
                    startDate: dateFormatter.string(from: openDate ?? Date()) + "-",
                    endDate: dateFormatter.string(from: closeDate ?? Date()),
                    location: event.location,
                    averageRating: "200",
                    participantsCount: String(event.participantsCount)
            )
        }
    }

    func makeEventViewModels(_ events: [Tournament]) -> [EventViewModel] {
        EventParser.eventsToEventViewModel(events)
    }


}