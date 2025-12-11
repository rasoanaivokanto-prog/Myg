Class {
	#name : 'MFixedCountMineStrategy',
	#superclass : 'MMineStrategy',
	#instVars : [
		'mineCount',
		'random'
	],
	#category : 'Myg-MineSweeper-MineStrategy',
	#package : 'Myg-MineSweeper',
	#tag : 'MineStrategy'
}

{ #category : 'copying' }
MFixedCountMineStrategy >> copy [
    | newStrategy |
    newStrategy := self class new.
    newStrategy mineCount: mineCount.
    ^ newStrategy
]

{ #category : 'initialization' }
MFixedCountMineStrategy >> initialize [
    super initialize.
    random := Random new.
    mineCount := 10.
 ^ self 
]

{ #category : 'accessing' }
MFixedCountMineStrategy >> mineCount: anInteger [
    mineCount := anInteger
]

{ #category : 'as yet unclassified' }
MFixedCountMineStrategy >> placeMinesOn: aBoard [

	| positions allPositions placedCount |
	allPositions := OrderedCollection new.
	aBoard boxesDoWithIndices: [ :box :i :j | allPositions add: i @ j ].

	 positions := allPositions shuffleBy: random.
    placedCount := mineCount min: positions size.
    
    1 to: placedCount do: [ :index |
        | pos box newBox |
        pos := positions at: index.
        box := aBoard boxAt: pos x at: pos y.
        newBox := MBox mine.
        newBox setPosition: pos board: aBoard.
        aBoard replaceBox: box by: newBox ]
]

{ #category : 'instance creation' }
MFixedCountMineStrategy >> seed: anInteger [
    anInteger ifNil: [ 
        random := Random new.
        ^ self ].
    random := Random seed: anInteger.
    ^ self
]
