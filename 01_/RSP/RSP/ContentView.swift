//
//  ContentView.swift
//  RSP
//
//  Created by Junggyun Oh on 2021/01/20.
//

import SwiftUI

// MARK: Model
struct RSPGame {
	enum Move : String, CaseIterable {
		case rock = "✊", scissors = "✌️", papers = "🖐"
		static var winningMoves: [Move: Move] {
			[
				.rock : .scissors,
				.papers : .rock,
				.scissors : .papers
			]
		}
	}
	
	enum Player {
		case one, two
	}
	
	enum Result {
		case win, draw, lose
	}
	
	let allMoves = Move.allCases
	
	var activePlayer = Player.one
	var moves: (first: Move?, second: Move?) = (nil, nil) {
		didSet {
			activePlayer = (moves.first != nil && activePlayer == .one) ? .two : .one
		}
	}
	var isGameOver: Bool {
		moves.first != nil && moves.second != nil
	}
	var winner: Player? = nil
	
	func eveluateResult() -> RSPGame.Result? {
		guard let firstMove = moves.first, let secondMove = moves.second else {
			return nil
		}
		
		// Draw Case
		if firstMove == secondMove {
			return .draw
		}
		
		if let neededMoveToWin = Move.winningMoves[firstMove], secondMove == neededMoveToWin {
			return .win
		}
		return .lose
	}
}

// MARK: ViewModel
final class RSPGameViewModel : ObservableObject {
	@Published private var model = RSPGame()
	
	func getAllowMoves(forPlayer player: RSPGame.Player) -> [RSPGame.Move] {
		if model.activePlayer == player && !model.isGameOver {
			return model.allMoves
		}
		return []
	}
	
	func getStatusText(forPlayer player: RSPGame.Player) -> String {
		if !model.isGameOver {
			return model.activePlayer == player ? "" : "..."
		}
		if let result = model.eveluateResult() {
			switch result {
				case .win:
					return player == .one ? "You Won" : "You Lose"
				case .lose:
					return player == .one ? "You Lose" : "You Win"
				case .draw:
					return "DRAW!"
			}
		}
		return "Undefined State"
	}
	
	func getFinalMove(forPlayer player: RSPGame.Player) -> String {
		if model.isGameOver {
			switch player {
				case .one:
					return model.moves.first?.rawValue ?? ""
				case .two:
					return model.moves.second?.rawValue ?? ""
			}
		}
		return ""
	}
	
	func isGameOver() -> Bool {
		model.isGameOver
	}
	
	func choose(_ move: RSPGame.Move, forPlayer player: RSPGame.Player) {
		print("Player \(player) chose \(move.rawValue)")
		if player == .one{
			model.moves.first = move
		} else {
			model.moves.second = move
		}
	}
	
	func resetGame() {
		model.activePlayer = .one
		model.moves = (nil, nil)
		model.winner = nil
	}
}


// MARK: View
struct ContentView: View {
	@ObservedObject var viewModel = RSPGameViewModel()
	
	var body: some View {
		VStack {
			ZStack {
				Color.purple
				VStack {
					Text("Player 2")
					Text(viewModel.getFinalMove(forPlayer: .two))
					Spacer()
					Text(viewModel.getStatusText(forPlayer: .two))
					HStack{
						ForEach(viewModel
									.getAllowMoves(forPlayer: .two), id: \.self) { move in
							Button(action: {
									self.viewModel.choose(move, forPlayer: .two)
							}) {
								Spacer()
								Text(move.rawValue)
								Spacer()
							}
						}
					}
				}
				.padding(.bottom, 40)
			}
			.rotationEffect(.degrees(180))

			if viewModel.isGameOver(){
				Button(action: {
					self.viewModel.resetGame()
				}) {
					Text("Retry")
						.fontWeight(.bold)
						.foregroundColor(.blue)
						.font(.title)
				}
			}
			
			ZStack {
				Color.blue
				VStack {
					Text("Player 1")
					Text(viewModel.getFinalMove(forPlayer: .one))
					Spacer()
					Text(viewModel.getStatusText(forPlayer: .one))
					HStack{
						ForEach(viewModel.getAllowMoves(forPlayer: .one), id: \.self) { move in
							Button(action: {
									self.viewModel.choose(move, forPlayer: .one)
							}) {
								Spacer()
								Text(move.rawValue)
								Spacer()
							}
						}
					}
				}
				.padding(.bottom, 40)
			}
			
		}
		.foregroundColor(.white)
		.font(.custom("AvenirNext-UltraLight", size: 70))
		.edgesIgnoringSafeArea([.top, .bottom])
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
