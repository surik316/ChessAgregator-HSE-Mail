//
//  ForgotPasswordRouter.swift
//  ChessAggregator
//
//  Created by Гарик  on 06.12.2020.
//


import UIKit
import FlagPhoneNumber

final class ForgotPasswordRouter: BaseRouter {
    weak var listController: FPNCountryListViewController?
}

extension ForgotPasswordRouter: ForgotPasswordRouterInput {
    func showCountryList() {
        guard let listVC = listController else {fatalError("wtf no listController")}
        let navVC = UINavigationController(rootViewController: listVC)
        navigationController?.present(navVC, animated: true, completion: nil)
    }

}
