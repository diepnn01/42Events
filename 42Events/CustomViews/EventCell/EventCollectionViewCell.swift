//
//  EventCollectionViewCell.swift
//  42Events
//
//  Created by Diep Nguyen on 27/05/2021.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var eventContentView: EventContentView!
    var race: Race? {
        didSet {
            eventContentView.race = race
        }
    }
}

