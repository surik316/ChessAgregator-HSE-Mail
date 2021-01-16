import Foundation
import UIKit

final class ScrollableStackView: AutoLayoutView {

    var config: Config {
        didSet {
            self.setupStackView()
            self.setupScrollView()
        }
    }

    let scrollView = UIScrollView()
    let contentView = AutoLayoutView()
    private let stackView = UIStackView()

    var arrangedSubviews: [UIView] { self.stackView.arrangedSubviews }

    init(config: Config) {
        self.config = config

        super.init(frame: .zero)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(stackView)

        self.setupStackView()
        self.setupScrollView()
    }

    override func setupConstraints() {
        super.setupConstraints()

        self.scrollView.pins()
        self.contentView.pins()
        self.stackView.pins(config.pinsStackConstraints)

        if self.config.stack.axis == .vertical {
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        } else {
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor).isActive = true
        }
    }

    private func setupStackView() {
        self.stackView.axis = self.config.stack.axis
        self.stackView.distribution = self.config.stack.distribution
        self.stackView.alignment = self.config.stack.alignment
        self.stackView.spacing = self.config.stack.spacing
    }

    private func setupScrollView() {
        self.set(contentInset: self.config.scroll.contentInset)
        self.scrollView.alwaysBounceVertical = self.config.scroll.alwaysBounceVertical
        self.scrollView.alwaysBounceHorizontal = self.config.scroll.alwaysBounceHorizontal
        self.scrollView.showsHorizontalScrollIndicator = self.config.scroll.showsHorizontalScrollIndicator
        self.scrollView.showsVerticalScrollIndicator = self.config.scroll.showsVerticalScrollIndicator
    }

    func removeArrangedSubview(_ view: UIView) {
        self.stackView.removeArrangedSubview(view)
    }

    func addArrangedSubview(_ view: UIView) {
        self.stackView.addArrangedSubview(view)
    }

    func insertArrangedSubview(_ view: UIView, after afterView: UIView) {
        guard let index = self.arrangedSubviews.firstIndex(of: afterView) else {
            assertionFailure("view not found")
            self.addArrangedSubview(view)
            return
        }
        let afterIndex  = index + 1
        if afterIndex == self.arrangedSubviews.count {
            self.addArrangedSubview(view)
        }
        else {
            self.stackView.insertArrangedSubview(view, at: afterIndex)
        }
    }

    func setCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        self.stackView.setCustomSpacing(spacing, after: arrangedSubview)
    }

    func set(contentInset: UIEdgeInsets) {
        self.scrollView.contentInset = contentInset
    }

    func updateConstraintsStackView(contentInset: UIEdgeInsets) {

    }

}

extension ScrollableStackView {
    struct Config {
        struct Stack {
            let axis: NSLayoutConstraint.Axis
            var distribution: UIStackView.Distribution = .fill
            var alignment: UIStackView.Alignment = .fill
            var spacing: CGFloat = 0.0
        }
        struct Scroll {
            var contentInset: UIEdgeInsets = .zero
            var alwaysBounceVertical: Bool = false
            var alwaysBounceHorizontal: Bool = false
            var showsHorizontalScrollIndicator: Bool = true
            var showsVerticalScrollIndicator: Bool = true

            static let defaultVertical = Scroll(alwaysBounceVertical: true, showsHorizontalScrollIndicator: false)
            static let defaultHorizontal = Scroll(alwaysBounceHorizontal: true, showsHorizontalScrollIndicator: false, showsVerticalScrollIndicator: false)
        }

        var stack: Stack
        var scroll: Scroll
        var pinsStackConstraints: UIEdgeInsets = .zero

        static let defaultVertical = Config(stack: Stack(axis: .vertical),
                scroll: .defaultVertical
        )
        static let defaultHorizontal = Config(stack: Stack(axis: .horizontal),
                scroll: .defaultHorizontal
        )
    }
}