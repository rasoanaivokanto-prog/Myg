Class {
	#name : 'MBoardMementoTest',
	#superclass : 'TestCase',
	#instVars : [
		'board'
	],
	#category : 'Myg-MineSweeper-Tests-Tests',
	#package : 'Myg-MineSweeper-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
MBoardMementoTest >> testMementoSavesGameConfiguration [
    | memento restoredBoard originalMineCount |
    "Créer et configurer le board original"
    board := MBoard new initializeWithSize: 5 height: 5.
    board seed: 123.
    
    "Créer et appliquer la stratégie"
    board mineStrategy: (MFixedCountMineStrategy new mineCount: 5; seed: 123; yourself).
    board mineStrategy placeMinesOn: board.
    
    originalMineCount := board mineCount.
    
    "Créer le memento et restaurer"
    memento := board createMemento.
    restoredBoard := MBoard fromMemento: memento.
    
    "Vérifications"
    self assert: restoredBoard width equals: board width.
    self assert: restoredBoard height equals: board height.
    self assert: restoredBoard mineCount equals: originalMineCount
]

{ #category : 'tests' }
MBoardMementoTest >> testReplayCreatesIdenticalBoard [
     | memento board1 board2 strategy |
    board1 := MBoard new.
    board1 initializeWithSize: 5 height: 5.
    board1 seed: 999.
    strategy := MRandomMineStrategy new seed: 999.
    board1 mineStrategy: strategy.
    strategy placeMinesOn: board1.
    
    memento := board1 createMemento.
    board2 := MBoard fromMemento: memento.
    
    self assert: board2 mineCount equals: board1 mineCount.
    
    "Vérifier que les positions des mines sont identiques"
    board1 boxesDoWithIndices: [ :box1 :i :j |
        | box2 |
        box2 := board2 boxAt: i at: j.
        self assert: box1 isMineBox equals: box2 isMineBox ]
]
