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
        }
        
        let item = viewModel.item(at: indexPath.row)
        
        cell.textLabel?.text = item?.title
        cell.detailTextLabel?.text = item?.subtitle

        return cell
    }
}
