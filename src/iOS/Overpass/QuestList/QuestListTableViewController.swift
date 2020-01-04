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

        title = NSLocalizedString("Quests",
                                  comment: "Title of the quest list")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        
        switch item.accessory {
        case .checkmark:
            cell.accessoryType = .checkmark
        case .none:
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
