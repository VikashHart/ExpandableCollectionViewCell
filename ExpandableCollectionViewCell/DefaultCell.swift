import UIKit

class DefaultCollectionViewCell: ExpandableCell {

    var scrollViewBottomConstraintToBottom: NSLayoutConstraint?
    var scrollViewBottomConstraintToTop: NSLayoutConstraint?

    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .yellow
        sv.delaysContentTouches = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    lazy var scrollViewContainer: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        configureCell()
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func collapse() {
        scrollViewBottomConstraintToBottom?.isActive = false
        scrollViewBottomConstraintToTop?.isActive = true
        super.collapse()
    }

    override func expand(in collectionView: UICollectionView) {
        scrollViewBottomConstraintToTop?.isActive = false
        scrollViewBottomConstraintToBottom?.isActive = true
        super.expand(in: collectionView)
    }

    private func configureCell() {
        backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }

    private func setupViews() {
        setupCardView()
        setupScrollView()
        setupContainer()
    }

    private func setupCardView() {
        addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.66)
            ])
    }

    private func setupScrollView() {
        addSubview(scrollView)

        scrollViewBottomConstraintToBottom = scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        scrollViewBottomConstraintToTop = scrollView.bottomAnchor.constraint(equalTo: scrollView.topAnchor)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: cardView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
//            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        scrollViewBottomConstraintToTop?.isActive = true
    }

    private func setupContainer() {
        scrollView.addSubview(scrollViewContainer)
        NSLayoutConstraint.activate([
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor),
            scrollViewContainer.heightAnchor.constraint(lessThanOrEqualToConstant: 900)
            ])
    }
}
