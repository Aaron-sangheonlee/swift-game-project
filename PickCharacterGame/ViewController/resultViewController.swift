//
//  resultViewController.swift
//  PickCharacterGame
//
//  Created by 이상헌 on 2021/08/03.
//

import UIKit

protocol endGameDelegate {
    func endGame()
    }


class resultViewController: UIViewController {
    
    var delegate : endGameDelegate?
    var prevViewController : GameViewController?
    var subview = UIView()
    var background = UIImageView()
    var resultBoard = UIImageView()
    
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var resultStackView: UIStackView!
    @IBOutlet weak var retryButton: UIButton!
    
    @IBAction func retryButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToGameView", sender: self)
    }
    var timeResult: String = ""
    var resultTitle: String = ""
    var resultContent: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if timeResult == "시간 초과" { return }
        else if Int(timeResult)! >= 60 {
            let mins = Int(timeResult)! / 60
            let secs = Int(timeResult)! - (mins*60)
            timeResult = "\(mins): \(secs)"
            resultLabel.text = String(timeResult)
        } else{ return }
        
        self.view.addSubview(subview)
        subview.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        self.subview.addSubview(background)
        background.image = UIImage(named: "backGround")
        background.alpha = 0.5
        background.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        self.view.bringSubviewToFront(resultStackView)
        self.view.bringSubviewToFront(retryButton)
        
//        resultStackView.backgroundColor = .systemYellow
//        resultStackView.layer.cornerRadius = 20
//        resultStackView.layer.borderWidth = 5
//        resultStackView.layer.borderColor = UIColor.orange.cgColor
        
        resultLabel.text = timeResult
        firstLabel.text = resultTitle
        thirdLabel.text = resultContent
        resultLabel.font = UIFont(name: "system", size: 25)
        resultLabel.textColor = .blue
        firstLabel.font = UIFont(name: "system", size: 20)
        thirdLabel.font = UIFont(name: "system", size: 15)
        
        retryButton.setTitle("다시하기", for: .normal)
        retryButton.titleLabel?.font = UIFont(name: "system", size: 20)
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.backgroundColor = .orange
        retryButton.layer.cornerRadius = 30
    }
}
