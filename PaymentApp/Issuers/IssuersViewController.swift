//
//  IssuersViewController.swift
//  PaymentApp
//
//  Created by Nisum on 2/7/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol IssuersPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func getIssuer()
    func issuerSelected(withIndex index: Int)
    func didNavigateBack()
}

final class IssuersViewController: CustomViewController, IssuersPresentable, IssuersViewControllable {

    weak var listener: IssuersPresentableListener?

    @IBOutlet weak var issuersTableView: UITableView!

    private var issuers = [IssuersViewModel]() {
        didSet {
            issuersTableView.reloadData()
        }
    }

    init() {
        super.init(nibName: "IssuersViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        title = "Issuers"
        listener?.getIssuer()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if isMovingFromParent {
            listener?.didNavigateBack()
        }
    }

    private func setupViews() {
        issuersTableView.delegate = self
        issuersTableView.dataSource = self
        issuersTableView.tableFooterView = UIView()
        issuersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "issuersCell")
    }

    func showIssuers(_ issuers: [IssuersViewModel]) {
        self.issuers = issuers
    }
}

extension IssuersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issuers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let issuer = issuers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "issuersCell", for: indexPath)
        cell.textLabel?.text = issuer.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.issuerSelected(withIndex: indexPath.row)
    }
}
