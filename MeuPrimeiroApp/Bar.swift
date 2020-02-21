//
//  Bar.swift
//  MeuPrimeiroApp
//
//  Created by Jonathan on 03/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import MapKit
import os.log
//Declarando as chaves do Ncoder
class Bar: NSObject, NSCoding, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(endereco, forKey: PropertyKey.endereco)
        aCoder.encode(coordinate, forKey:PropertyKey.coordinate)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name
        //string, the initializer should fail.
        //Reconhece os objetos
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Bar object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        let endereco = aDecoder.decodeObject(forKey: PropertyKey.endereco)
        let coordinate = aDecoder.decodeObject(forKey: PropertyKey.coordinate) as! CLLocationCoordinate2D
        // Must call designated initializer.
        self.init(name: name, endereco: endereco as! String, photo: photo, rating: rating, coordinate: coordinate)
    }
    
    
    
    //Declarando variaveis
    var name: String = ""
    var photo: UIImage?
    var rating: Int = 0
    var endereco: String = ""
    var numero: Int = 0
    var coordenadas: Int = 0
    
    var title: String? {
        return name
    }
    
    //MARK: Properties
    //Busca o arquivo no diretorio
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("bars")
    //MARK: Types
    struct PropertyKey {
      static let name = "name"
      static let photo = "photo"
      static let rating = "rating"
      static let endereco = "endereco"
      static let coordinate = "coordinate"
    }
    
    
    init?(name: String, endereco: String, photo: UIImage?, rating: Int, coordinate: CLLocationCoordinate2D) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        self.endereco = endereco
        self.coordinate = coordinate
       // self.numero = numero
    }
    
}


