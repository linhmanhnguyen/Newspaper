//
//  HomeViewController.swift
//  NewspaperApp
//
//  Created by Nguyễn Mạnh Linh on 26/11/2023.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var banner: UICollectionView!
    
    var bannerData: [UIImage] = []
    var bannerTime: Timer?
    var currentBannerIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        banner.dataSource = self
        banner.delegate = self

        banner.register(UINib(nibName: "BannerCollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: "BannerCellIdentifier")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        banner.collectionViewLayout = layout
    }
    
    func loadBanner() {
        for i in 1...3 {
            let imgBannerName = "banner\(i)"
            if let imgBanner = UIImage(named: imgBannerName) {
                bannerData.append(imgBanner)
            }
        }
    }
    
    func startBannerTimer() {
        bannerTime = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [weak self] timer in
            guard let self = self else { return }
            self.currentBannerIndex = (self.currentBannerIndex + 1) % self.bannerData.count
            let nextIndexPath = IndexPath(item: self.currentBannerIndex, section: 0)
            self.banner.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        })
    }
    
    func stopBannerTimer() {
        bannerTime?.invalidate()
        bannerTime = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCellIdentifier", for: indexPath) as! BannerCollectionViewCell
        cell.imgBanner.image = bannerData[indexPath.item]
        return cell
    }
    

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 326, height: 172
        )
    }
    
}


