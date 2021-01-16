//
//  MyEventsProtocols.swift
//  app
//
//  Created by Иван Лизогуб on 08.12.2020.
//  
//

import Foundation

enum LoadingDataType {
	case nextPage
	case reload
}

protocol MyEventsModuleInput {
	var moduleOutput: MyEventsModuleOutput? { get }
}

protocol MyEventsModuleOutput: class {
}

protocol MyEventsViewInput: class {
	func updateCurrentView(with viewModels: [EventViewModel])
	func updateForthcomingView(with viewModels: [EventViewModel])
	func updateCompletedView(with viewModels: [EventViewModel])
}

protocol MyEventsViewOutput: class {
	func viewDidLoad()
	func willDisplay(at index: Int, segmentIndex: Int)
}

protocol MyEventsInteractorInput: class {
	func reload()
	func loadCompleted()
}

protocol MyEventsInteractorOutput: class {
	func didLoadCurrent(with events: [Tournament], loadType: LoadingDataType)
	func didLoadForthcoming(with events: [Tournament], loadType: LoadingDataType)
	func didLoadCompleted(with events: [Tournament], eventsCountInDB: Int, loadType: LoadingDataType)
}

protocol MyEventsRouterInput: class {
}
