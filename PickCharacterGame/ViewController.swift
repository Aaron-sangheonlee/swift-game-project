//
//  ViewController.swift
//  PickCharacterGame
//
//  Created by 이상헌 on 2021/07/31.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    let subview = UIView()
    let background = UIImageView()
    
    @objc func startButtonDidTap(){
        let moveToGame = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.navigationController?.pushViewController(moveToGame, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
        //MARK: transparent NavigationBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        subview.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        background.image = UIImage(named: "startBackground")
        background.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        self.view.addSubview(subview)
        self.subview.addSubview(background)
        self.view.bringSubviewToFront(startButton)
        
        startButton.setTitle("시작", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "system", size: 20)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = .orange
        startButton.layer.cornerRadius = 30
    }
}

