//
//  Loadable.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 17/08/2021.
//

import UIKit

protocol Loadable {
    static var nib: UINib { get }
}

protocol Reusable {
    static var reusableIdentifier: String { get }
}

extension Loadable where Self: AnyObject {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension Reusable {
    static var reusableIdentifier: String { return String(describing: self) }
}

protocol LoadableCell: Reusable, Loadable {}

// MARK: - Usage

extension Loadable where Self: UIView {
    static func loadFromNib() -> Self {
        if let object = nib.instantiate(withOwner: nil, options: nil).first as? Self {
            return object
        }
        fatalError("Could not load nib \(String(describing: self))")
    }

    static func make() -> Self {
        return loadFromNib()
    }
}

extension UITableView {
    func registerCell<U>(_: U.Type) where U: Reusable, U: Loadable, U: UITableViewCell {
        register(U.nib, forCellReuseIdentifier: U.reusableIdentifier)
    }

    func registerCellClass<U>(_: U.Type) where U: Reusable, U: UITableViewCell {
        register(U.self, forCellReuseIdentifier: U.reusableIdentifier)
    }

    func registerHeaderFooterViewClass<U>(_: U.Type) where U: Reusable, U: UITableViewHeaderFooterView {
        register(U.self, forHeaderFooterViewReuseIdentifier: U.reusableIdentifier)
    }

    func registerHeaderFooterView<U>(_: U.Type) where U: Loadable, U: Reusable, U: UITableViewHeaderFooterView {
        register(U.nib, forHeaderFooterViewReuseIdentifier: U.reusableIdentifier)
    }

    func dequeueReusableCell<U>(_: U.Type, forIndexPath indexPath: IndexPath) -> U where U: Reusable, U: UITableViewCell {
        if let dequeueReusableCell = dequeueReusableCell(withIdentifier: U.reusableIdentifier, for: indexPath) as? U {
            return dequeueReusableCell
        }
        fatalError("Could not dequeue cell \(String(describing: self))")
    }

    func dequeueReusableCell<U>(_: U.Type) -> U where U: Reusable, U: UITableViewCell {
        if let dequeueReusableCell = dequeueReusableCell(withIdentifier: U.reusableIdentifier) as? U {
            return dequeueReusableCell
        }
        fatalError("Could not dequeue cell \(String(describing: self))")
    }

    func dequeueReusableHeaderFooterView<U>(_: U.Type) -> U where U: Reusable, U: UITableViewHeaderFooterView {
        if let dequeueReusableCell = dequeueReusableHeaderFooterView(withIdentifier: U.reusableIdentifier) as? U {
            return dequeueReusableCell
        }
        fatalError(String(describing: self))
    }
}
