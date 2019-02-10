//
//  ResultViewController.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol ResultPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.

    func getResult()
    func endPaymentFlow()
}

final class ResultViewController: CustomViewController, ResultPresentable, ResultViewControllable {
    @IBOutlet weak var resultTableView: UITableView!
    
    @IBOutlet weak var endPaymentFlowButton: UIButton!
    weak var listener: ResultPresentableListener?

    var result: ResultViewModel? {
        didSet {
            resultTableView.reloadData()
        }
    }

    init() {
        super.init(nibName: "ResultViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Result"
        setupSummaryTableView()
        listener?.getResult()
    }

    func setupSummaryTableView() {
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.tableFooterView = UIView()

        resultTableView.register(UINib(nibName: "SummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "summaryCell")
    }

    func showResult(_ result: ResultViewModel) {
        self.result = result
    }
    @IBAction func endPaymentFlowPressed(_ sender: Any) {
        listener?.endPaymentFlow()
    }
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as? SummaryTableViewCell else { return UITableViewCell() }

        switch indexPath.row {
        case 0:
            cell.setupCell(withTitle: "Requested Amount", value: result?.amount ?? "")
        case 1:
            cell.setupCell(withTitle: "Payment Method", value: result?.paymentMethod ?? "")
        case 2:
            cell.setupCell(withTitle: "Issuer", value: result?.issuer ?? "")
        case 3:
            cell.setupCell(withTitle: "Installments", value: result?.installments ?? "")
        case 4:
            cell.setupCell(withTitle: "Installment Value", value: result?.installmentValue ?? "")
        case 5:
            cell.setupCell(withTitle: "Total to Pay", value: result?.totalAmount ?? "")
        default:
            break
        }

        return cell
    }


}
