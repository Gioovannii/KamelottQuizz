//
//  KaamelottJSON.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/10.
//

import Foundation

// MARK: - KaamelottJSON
struct Response: Codable {
    let status: Int
    let citation: Citation
}

// MARK: - Citation
struct Citation: Codable {
    let citation: String
    let infos: Infos
}

// MARK: - Infos
struct Infos: Codable {
    let auteur, acteur, personnage, saison: String
    let episode: String
}

extension Citation {
    static let dumbCitation = [
        Citation(citation: "C\'est normal, c\'est en se cassant la gueule qu\'on apprend à marcher. Combien de fois j\'ai failli m\'étouffer avec un os de lapin. Il faut jamais se laisser abattre par un échec, c\'est ça le secret", infos: Infos(auteur: "Un auteur", acteur: "Un acteur", personnage: "Un personnage", saison: "Saison 1", episode: "Erpisode 4")),
        Citation(citation: "Elle est où la poulette ?", infos: Infos(auteur: "Un auteur", acteur: "Un acteur", personnage: "Un personnage", saison: "Saison 1", episode: "Erpisode 4")),
        Citation(citation: "C'est tout ? Treize ans qu'ils me laissent pourrir sur pied, dans ce pays de merde ! Treize ans ! Maintenant ils m'envoient un message, il faut que je rentre chez moi ! [...] Mais qu'est ce qui leur fait croire que ça existe encore chez moi ?!! Est-ce qu'un type qui a foutu le camp treize ans peut encore avoir un chez soi ? C'est complètement absurde...", infos: Infos(auteur: "Un auteur", acteur: "Un acteur", personnage: "Un personnage", saison: "Saison 1", episode: "Erpisode 4")),
        Citation(citation: "Les pattes de canaaaaaaaaaaaaaaaaaaaaaaaaaaaaard !", infos: Infos(auteur: "Un auteur", acteur: "Un acteur", personnage: "Un personnage", saison: "Saison 1", episode: "Erpisode 4"))
        ]
}




