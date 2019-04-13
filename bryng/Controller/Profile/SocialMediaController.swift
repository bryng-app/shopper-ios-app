//
//  SocialMediaController.swift
//  bryng
//
//  Created by Florian Woelki on 13.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class SocialMediaController: ProfileBaseViewController {
    
    private let cellId = "cellId"
    
    private var socialMediaData = [SocialMediaModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillSocialMediaData()
        
        headerBackgroundColor = #colorLiteral(red: 0.9415884067, green: 0.9415884067, blue: 0.9415884067, alpha: 1)
        headerTitle = "Social Media"
        collectionView.backgroundColor = #colorLiteral(red: 0.9415884067, green: 0.9415884067, blue: 0.9415884067, alpha: 1)
        
        collectionView.register(SocialMediaCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func fillSocialMediaData() {
        let instagram = SocialMediaModel(name: "Instagram", image: UIImage(named: "instagram_icon")!, link: "https://www.instagram.com/bryngapp/")
        let facebook = SocialMediaModel(name: "Facebook", image: UIImage(named: "facebook_icon")!, link: "https://www.facebook.com/Bryng-2055104584607084/?ref=aymt_homepage_panel&eid=ARB0-O-32i1K4qS-YHg_QZD1RWhvVUg0wpslYjH_UhKLVvhcdzOieivMTY8bBDejqAxOC40Kp9kLyOHs")
        
        [instagram, facebook].forEach({socialMediaData.append($0)})
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SocialMediaCell
        let cellData = socialMediaData[indexPath.item]
        
        cell.nameLabel.text = cellData.name
        cell.imageView.image = cellData.image
        cell.link = cellData.link
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 24, left: 0, bottom: 24, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialMediaData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 125)
    }
    
}
