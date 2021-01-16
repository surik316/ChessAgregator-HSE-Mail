import UIKit

final class SearchTournamentsViewController: UIViewController {
	private let output: SearchTournamentsViewOutput
    private var viewModels: [EventViewModel] = []
    private var filteredSections: [EventViewModel] = []
    private var refreshControl = UIRefreshControl()

    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }

    private var isFiltered: Bool {
        searchController.isActive && !searchBarIsEmpty
    }

    private let collectionViewLayout = UICollectionViewFlowLayout()
    private let collectionView: UICollectionView

    private let searchController = UISearchController(searchResultsController: nil)

    init(output: SearchTournamentsViewOutput) {
        self.output = output
        collectionViewLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.addSubview(collectionView)
        setupCollectionView()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.configureView()

        navigationController?.isNavigationBarHidden = false

//        setupSearch()
    }


    @objc
    private func refresh() {
        output.refreshOnline()
        refreshControl.endRefreshing()
    }



}

extension SearchTournamentsViewController: SearchTournamentsViewInput {
    func updateViewModels(with viewModels: [EventViewModel]) {
        self.viewModels = viewModels
        collectionView.reloadData()
    }
    func updateFeed() {
        collectionView.reloadData()
    }

}

extension SearchTournamentsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.showInfo(event: viewModels[indexPath.item])
    }
}

extension SearchTournamentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = viewModels[indexPath.item]
        let cell = collectionView.dequeueCell(cellType: MyEventViewCell<EventCardView>.self, for: indexPath)
        cell.containerView.update(with: viewModel)
        return cell
    }


}

extension SearchTournamentsViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
        let height = CGFloat(228)
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20.0
    }
}

//extension SearchTournamentsViewController: UISearchResultsUpdating {
//
//    private func setupSearch() {
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Поиск"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//        searchController.searchBar.isHidden = false
//    }
//
//    private func setupFilter() {
//        //navigationController.but
//    }
//
//    private func filterContentForSearchText(searchText: String){
//        filteredSections = sections.filter({ (section: EventSectionModel) -> Bool in
//            section.event.name.lowercased().contains(searchText.lowercased())
//        })
//        collectionView.reloadData()
//    }
//
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchText: searchController.searchBar.text ?? "")
//    }
//}

private extension SearchTournamentsViewController {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyEventViewCell<EventCardView>.self)
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
    }

    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.pins()
    }
}