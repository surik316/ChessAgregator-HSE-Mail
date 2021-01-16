//
//  EventCreationProtocols.swift
//  ChessAggregator
//
//  Created by Administrator on 05.12.2020.
//  
//

import Foundation

protocol EventCreationModuleInput {
	var moduleOutput: EventCreationModuleOutput? { get }
}

protocol EventCreationModuleOutput: class {
}

protocol EventCreationViewInput: class {
    
    func showWarningName()
    func showWarningLocation()
    func showWarningTours()
    func showWarningRate()
    func showWarningSegment()
    
}

protocol EventCreationViewOutput: class {
    func createEvent(event: Tournament, index: Int, rateType: String?)
	func closeCreation()
	func showRules()
	func chooseMode(minutes: Int, seconds: Int, increment: Int) -> Mode
}

protocol EventCreationInteractorInput: class {
	func saveEvent(event: Tournament)
	func chooseMode(minutes: Int, seconds: Int, increment: Int) -> Mode
}

protocol EventCreationInteractorOutput: class {
    
}

protocol EventCreationRouterInput: class {
	func closeCreation()
	func showRules()
}
