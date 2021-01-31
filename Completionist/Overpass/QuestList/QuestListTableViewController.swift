//
//  QuestListTableViewController.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 1/4/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import UIKit

class QuestListTableViewController: UITableViewController {
    // MARK: Private properties

    private let viewModel = QuestListViewModel()
    private let itemCellReuseIdentifier = "ItemCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self

        title = NSLocalizedString("Quests",
                                  comment: "Title of the quest list")
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.numberOfItems()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: itemCellReuseIdentifier) {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: itemCellReuseIdentifier)

            cell.textLabel?.numberOfLines = 0
            cell.detailTextLabel?.numberOfLines = 0
        }

        guard let item = viewModel.item(at: indexPath.row) else {
            /// Without an `Item`, we cannot configure the cell.
            return cell
        }

        configure(cell: cell, with: item)

        return cell
    }

    override func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
        return 42
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath.row)

        tableView.deselectRow(at: indexPath, animated: true)
    }

    private func configure(cell: UITableViewCell, with item: QuestListViewModel.Item) {
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle

        if let imageName = item.imageName {
            cell.imageView?.image = UIImage(named: imageName)
        }

        switch item.accessory {
        case .checkmark:
            cell.accessoryType = .checkmark
        case .none:
            cell.accessoryType = .none
        }
    }
}

extension QuestListTableViewController: QuestListViewModelDelegate {
    func reloadItem(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)

        guard
            let cell = tableView.cellForRow(at: indexPath),
            let item = viewModel.item(at: index)
        else {
            /// Without a cell, there's nothing we can reload.
            return
        }

        configure(cell: cell, with: item)

        /// Selecting/deselecting a quest might cell its cell's size. Make sure all cells have the size they need.
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
