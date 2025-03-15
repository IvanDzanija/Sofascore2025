import UIKit

/// BaseView is an open class that extends UIView and conforms to the BaseViewProtocol.
/// It provides a basic structure for creating custom views with common lifecycle methods.
open class BaseView: UIView, BaseViewProtocol {

    public init() {
        super.init(frame: .zero)

        addViews()
        styleViews()
        setupConstraints()
        setupGestureRecognizers()
        setupBinding()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Override this method in your subclass to add subviews to the BaseView.
    /// This method is called during the initialization process.
    /// Add all child views in this method.
    open func addViews() {
        // Default implementation is empty
    }
    
    /// Override this method to apply styles to the subviews.
    /// Customize the appearance of your subviews here.
    open func styleViews() {
        // Default implementation is empty
    }

    
    /// Override this method and set layout constraints for each view
    open func setupConstraints() {
        // Default implementation is empty
    }

    
    /// Override this method to configure gesture recognizers for your view.
    open func setupGestureRecognizers() {
        // Default implementation is empty
    }

    
    /// Override this method to set up any data bindings needed for your view.
    open func setupBinding() {
        // Default implementation is empty
    }
}
