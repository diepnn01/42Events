//
//  UITableView+Ext.swift
//  MyIR
//
//  Created by Michał Kuprianowicz on 03.01.2017.
//  Copyright © 2017 LBPro. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }
    func dequeueCell<T>(of type: T.Type, at indexPath: IndexPath, with identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: type.self)
        
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("\(identifier) is nil")
        }
        
        return cell
    }
    func registerCell<T: UITableViewCell>(of type: T.Type, with identifier: String? = nil) {
        register(type.self, forCellReuseIdentifier: identifier ?? String(describing: type.self))
    }
    
    func deselectActiveRow() {
        if let indexPath = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPath, animated: true)
        }
    }
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
            fatalError(
                "Couldn't find UITableViewHeaderFooterView for \(String(describing: name)), make sure the view is registered with table view")
        }
        return headerFooterView
    }
    func register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }
    
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
    
    func register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type) {
        register(nib, forCellReuseIdentifier: String(describing: name))
    }
    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?
        
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        
        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }
    
    var tableViewHeight: CGFloat {
        self.layoutIfNeeded()
        return self.contentSize.height
    }
    
    func reloadDataSavingSelections() {
        let selectedRows = indexPathsForSelectedRows
        reloadData()
        if let selectedRow = selectedRows {
            for indexPath in selectedRow {
                selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
    }
}

