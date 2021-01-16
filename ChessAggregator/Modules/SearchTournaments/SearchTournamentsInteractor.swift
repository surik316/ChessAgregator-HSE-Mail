//
//  SearchTournamentsInteractor.swift
//  app
//
//  Created by Иван Лизогуб on 21.11.2020.
//  
//

import Foundation
import Firebase

final class SearchTournamentsInteractor {
	weak var output: SearchTournamentsInteractorOutput?
	let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()

	init() {
		loadEvents()
	}
}

extension SearchTournamentsInteractor: SearchTournamentsInteractorInput {

	func refreshEvents() {
		loadEvents()
	}

	func loadEvents() {
		let currentDate = dateFormatter.string(from: Date())
		FirebaseRef.ref.child("Tournaments").queryOrdered(byChild: "openDate").queryStarting(atValue: currentDate).observeSingleEvent(of: .value, with: { [weak self] snapshot in
			let events = EventParser.eventsFromSnapshot(snapshot: snapshot) ?? []
			let filteredEvents = self?.makeEvents(events) ?? []
			self?.output?.updateView(with: filteredEvents)
		})
	}

	func makeEvents(_ events: [Tournament]) -> [Tournament] {
		let filteredEvents = filterToForthcoming(events)
		return sortByOpenDate(filteredEvents)
	}

	func filterToForthcoming(_ events: [Tournament]) -> [Tournament] {
		events.filter {
			$0.openDate > dateFormatter.string(from: Date())
		}
	}

	func sortByOpenDate(_ events: [Tournament]) -> [Tournament] {
		events.sorted {
			$0.openDate < $1.openDate
		}
	}
}