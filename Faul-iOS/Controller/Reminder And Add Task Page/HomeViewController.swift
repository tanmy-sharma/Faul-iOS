//
//  HomeViewController.swift
//  Faul-iOS
//
//  Created by VarunMalhotra on 20/03/23.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet var tasks: UICollectionView!
    
    let task : [Reminder] = [Reminder(title: "First Day", date: "10/10/2020"),
                             Reminder(title: "Second Day", date: "10/10/2020"),
                             Reminder(title: "Third Day", date: "10/10/2020"),
                             Reminder(title: "Fourth Day", date: "10/10/2020"),
                             Reminder(title: "Fifth Day", date: "10/10/2020"),
                             Reminder(title: "Seventh Day", date: "10/10/2020")]
                             
     
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tasks.dataSource = self
        tasks.register(UINib(nibName: "ReminderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        

        // Do any additional setup after loading the view.
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        validateAuth()
//    }
//
//    private func validateAuth(){
//        if FirebaseAuth.Auth.auth().currentUser == nil{
//            navigationController?.popToRootViewController(animated: true)
//        }
//    }
}

extension HomeViewController :UICollectionViewDelegate,
UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return task.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let work = task[indexPath.row]
        
        let cell = tasks.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ReminderCollectionViewCell
        cell.titleLabel.text = work.title
        cell.dueDateLabel.text = work.date
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 10)/2
        
        return CGSize(width: size, height: size)
    }
    
    
}

