//
// Created by Николай Пучко on 10.01.2021.
//

import UIKit

class StableTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
    }
}