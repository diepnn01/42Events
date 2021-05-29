//
//  EventTableViewCell.swift
//  42Events
//
//  Created by Diep Nguyen on 29/05/2021.
//

import UIKit

final class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventContentView: EventContentView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    var race: Race? {
        didSet {
            eventContentView.race = race
        }
    }
}
