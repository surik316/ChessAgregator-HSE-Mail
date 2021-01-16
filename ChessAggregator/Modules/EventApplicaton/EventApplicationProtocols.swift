//
//  EventApplicationProtocols.swift
//  app
//
//  Created by Иван Лизогуб on 28.12.2020.
//  
//

import Foundation

protocol EventApplicationModuleInput {
	var moduleOutput: EventApplicationModuleOutput? { get }
}

protocol EventApplicationModuleOutput: class {
}

protocol EventApplicationViewInput: class {
	func reloadView(players: [PlayerModel], elo: Int, participants: Int)
}

protocol EventApplicationViewOutput: class {
	func onTapApplication()
	func onTapSite()
	func eventState() -> Tournament
}

protocol EventApplicationInteractorInput: class {
	func takePart()
	func requestEvent() -> Tournament
	func reloadData()
}

protocol EventApplicationInteractorOutput: class {
	func reloadData(players: [PlayerModel], elo: Int, participants: Int)
}

protocol EventApplicationRouterInput: class {
	func showSite(url: URL)
	func showApply()
}
