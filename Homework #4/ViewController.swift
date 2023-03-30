//
//  ViewController.swift
//  Homework #4
//
//  Created by d.igihozo on 3/30/23.
//

import UIKit

var listOfWords = ["swift", "universe", "strawberry", "incandescent", "bug", "program"]

let incorrectMovesAllowed = 7
var totalWins = 0
var totalLosses = 0

class ViewController: UIViewController {
    
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view.
    }
    
    var currentGame: Game!
    
    func newRound(){
        if !listOfWords.isEmpty {
                let newWord = listOfWords.removeFirst()
                currentGame = Game(word: newWord,
                incorrectMovesRemaining: incorrectMovesAllowed,
                guessedLetters: [])
            enableLetterButtons(_enable: true)
                updateUI()
            } else {
                enableLetterButtons(_enable: false)
            }
    }
    
    func enableLetterButtons(_enable: Bool){
        for button in letterButtons {
            button.isEnabled = _enable
          }
        
    }
    func updateUI(){
        
       var letters = [String]()
        for letter in currentGame.formattedWord{
            
            letters.append(String(letter))
        }
        
        _ = letters.joined(separator: " ")
        
        correctWordLabel.text = currentGame.formattedWord
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
    }
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
         
    }
    
    func  updateGameState(){
        
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
          } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
          } else {
            updateUI()
          }
        
    }
    
    var totalWins = 0{
        didSet{
            newRound()
        }
    }
    
    var totalLosses = 0{
        didSet{
            newRound()
        }
    }
    
}


