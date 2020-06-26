//
//  ViewController.swift
//  CollectionView_JSONData
//
//  Created by Bruna Fernanda Drago on 26/05/20.
//  Copyright © 2020 Bruna Fernanda Drago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView1: UICollectionView!
    
    var heroes = [Hero]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView1.register(nibCell, forCellWithReuseIdentifier: "customCell")
        
        collectionView1.delegate = self
        collectionView1.dataSource = self
        
        //Fazendo o PARSE dos dados da API
        let urlJsonString = "https://api.opendota.com/api/heroStats"
        
        let url = URL(string: urlJsonString)
        
        guard url != nil else {
            print("Erro na URL")
            return
        }
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            
            do{
                self.heroes =  try JSONDecoder().decode([Hero].self, from: data)
                print(self.heroes)
                
            }catch let jsonErr{
                print("Error : \(jsonErr)")
            }
            DispatchQueue.main.async {
                print(self.heroes.count)
                self.collectionView1.reloadData()
            }
            
        }.resume()
        
    }
    
}

extension ViewController :UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
        
        
        cell.labelName.text = heroes[indexPath.row].localized_name
        
        //Download the image
        let urlDefault = "https://api.opendota.com/"
        let urlImg = heroes[indexPath.row].img
        let urlTeste = "https://api.opendota.com\(urlImg)"
        cell.PerfilImageView.downloaded(from: urlTeste)
        
        
        //Customize the image
        cell.PerfilImageView.clipsToBounds = true
        cell.PerfilImageView.layer.cornerRadius = cell.PerfilImageView.frame.height/2
        cell.PerfilImageView.contentMode = .scaleToFill
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = heroes[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: hero)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController{
            destination.hero1 = sender as? Hero
        }
    }

}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
