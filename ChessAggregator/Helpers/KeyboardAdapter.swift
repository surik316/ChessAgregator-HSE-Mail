//
// Created by Иван Лизогуб on 30.11.2020.
//

import UIKit

final class KeyboardAdapter {
    private let handler: (CGFloat, TimeInterval) -> Void
    weak var window: UIWindow?

    init(window: UIWindow?, handler: @escaping (CGFloat, TimeInterval) -> Void) {
        self.window = window
        self.handler = handler
    }

    func start() {
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardFrameChange),
                name: UIResponder.keyboardWillChangeFrameNotification,
                object: nil
        )

    }

    func stop() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardFrameChange(_ notification: Notification) {
        guard let keyboardSize: CGRect =
        (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            assertionFailure()
            return
        }
        guard let currentWindow = window else {
            assertionFailure()
            return
        }
        let duration = (notification
                .userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?
                .doubleValue ?? 0

        handler(currentWindow.frame.height - keyboardSize.origin.y, duration)
    }
}
