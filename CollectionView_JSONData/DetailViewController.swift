//
//  DetailViewController.swift
//  CollectionView_JSONData
//
//  Created by Bruna Fernanda Drago on 26/05/20.
//  Copyright © 2020 Bruna Fernanda Drago. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var jsonSpeedLabel: UILabel!
    @IBOutlet weak var jsonAttackLabel: UILabel!
    
    var hero1:Hero?
    var hero2 = [Hero]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        detailNameLabel.text = hero1?.localized_name
        jsonSpeedLabel.text = "\((hero1?.move_speed)!)"
        jsonAttackLabel.text = "\((hero1?.attack_range)!)"
        
        //downloaded the imageView
        let testeImage = (hero1?.img)!
        print(testeImage)
        let urlString = "https://api.opendota.com\(testeImage)"
        detailImageView.downloaded(from: urlString)
        
        //downloaded the icon
        let icon = (hero1?.icon)!
        print(icon)
        let urlIcon = "https://api.opendota.com\(icon)"
        iconImageView.downloaded(from: urlIcon)
        
        
       
        
    }


}
