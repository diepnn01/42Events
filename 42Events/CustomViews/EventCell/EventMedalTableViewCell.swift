//
//  EventMedalTableViewCell.swift
//  42Events
//
//  Created by Diep Nguyen on 29/05/2021.
//

import UIKit

class EventMedalTableViewCell: UITableViewCell {

    @IBOutlet weak var labelCategories: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelRaceName: UILabel!
    @IBOutlet weak var labelEventType: UILabel!
    @IBOutlet weak var medalImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        medalImageView.layer.cornerRadius = 10
        medalImageView.layer.masksToBounds = true
    }
    
    var race: Race? {
        didSet {
            guard let race = race else { return }
            let url = URL(string: race.medalViewImage ?? "")
            medalImageView.kf.setImage(with: url, placeholder: UIImage(named: "Default_Banner"))
            labelRaceName.text = race.raceName
            labelDuration.text = race.racePeriod
            var categories = race.categories
            if let sportType = race.sportType {
                categories.insert(sportType, at: 0)
            }
            labelCategories.text = categories.joined(separator: " . ")
            labelEventType.text = "\((race.eventType ?? "").capitalized) submission"
        }
    }
    
}
