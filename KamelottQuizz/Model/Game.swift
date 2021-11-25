//
//  Game.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/24.
//

import Foundation

class Game {
   var randomCharacters = [String]()
    
    var characters = [
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
    func pickRandomCharacters(answer: String) -> [String] {
        var charactersAnswers = [String]()
        
        guard let random = charactersAnswers.randomElement() else { return [] }
        charactersAnswers.append(answer)
        charactersAnswers.append(random)
        charactersAnswers.append(random)
        charactersAnswers.shuffle()

        return charactersAnswers
    }
}
