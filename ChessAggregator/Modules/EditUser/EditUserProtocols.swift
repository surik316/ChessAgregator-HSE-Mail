//
//  EditUserProtocols.swift
//  app
//
//  Created by Administrator on 10.12.2020.
//  
//

import Foundation

protocol EditUserModuleInput {
	var moduleOutput: EditUserModuleOutput? { get }
}

protocol EditUserModuleOutput: class {
	var currentUser: User { get set }
}

protocol EditUserViewInput: class {
}

protocol EditUserViewOutput: class {
	func close()
	func editUser(with user: User)
	func userState() -> User
}

protocol EditUserInteractorInput: class {
	func saveChanges(with user: User)
}

protocol EditUserInteractorOutput: class {
}

protocol EditUserRouterInput: class {
	func close()
}
