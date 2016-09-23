//
//  SearchViewExtension.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/23.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text: String = searchController.searchBar.text else { return }
        self.queryUserName(on: text)
    }
}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchViewCell
        cell.nameLabel.text = searches[indexPath.row].username
        cell.tabAction = { (cell) in
            let target: Search = self.searches[tableView.indexPath(for: cell)!.row]
            self.createRoom(search: target)
        }
        return cell
    }
}
