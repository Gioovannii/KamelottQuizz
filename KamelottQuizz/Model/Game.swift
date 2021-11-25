//
//  Game.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/24.
//

import Foundation

class Game {
     var questionAmount = "0"
     var challengeMode = false
    
    let characters = [
        "Angharad",
        "Anna",
        "Appius Manilius",
        "Arthur",
        "Attila",
        "Belt",
        "Père Blaise",
        "Bohort",
        "Breccan",
        "Le Roi Burgonde",
        "Caius Camillus",
        "Calogrenant",
        "Capito",
        "César",
        "Cryda de Tintagel",
        "Dagonet",
        "La Dame du Lac",
        "Demetra",
        "Drusilla",
        "Le Duc d'Aquitaine",
        "Edern",
        "Elias de Kelliwic'h",
        "Galessin",
        "Gauvain",
        "Goustan",
        "Grüdü",
        "Guenièvre",
        "Guethenoc",
        "Hervé de Rinel",
        "L'interprète burgonde",
        "Le Seigneur Jacca",
        "Les Jumelles du pêcheur",
        "Le Jurisconsulte",
        "Kadoc",
        "Karadoc",
        "Lancelot",
        "Léodagan",
        "Loth",
        "Le Maître d'Armes",
        "Méléagant",
        "Manius Macrinus Firmus",
        "Merlin",
        "Mevanwi",
        "Perceval",
        "Roparzh",
        "Lucius Sillius Sallustius",
        "Séfriane d'Aquitaine",
        "Séli",
        "Spurius Cordius Frontinius",
        "Le Tavernier",
        "Urgan",
        "Vérinus",
        "Venec",
        "Ygerne",
        "Yvain",
    ]
    
    
    /// Return an array with 2 random characters
    func pickRandomCharacters() -> [String] {
        var tempCharacters = [String]()
        
        for _  in 0...1 {
            tempCharacters.append(characters[Int.random(in: 0...characters.count)])
        }
        
        return tempCharacters
    }
}
