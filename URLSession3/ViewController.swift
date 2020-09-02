//
//  ViewController.swift
//  URLSession3
//
//  Created by Wladmir  on 26/08/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donwload()
    }
    
    
    
    @IBAction func reload(_ sender: Any) {
        donwload()
    }
    
    private func donwload() {
        loading.startAnimating()
        button.setTitle("", for: .normal)
        
        let stringURL = "https://dog.ceo/api/breeds/image/random"
        if let url = URL(string: stringURL) {
            
            let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
                
                
                if let data = data {
                    
                    do {
                        let dogObjeto = try JSONDecoder().decode(DogApi.self, from: data)
                        print(dogObjeto)
                        print(dogObjeto.message)
                        print(dogObjeto.status)
                    } catch {
                        print("Erro de parse")
                    }
                    
//                    do {
//                        let dataTojson = try JSONSerialization.jsonObject(
//                            with: data,
//                            options: .mutableContainers
//                        ) as? [String: String]
//
//                        if let dicionario = dataTojson, let imagemString = dicionario["message"] {
//                            self.downloadImage(with: imagemString)
//                        }
//                    } catch {
//                        print("Erro de conversao de dados")
//                    }
                }
            }
            dataTask.resume()
        }
    }

    private func downloadImage(with link: String) {
        if let url = URL(string: link) {
            let dataTask = URLSession.shared
                .dataTask(with: url) { (data, response, error) in
                if let data = data, let imagem = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = imagem
                        self.loading.stopAnimating()
                        self.button.setTitle("Recarregar", for: .normal)
                    }
                }
            }
            dataTask.resume()
        }
    }

}

struct DogApi: Codable {
    let message: String
    let status: String
}
