Class {
	#name : 'MMineStrategyTest',
	#superclass : 'TestCase',
	#instVars : [
		'board'
	],
	#category : 'Myg-MineSweeper-Tests-Tests',
	#package : 'Myg-MineSweeper-Tests',
	#tag : 'Tests'
}

{ #category : 'running' }
MMineStrategyTest >> setUp [
    board := MBoard new.
    board initializeWithSize: 5 height: 5
]

{ #category : 'tests' }
MMineStrategyTest >> testCrossStrategyCreatesCross [
    | strategy centerX centerY |
    strategy := MCrossMineStrategy new.
    strategy placeMinesOn: board.
    
    centerX := board height // 2.
    centerY := board width // 2.
    
    "Vérifier que le centre est une mine"
    self assert: (board boxAt: centerX at: centerY) isMineBox.
    
    "Vérifier ligne horizontale"
    self assert: (board boxAt: centerX at: 1) isMineBox.
    
    "Vérifier ligne verticale"
    self assert: (board boxAt: 1 at: centerY) isMineBox
]

{ #category : 'tests' }
MMineStrategyTest >> testFixedCountStrategyPlacesExactCount [
    | strategy |
    strategy := MFixedCountMineStrategy new mineCount: 5.
    strategy placeMinesOn: board.
    self assert: board mineCount equals: 5
]

{ #category : 'tests' }
MMineStrategyTest >> testRandomStrategyPlacesMines [
    | strategy |
    strategy := MRandomMineStrategy new.
    strategy placeMinesOn: board.
    self assert: board mineCount > 0
]

{ #category : 'tests' }
MMineStrategyTest >> testStrategyIsReproducibleWithSeed [
    | strategy1 strategy2 board1 board2 mines1 mines2 |
    board1 := MBoard new initializeWithSize: 5 height: 5.
    board2 := MBoard new initializeWithSize: 5 height: 5.
    
    strategy1 := MRandomMineStrategy new seed: 42.
    strategy2 := MRandomMineStrategy new seed: 42.
    
    strategy1 placeMinesOn: board1.
    strategy2 placeMinesOn: board2.
    
    mines1 := board1 boxesSelect: #isMineBox.
    mines2 := board2 boxesSelect: #isMineBox.
    
    self assert: mines1 size equals: mines2 size
]
