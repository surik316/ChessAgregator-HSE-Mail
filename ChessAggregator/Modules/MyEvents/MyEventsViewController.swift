//
//  MyEventsViewController.swift
//  app
//
//  Created by Иван Лизогуб on 08.12.2020.
//  
//

import UIKit

final class MyEventsViewController: UIViewController {
	private let output: MyEventsViewOutput

    private let items = UserSegments.allCases.map {$0.rawValue}
    private lazy var segmentedControl = UISegmentedControl(items: items)

    private let collectionViewLayout = UICollectionViewFlowLayout()
    private let collectionView: UICollectionView

    private var viewModels = [EventViewModel]()
    private var currentViewModels: [EventViewModel] = []
    private var forthcomingViewModels: [EventViewModel] = []
    private var completedViewModels: [EventViewModel] = []

    init(output: MyEventsViewOutput) {
        self.output = output
        collectionViewLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView()
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        self.view = view
        setupSegmentedControl()
        setupCollectionView()
        setupConstraints()
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        output.viewDidLoad()
	}

}

extension MyEventsViewController: MyEventsViewInput {

    func updateCurrentView(with viewModels: [EventViewModel]) {
        currentViewModels = viewModels
        if segmentedControl.selectedSegmentIndex == 0 {
            self.viewModels = currentViewModels
        }
        collectionView.reloadData()
    }

    func updateForthcomingView(with viewModels: [EventViewModel]) {
        forthcomingViewModels = viewModels
        if segmentedControl.selectedSegmentIndex == 1 {
            self.viewModels = forthcomingViewModels
        }
        collectionView.reloadData()
    }

    func updateCompletedView(with viewModels: [EventViewModel]) {
        completedViewModels = viewModels
        if segmentedControl.selectedSegmentIndex == 2 {
            self.viewModels = completedViewModels
        }
        collectionView.reloadData()
    }

}

extension MyEventsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = viewModels[indexPath.item]
        let cell = self.collectionView.dequeueCell(cellType: MyEventViewCell<EventCardView>.self, for: indexPath)
        cell.containerView.update(with: viewModel)
        return cell
    }
}

extension MyEventsViewController: UICollectionViewDelegate {

}

extension MyEventsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratio: CGFloat = 0.7
        let width = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
        let height = width * ratio
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20.0
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        output.willDisplay(at: indexPath.item, segmentIndex: segmentedControl.selectedSegmentIndex)
    }
}

private extension MyEventsViewController {
    func setupSegmentedControl() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.titleView = segmentedControl
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.register(MyEventViewCell<EventCardView>.self)
        collectionView.contentInset = UIEdgeInsets(top: 20.0, left: 13.0, bottom: 0.0, right: 13.0)
    }

    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        collectionView.pins()

    }

    @objc func segmentedControlValueChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            viewModels = currentViewModels
        case 1:
            viewModels = forthcomingViewModels
        case 2:
            viewModels = completedViewModels
        default:
            print("WTF segmented control should have only 3 values MyEventsVC")
        }
        collectionView.reloadData()
    }
}

enum UserSegments: String, CaseIterable {
    case current = "Текущие", forthcoming = "Предстоящие", completed = "Завершенные"
}
