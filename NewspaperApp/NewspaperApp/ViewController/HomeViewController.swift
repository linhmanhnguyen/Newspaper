//
//  HomeViewController.swift
//  NewspaperApp
//
//  Created by Nguyễn Mạnh Linh on 26/11/2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tblNews: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var banner: UICollectionView!
    
    var bannerData: [UIImage] = []
    var posts: [PostsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBackgroundColor(red: 32, green: 82, blue: 84, alpha: 1.0)
        
        banner.dataSource = self
        banner.delegate = self
        tblNews.dataSource = self
        tblNews.delegate = self

        banner.register(UINib(nibName: "BannerCollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: "BannerCellIdentifier")
        tblNews.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCellIdentifier")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        banner.collectionViewLayout = layout
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        loadBanner()
        callAPIGetPosts()
    }
    
    func loadBanner() {
        for i in 1...3 {
            let imgBannerName = "banner\(i)"
            print("\(imgBannerName)")
            if let imgBanner = UIImage(named: imgBannerName) {
                bannerData.append(imgBanner)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCellIdentifier", for: indexPath) as! BannerCollectionViewCell
        cell.imgBanner.image = bannerData[indexPath.item]
        return cell
    }
    
    func callAPIGetPosts() {
        APIHandler.init().getPosts{
            postsResponseData in
            self.posts = postsResponseData
            self.tblNews.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblNews.dequeueReusableCell(withIdentifier: "NewsCellIdentifier", for: indexPath) as! NewsTableViewCell
        let imgURL = URL(string: posts[indexPath.row].avatar)
        cell.newsImg.kf.setImage(with: imgURL)
        cell.newsTitle.text = posts[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350 , height: 175)
    }
    
}


