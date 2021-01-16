//
//  EventApplicationViewController.swift
//  app
//
//  Created by Иван Лизогуб on 28.12.2020.
//  
//

import UIKit

final class EventApplicationViewController: UIViewController {
	private let output: EventApplicationViewOutput
    private var playerViewModels: [PlayerModel] = []

    private var applicationView: EventApplicationView {
        view as! EventApplicationView
    }

    init(output: EventApplicationViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = EventApplicationView(event: output.eventState(), onTapSite: output.onTapSite)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        setup()
	}

    private func setup() {
        applicationView.onTapApplicationButton = {[weak self] in
            self?.output.onTapApplication()
        }
        applicationView.startList.dataSource = self
    }
}

extension EventApplicationViewController: EventApplicationViewInput {
    func reloadView(players: [PlayerModel], elo: Int, participants: Int) {
        applicationView.footerCloud.eloLabel.text = String(elo)
        applicationView.footerCloud.participantsLabel.text = "👤 \(participants)"
        playerViewModels = players
        applicationView.startList.reloadData()
    }
}

extension EventApplicationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { playerViewModels.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "playerCell")
        let player = playerViewModels[indexPath.row]
        cell.textLabel?.text = player.name
        cell.textLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        if let rating = player.rating {
            cell.detailTextLabel?.text = String(rating)
            cell.detailTextLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        } else {
            cell.detailTextLabel?.text = ""
        }
        cell.imageView?.image = UIImage(systemName: "\(indexPath.row + 1).circle")
        cell.heightAnchor.constraint(equalToConstant: 50).isActive = true

        return cell
    }

    public func numberOfSections(in tableView: UITableView) -> Int { 1 }
}

