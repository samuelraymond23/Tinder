//
//  CardsViewController.swift
//  Tinder
//
//  Created by Samuel on 4/19/18.
//  Copyright © 2018 student. All rights reserved.
//


import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var cardImage: UIImageView!
    var cardInitialCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardImage.isUserInteractionEnabled = true
        cardImage.image = #imageLiteral(resourceName: "ryan")
        
        
    }
    
    @IBAction func didPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: cardImage)
        
        if sender.state == .began {
            print("Gesture began")
            cardInitialCenter = cardImage.center
            
        } else if sender.state == .changed {
            print("Gesture is changing")
          
            cardImage.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 8) * (translation.x * 0.01))
            cardImage.center.x = cardInitialCenter.x + translation.x
            cardImage.center.y = cardInitialCenter.y + translation.y
            
        } else if sender.state == .ended {
            print("This Gesture ended")
            self.cardImage.alpha = 0
            
            if (translation.x < 50) {
                print("User Swiped Left")
                UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseInOut,
                    animations: { self.cardImage.alpha = 1 },
                    completion: { (Bool) in
                    self.cardImage.removeFromSuperview()
                })
                
            } else if (translation.x > 50) {
                print("User Swiped Right")
                UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseInOut,
                    animations: { self.cardImage.alpha = 1 },
                    completion: { (Bool) in
                    self.cardImage.removeFromSuperview()
                })
                
            } else {
                cardImage.transform = CGAffineTransform.identity
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationView = segue.destination as! ProfileViewController
        destinationView.newImage = cardImage.image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
