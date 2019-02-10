//
//  SummaryTableViewCell.swift
//  MercadoPagoExample
//
//  Created by Orlando Arzola on 1/29/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setupCell(withTitle title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
    
}
