//
//  SearchTournamentsRouter.swift
//  app
//
//  Created by Иван Лизогуб on 21.11.2020.
//  
//

import UIKit
import SafariServices

final class SearchTournamentsRouter: BaseRouter {
     //TODO: номер телефона

}

extension SearchTournamentsRouter: SearchTournamentsRouterInput {
    func showInfo(event: EventViewModel) {
        let context = EventApplicationContext(moduleOutput: nil, tournament: event.event)
        let container = EventApplicationContainer.assemble(with: context)
        navigationController?.pushViewController(container.viewController, animated: true)
    }

    func showApply() {
        let applyAlert = UIAlertController(title: "Заявка подана!", message: nil, preferredStyle: .alert)
        navigationController?.present(applyAlert, animated: true) {
            applyAlert.view.superview?.isUserInteractionEnabled = true
            applyAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(
            self.didTapToDismiss)))
        }
    }

}

private extension SearchTournamentsRouter {
    @objc
    func didTapToDismiss() {
        navigationController?.dismiss(animated: true)
        navigationController?.tabBarController?.selectedIndex = 0
    }
}
