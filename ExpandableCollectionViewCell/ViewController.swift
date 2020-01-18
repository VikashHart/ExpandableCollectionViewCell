import UIKit

class ViewController: UIViewController {

    private let viewModel = VCViewModel()
    private let mainView = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupConstraints()
    }

    private func configureCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }

    private func setupConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.animation.animateCell(with: mainView, collectionView: mainView.collectionView, indexPath: indexPath, hiddenCells: viewModel.hiddenCells, expandedCell: viewModel.expandedCells, toggleBool: viewModel.toggleBool, viewController: self) { (CellData) in
            self.viewModel.hiddenCells = CellData.hiddenCells
            self.viewModel.expandedCells = CellData.expandedCell
            self.viewModel.toggleBool = CellData.toggleBool
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? DefaultCollectionViewCell else { return UICollectionViewCell() }
        switch indexPath.row % 2 {
        case 0:
            cell.cardView.backgroundColor = .red
        case 1:
            cell.cardView.backgroundColor = .purple
        default:
            break
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - (viewModel.cellSpacing * viewModel.numberOfSpaces)) / viewModel.numberOfCells
        let height: CGFloat = width * 0.66
        return CGSize(width: width , height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: viewModel.cellSpacing, left: viewModel.cellSpacing, bottom: viewModel.cellSpacing, right: viewModel.cellSpacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.cellSpacing
    }
}
