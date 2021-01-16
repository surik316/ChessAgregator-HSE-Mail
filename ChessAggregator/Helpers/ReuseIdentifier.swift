
import UIKit

protocol ReuseIdentifier {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifier {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifier {
}

extension UITableViewHeaderFooterView: ReuseIdentifier {
}

extension UICollectionReusableView: ReuseIdentifier {
}

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier,
                for: indexPath) as? T else {
            fatalError("ReuseIdentifier dequeueCell failed in CollectionView")
        }
        return cell
    }

    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        return self.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
}

extension UITableView {
    func dequeueCell<T: UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("ReuseIdentifier dequeueCell failed in TableView")
        }
        return cell
    }

    func register<T: UITableViewCell>(_ cellType: T.Type) {
        return self.register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
}