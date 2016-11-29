//
//  ViewController.swift
//  Project2
//
//  Created by Jonathan Deguzman on 11/16/16.
//  Copyright © 2016 Jonathan Deguzman. All rights reserved.
//

import GameplayKit
import UIKit

class ViewController: UIViewController {
    // These buttons were 'ctrl dragged' from storyboard and is now able to be used as properties
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        // We use .cgColor to convert our UIColor into CGColor so that CALayer understands which color to use
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        // Add and assign the following countries to the countries array of Strings
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland","russia", "spain", "uk", "us"]
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        // Randomizes the countries array
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
        
        // setImage() has 2 parameters: 
        // 1. A UIImage to be assigned to the button - here, we use an image from the countries array
        // 2. The state of which a button should be changed - here, we specify the standard state
        // Note: .normal is actually an enum data type and is short for UIControlState.normal, but we can just use .normal as it is better practice
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        // generates a random number between 0-2  to be the correct answer
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        
        title = countries[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if correctAnswer == sender.tag {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
    
        // .alert is another enum data type that provides a pop-up message when a situation changes. The other style you can use is .actionSheet which shows options that slide up from the bottom
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        // Handler is looking for a closure. Remember that closures are just lines of code you want copied/executed. Here, we want the game to continue so we just pass in askQuestion and Swift will call askQuestion()
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

