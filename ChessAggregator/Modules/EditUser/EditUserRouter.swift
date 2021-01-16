//
//  EditUserRouter.swift
//  app
//
//  Created by Administrator on 10.12.2020.
//  
//

import UIKit

final class EditUserRouter: BaseRouter {
}

extension EditUserRouter: EditUserRouterInput {
    func close() {
        navigationController?.popToRootViewController(animated: true)
    }
}
