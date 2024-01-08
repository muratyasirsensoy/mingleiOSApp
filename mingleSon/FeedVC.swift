//
//  FeedVC.swift
//  mingleSon
//
//  Created by Murat Yasir Sensoy on 2.01.2024.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage
import SDWebImageMapKit

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    var userNameArray = [String]()
    var userImageArray = [String]()
    var kitapNameArray = [String]()
    var kitapOzetArray = [String]()
    var sayfaSayıArray = [String]()
    
    var kullanıcıNameArray = [String]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "A") // Kendi resminin adını ekle
        backgroundImage.contentMode = .scaleAspectFill // İstediğin ölçekte görüntülemek için uygun olanı seç
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
    }
    
    func getDataFromFirestore() {
        
        let firestoreDatabase = Firestore.firestore()
        
        /*let settings = firestoreDatabase.settings // tarihi kaydetmek için ekstra ayar
        settings.areAnimationsEnabled = true
        firestoreDatabase.settings = settings*/ // bunu yapmama gerek olmadığı için kapattım
        
        firestoreDatabase.collection("Memories").order(by: "date", descending: true)/*tarihe göre sıralama*/.addSnapshotListener { snapshot, error in // sadece memories altındaki dökümanları almak istediğim için böyle yaptım eğer yan taraflarda başka sınıflar oluşturup almak isteseydim ekleyebilirdim
            if error != nil {
                print(error?.localizedDescription)
            }else {
                
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.userImageArray.removeAll(keepingCapacity: false) // loopa girmeden verileri temizler
                    self.userNameArray.removeAll(keepingCapacity: false)
                    self.kitapNameArray.removeAll(keepingCapacity: false)
                    self.sayfaSayıArray.removeAll(keepingCapacity: false)
                    self.kitapOzetArray.removeAll(keepingCapacity: false)
                    self.kullanıcıNameArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                       let documentID = document.documentID
                     
                        
                        if let postedBy = document.get("postedBy") as? String{
                            self.userNameArray.append(postedBy)
                        }
                        
                        if let postName = document.get("postName") as? String{
                            self.kitapNameArray.append(postName)
                            
                            
                        }
                        
                        if let postComment = document.get("postComment") as? String{
                            self.kitapOzetArray.append(postComment)
                            
                            
                        }
                        
                        if let postNumber = document.get("postNumber") as? String {
                            self.sayfaSayıArray.append(postNumber)
                        }
                        
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.userImageArray.append(imageUrl)
                        }
                        
                        if let postBy = document.get("postBy") as? String {
                            self.kullanıcıNameArray.append(postBy)
                        }
                        
                    }
                    
                    self.tableView.reloadData() // for loop bittikten sonra datayı yeniledim
                }
                
                
            }
        }
        
    }
    
    

    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
            
            cell.aciklamaLabel.text = sayfaSayıArray[indexPath.row]
            cell.isimLabel.text = kitapNameArray[indexPath.row]
            cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
            cell.ozetLabel.text = kitapOzetArray[indexPath.row]
            cell.anıLabel.text = userNameArray[indexPath.row]
        
        
        

        
        
            return cell
        
        
        }
    
    func tableView1(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! FeedCell
            
            cell1.aciklamaLabel.text = sayfaSayıArray[indexPath.row]
            cell1.isimLabel.text = kitapNameArray[indexPath.row]
            cell1.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
            cell1.ozetLabel.text = kitapOzetArray[indexPath.row]
            cell1.anıLabel.text = userNameArray[indexPath.row]
            
            return cell1
        
        
        }
    
    func tableView2(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! FeedCell
            
            cell2.aciklamaLabel.text = sayfaSayıArray[indexPath.row]
            cell2.isimLabel.text = kitapNameArray[indexPath.row]
            cell2.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
            cell2.ozetLabel.text = kitapOzetArray[indexPath.row]
            cell2.anıLabel.text = userNameArray[indexPath.row]
            
            return cell2
        }
    
    


    }
    
    





    
    
    
    

    

    

