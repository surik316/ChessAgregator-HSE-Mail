
import UIKit

class ProfileRaw: AutoLayoutView {

    let mainView = UIView()
    let label = UILabel()
    let arrow = UIImageView(image: UIImage(systemName: "chevron.right"))

    init(name: String) {
        super.init(frame: .zero)

        label.text = name
        setup()
    }

    private func setup() {
        mainView.clipsToBounds = false
        mainView.layer.cornerRadius = 18
        mainView.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        arrow.translatesAutoresizingMaskIntoConstraints = false

        arrow.tintColor = .black
        mainView.addSubview(label)
        mainView.addSubview(arrow)
    }

    private var didSetupConstraints: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsUpdateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupConstraints() {
        super.setupConstraints()

        addSubview(mainView)

        NSLayoutConstraint.activate([
            mainView.heightAnchor.constraint(equalTo: superview!.heightAnchor),
            mainView.widthAnchor.constraint(equalTo: superview!.widthAnchor, constant: -8),
            mainView.centerXAnchor.constraint(equalTo: superview!.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: superview!.centerYAnchor),

            label.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),
            label.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),

            arrow.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -30),
            arrow.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            arrow.widthAnchor.constraint(equalToConstant: 18.0),
            arrow.heightAnchor.constraint(equalToConstant: 23.0)
        ])
    }
}
