//
//  EventCreationPresenter.swift
//  ChessAggregator
//
//  Created by Administrator on 05.12.2020.
//  
//

import Foundation

final class EventCreationPresenter {
	weak var view: EventCreationViewInput?
    weak var moduleOutput: EventCreationModuleOutput?
    
	private let router: EventCreationRouterInput
	private let interactor: EventCreationInteractorInput
    
    init(router: EventCreationRouterInput, interactor: EventCreationInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventCreationPresenter: EventCreationModuleInput {
}

extension EventCreationPresenter: EventCreationViewOutput {
    func chooseMode(minutes: Int, seconds: Int, increment: Int) -> Mode {
        interactor.chooseMode(minutes: minutes, seconds: seconds, increment: increment)
    }

    func showRules() {
        router.showRules()
    }

    func createEvent(event: Tournament,index: Int, rateType: String?) {
        if (ErrorName(string: event.name) || ErrorLocation(string: event.location) || ErrorTours(count: event.tours) || ErrorRatingType(string: event.ratingType.rawValue) || ErrorSegment(index: index)) {
           showWarnings(tournament: event, segment: index, rateType: rateType)
        }
        else{
            interactor.saveEvent(event: event)
            router.closeCreation()
        }
    }

    func closeCreation() {
        router.closeCreation()
    }

}

extension EventCreationPresenter: EventCreationInteractorOutput {
}

private extension EventCreationPresenter{
    func ErrorName(string: String)->Bool{
        if string == "" {
            return true
        }
        else{
            return false
        }
    }
    func ErrorLocation(string: String)->Bool{
        if string == "" {
            return true
        }
        else{
            return false
        }
    }
    func ErrorTours(count: Int)->Bool{
        if count < 1{
            return true
        }
        else{
            return false
        }
    }
    func ErrorRatingType(string: String?)->Bool{
        if string == "" {
            return true
        }
        else{
            return false
        }
    }
    func ErrorSegment(index: Int)->Bool{
        if index == -1 {
            return true
        }
        else{
            return false
        }
    }
}
private extension EventCreationPresenter{
    func showWarnings(tournament: Tournament, segment: Int, rateType: String?){
        if ErrorName(string: tournament.name){
            view?.showWarningName()
        }
        if ErrorLocation(string: tournament.location){
            view?.showWarningLocation()
        }
        if ErrorTours(count: tournament.tours){
            view?.showWarningTours()
        }
        if ErrorRatingType(string: rateType){
            view?.showWarningRate()
        }
        if ErrorSegment(index: segment){
            view?.showWarningSegment()
        }
    }
}
