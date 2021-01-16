//
//  MyEventsInteractor.swift
//  app
//
//  Created by Иван Лизогуб on 08.12.2020.
//  
//

import Firebase

final class MyEventsInteractor {
	weak var output: MyEventsInteractorOutput?

	private var userId: String

	private var page = Constants.initialPage
	private var eventCount: Int  {
		get { page * 10 }
	}
	private var completedEventsCount = 0

	private let dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		return dateFormatter
	}()
	
	init() {
		userId = Auth.auth().currentUser!.uid
	}
}

extension MyEventsInteractor: MyEventsInteractorInput {
	func reload() {
		FirebaseRef.ref.child("Users/\(userId)/tournaments").observe(.value) { [weak self]
			(snapshot) in
			FirebaseRef.ref.child("Tournaments")
					.queryOrdered(byChild: "participants/\(self?.userId ?? "")").queryEqual(toValue: true)
					.observeSingleEvent(of: .value) { (snapshot) in
						if let events = EventParser.eventsFromSnapshot(snapshot: snapshot) {
							let currentEvents = self?.makeCurrent(events: events) ?? []
							let forthcomingEvents = self?.makeForthcoming(events: events) ?? []
							self?.output?.didLoadCurrent(with: currentEvents, loadType: .reload)
							self?.output?.didLoadForthcoming(with: forthcomingEvents, loadType: .reload)
						}
					}
		}
	}

	func loadCompleted() {
		FirebaseRef.ref.child("Tournaments")
				.queryOrdered(byChild: "participants/\(userId)").queryEqual(toValue: true)
				.observeSingleEvent(of: .value) { [weak self] (snapshot) in
					if let events = EventParser.eventsFromSnapshot(snapshot: snapshot) {
						let completedEvents = self?.makeCompleted(events: events) ?? []
						self?.output?.didLoadCompleted(
								with: completedEvents,
								eventsCountInDB: self?.completedEventsCount ?? 0,
								loadType: self?.page ?? 1 == Constants.initialPage ? .reload: .nextPage)
						self?.page += 1
					}
				}
	}
}

private extension MyEventsInteractor {

	func makeCurrent(events: [Tournament]) -> [Tournament] {
		let filteredCurrent = filterCurrent(events: events)
		return orderByOpenDateAscending(events: filteredCurrent)
	}

	func makeForthcoming(events: [Tournament]) -> [Tournament] {
		let filteredForthcoming = filterForthcoming(events: events)
		return orderByOpenDateAscending(events: filteredForthcoming)
	}

	func makeCompleted(events: [Tournament]) -> [Tournament] {
		let filteredCompleted = filterCompleted(events: events)
		return orderByOpenDateDescending(events: filteredCompleted)
	}

	func filterCurrent(events: [Tournament]) -> [Tournament] {
		events.filter { $0.closeDate >= dateFormatter.string(from: Date()) && $0.openDate <= dateFormatter.string(from: Date()) }
	}

	func filterForthcoming(events: [Tournament]) -> [Tournament] {
		events.filter { $0.openDate > dateFormatter.string(from: Date()) }
	}

	func filterCompleted(events: [Tournament]) -> [Tournament] {
		//TODO: улучшить фильтр
		let filteredEvents: [Tournament] = events.filter { $0.closeDate < dateFormatter.string(from: Date()) }
		completedEventsCount = filteredEvents.count
		return Array(filteredEvents.prefix(eventCount))
	}

	func orderByOpenDateAscending(events: [Tournament]) -> [Tournament] {
		events.sorted { $0.openDate < $1.openDate }
	}

	func orderByOpenDateDescending(events: [Tournament]) -> [Tournament] {
		events.sorted { $0.openDate > $1.openDate }
	}

}

private enum Constants {
	static let initialPage = 1
}