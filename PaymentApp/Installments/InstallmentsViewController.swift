//
//  InstallmentsViewController.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol InstallmentsPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func getInstallments()
    func installmentSelected(withIndex index: Int)
    func didNavigateBack()
}

final class InstallmentsViewController: UIViewController, InstallmentsPresentable, InstallmentsViewControllable {
    @IBOutlet weak var installmentsTableView: UITableView!
    
    weak var listener: InstallmentsPresentableListener?

    private var installments = [InstallmentViewModel]() {
        didSet {
            installmentsTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Installments"
        setupViews()
        listener?.getInstallments()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if isMovingFromParent {
            listener?.didNavigateBack()
        }
    }

    private func setupViews() {
        installmentsTableView.delegate = self
        installmentsTableView.dataSource = self
        installmentsTableView.tableFooterView = UIView()
        installmentsTableView.register(UINib(nibName: "InstallmentTableViewCell", bundle: nil), forCellReuseIdentifier: "installmentCell")
    }

    func showInstallments(_ installments: [InstallmentViewModel]) {
        self.installments = installments
    }
}

extension InstallmentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return installments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let installment = installments[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "installmentCell", for: indexPath) as? InstallmentTableViewCell else { return UITableViewCell()}
        cell.setupCell(withInstallment: installment)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       listener?.installmentSelected(withIndex: indexPath.row)
    }
}
