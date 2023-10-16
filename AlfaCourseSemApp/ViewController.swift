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


struct BeerEntity: Codable {
    let id: Int?
    let name, tagline, firstBrewed, beerEntityDescription: String?
    let imageURL: String?
    let abv: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case beerEntityDescription = "description"
        case imageURL = "image_url"
        case abv
    }
}




