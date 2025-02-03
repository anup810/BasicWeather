//
//  LocationRow.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-02-03.
//

import UIKit

class LocationRow: UITableViewCell {
    static let id = "LocationRow"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
