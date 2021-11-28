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

// Representable citations
struct CitationRepresentable {
    let citation: String
    let infos: Infos
}

struct InfosRepresentable {
    let auteur, acteur, personnage, saison: String
    let episode: String
}

extension CitationRepresentable {
    static let dumbCitation = CitationRepresentable(citation: "Une citation", infos: Infos(auteur: "Un auteur", acteur: "Un acteur", personnage: "Un personnage", saison: "Saison 1", episode: "Erpisode 4"))
}




