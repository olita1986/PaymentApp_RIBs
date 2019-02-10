//
//  InstallmentTableViewCell.swift
//  MercadoPagoExample
//
//  Created by Orlando Arzola on 1/29/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import UIKit

class InstallmentTableViewCell: UITableViewCell {

    @IBOutlet weak var installments: UILabel!
    @IBOutlet weak var installmentsValue: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var recommendation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(withInstallment installment: InstallmentViewModel) {
        installments.text = installment.installments
        installmentsValue.text = installment.installmentValue
        totalAmount.text = installment.totalAmount
        recommendation.text = installment.recommendation
    }

}
