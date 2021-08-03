//
//  ViewController.swift
//  PickCharacterGame
//
//  Created by 이상헌 on 2021/07/31.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    @objc func startButtonDidTap(){
        
        let moveToGame = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        
        self.navigationController?.pushViewController(moveToGame, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)

    }


}

