//
//  SearchViewController.swift
//  NewspaperApp
//
//  Created by Nguyễn Mạnh Linh on 07/12/2023.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblSearch: UITableView!
    
    var postsData: [PostsModel] = []
    var filteredPostsData: [PostsModel] = []
    var postsSearchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblSearch.dataSource = self
        tblSearch.delegate = self
        searchBar.delegate = self
        tblSearch.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchPostsCellIdentifier")
        tblSearch.isHidden = true
        callAPIGetPosts()
    }
    func callAPIGetPosts() {
        APIHandler().getPosts{ postsResponseData in
            self.postsData = postsResponseData
            self.filteredPostsData = self.postsData
            self.tblSearch.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPostsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSearch.dequeueReusableCell(withIdentifier: "SearchPostsCellIdentifier") as! SearchTableViewCell
        cell.lblPostsTittle.text = filteredPostsData[indexPath.row].title
        cell.imgPosts.kf.setImage(with: URL(string: filteredPostsData[indexPath.row].avatar))

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredPostsData = postsData
            tblSearch.isHidden = true
        } else {
            filteredPostsData = postsData.filter { $0.title.uppercased().contains(searchText.uppercased()) }
            tblSearch.isHidden = filteredPostsData.isEmpty
        }
        tblSearch.reloadData()
    }

}
