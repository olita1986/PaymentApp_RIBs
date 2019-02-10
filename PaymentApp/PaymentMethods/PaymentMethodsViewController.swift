//
//  PaymentMethodsViewController.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol PaymentMethodsPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func paymentMethodSelected(withIndex index: Int)
    func getPaymentMethods()
    func didNavigateBack()
}

final class PaymentMethodsViewController: CustomViewController, PaymentMethodsPresentable, PaymentMethodsViewControllable {

    @IBOutlet weak var paymentMethodsTableView: UITableView!
    weak var listener: PaymentMethodsPresentableListener?

    private var paymentMethods = [PaymentMethodViewModel]() {
        didSet {
            paymentMethodsTableView.reloadData()
        }
    }

    init() {
        super.init(nibName: "PaymentMethodsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        title = "Payment Methods"
        listener?.getPaymentMethods()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if isMovingFromParent {
            listener?.didNavigateBack()
        }
    }

    private func setupViews() {
        paymentMethodsTableView.delegate = self
        paymentMethodsTableView.dataSource = self
        paymentMethodsTableView.tableFooterView = UIView()
        paymentMethodsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "paymentMethodCell")
    }

    func showPaymentMethods(_ methods: [PaymentMethodViewModel]) {
        paymentMethods = methods
    }
}

extension PaymentMethodsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let paymentMethod = paymentMethods[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentMethodCell", for: indexPath)
        cell.textLabel?.text = paymentMethod.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.paymentMethodSelected(withIndex: indexPath.row)
    }
}
