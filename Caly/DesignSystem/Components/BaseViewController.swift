//
//  BaseViewController.swift
//  Caly
//
//  Created by Paul Matar on 15/08/2023.
//

import UIKit

/// Use only for Nibless ViewControllers
open class BaseViewController<View: UIView, ViewModel: NSObject>: UIViewController {
    // MARK: - Properties
    private(set) lazy var customView = View(frame: UIScreen.main.bounds)
    private(set) lazy var viewModel = ViewModel()
    
    public init() {
      super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable,
                message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable,
                message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )

    public required init?(coder aDecoder: NSCoder) {
      fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    // MARK: - Lifecycle
    public override func loadView() {
        self.view = customView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemGroupedBackground
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
