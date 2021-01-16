//
//  EventCreationInteractor.swift
//  ChessAggregator
//
//  Created by Administrator on 05.12.2020.
//  
//

import Foundation

final class EventCreationInteractor {
	weak var output: EventCreationInteractorOutput?
}

extension EventCreationInteractor: EventCreationInteractorInput {
	func saveEvent(event: Tournament) {

		guard let key = FirebaseRef.ref.child("Tournaments").childByAutoId().key else {
			print("No auto id!")
			return
		}
		let tournament =
				["openDate" : event.openDate,
				 "closeDate" : event.closeDate,
				 "fee" : event.fee,
				 "location" : event.location,
				 "tours" : event.tours,
				 "minutes" : event.minutes,
				 "seconds" : event.seconds,
				 "increment" : event.increment,
				 "mode" : event.mode.rawValue,
				 "prizeFund" : event.prizeFund,
				 "ratingType" : event.ratingType.rawValue,
				 "url" : event.url.description,
				 "organizerId" : event.organizerId,
				 "name" : event.name
				] as [String: Any]
		if (event.name.isEmpty || event.tours < 1 ||  event.ratingType.rawValue.isEmpty ) {
			print ("111")
		}

		let childUpdates = ["/Tournaments/\(key)" : tournament]
		FirebaseRef.ref.updateChildValues(childUpdates)
	}

	func chooseMode(minutes: Int, seconds: Int, increment: Int) -> Mode {
		let totalTime = minutes * 60 + seconds + increment * 60
		switch totalTime {
		case 60...180:
			return .bullet
		case 181...600:
			return .blitz
		case 601..<3600:
			return .rapid
		default:
			return .classic
		}
	}
}

//extension EventCreationInteractor {
//	private func initEvent() -> Tournament {
//		Tournament(id: "5", name: "Moscow open",
//				date: "10.02.2021", location: "Moscow",
//				ratingType: .fide, prizeFund: 2000000,
//				fee: 5000, url: URL(string: "https://ru.wikipedia.org/wiki/Moscow_Chess_Open")!)
//	}
//}
