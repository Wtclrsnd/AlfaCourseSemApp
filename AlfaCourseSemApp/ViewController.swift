//
//  ViewController.swift
//  AlfaCourseSemApp
//
//  Created by Emil Shpeklord on 02.10.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPink
        let urlString = "https://api.punkapi.com/v2/beers?page=2&per_page=80"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                print(String(describing: error?.localizedDescription))
                return
            }
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            do {
                let responseObject = try jsonDecoder.decode(
                    BeerEntity.self,
                    from: data
                )
                print(responseObject)
            } catch let error {
                print(String(describing: error.localizedDescription))
            }
        }
        .resume()
    }


}


struct BeerEntityElement: Codable {
    let id: Int?
    let name, tagline, firstBrewed, beerEntityDescription: String?
    let imageURL: String?
    let abv: Double?
    let ibu, targetFg: Int?
    let targetOg: Double?
    let ebc, srm: Double?
    let ph, attenuationLevel: Double?
    let volume, boilVolume: BoilVolume?
    let method: Method?
    let ingredients: Ingredients?
    let foodPairing: [String]?
    let brewersTips: String?
    let contributedBy: ContributedBy?

    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case beerEntityDescription = "description"
        case imageURL = "image_url"
        case abv, ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc, srm, ph
        case attenuationLevel = "attenuation_level"
        case volume
        case boilVolume = "boil_volume"
        case method, ingredients
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
}

// MARK: - BoilVolume
struct BoilVolume: Codable {
    let value: Double?
    let unit: Unit?
}

enum Unit: String, Codable {
    case celsius = "celsius"
    case grams = "grams"
    case kilograms = "kilograms"
    case litres = "litres"
}

enum ContributedBy: String, Codable {
    case aliSkinnerAliSKinner = "Ali Skinner <Ali SKinner>"
    case aliSkinnerAliSkinner = "Ali Skinner <AliSkinner>"
    case iainMullanIainmullan = "Iain Mullan <iainmullan>"
    case mattBallGeordieMatt = "Matt Ball <GeordieMatt>"
    case samMasonSamjbmason = "Sam Mason <samjbmason>"
    case sashaSashaMasondeCaires = "Sasha <SashaMasondeCaires>"
}

// MARK: - Ingredients
struct Ingredients: Codable {
    let malt: [Malt]?
    let hops: [Hop]?
    let yeast: String?
}

// MARK: - Hop
struct Hop: Codable {
    let name: String?
    let amount: BoilVolume?
    let add: Add?
    let attribute: Attribute?
}

enum Add: String, Codable {
    case dryHop = "dry hop"
    case end = "end"
    case fv = "FV"
    case middle = "middle"
    case start = "start"
}

enum Attribute: String, Codable {
    case aroma = "aroma"
    case bitter = "bitter"
    case flavour = "flavour"
    case twist = "twist"
}

// MARK: - Malt
struct Malt: Codable {
    let name: String?
    let amount: BoilVolume?
}

// MARK: - Method
struct Method: Codable {
    let mashTemp: [MashTemp]?
    let fermentation: Fermentation?
    let twist: String?

    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation, twist
    }
}

// MARK: - Fermentation
struct Fermentation: Codable {
    let temp: BoilVolume?
}

// MARK: - MashTemp
struct MashTemp: Codable {
    let temp: BoilVolume?
    let duration: Int?
}

typealias BeerEntity = [BeerEntityElement]


