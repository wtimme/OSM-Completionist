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
        return 0
    }
}
