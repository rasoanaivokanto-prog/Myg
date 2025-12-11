Class {
	#name : 'MRandomMineStrategy',
	#superclass : 'MMineStrategy',
	#instVars : [
		'random'
	],
	#category : 'Myg-MineSweeper-MineStrategy',
	#package : 'Myg-MineSweeper',
	#tag : 'MineStrategy'
}

{ #category : 'copying' }
MRandomMineStrategy >> copy [
    | newStrategy |
    newStrategy := self class new.
    ^ newStrategy
]

{ #category : 'initialization' }
MRandomMineStrategy >> initialize [
    super initialize.
    random := Random new
]

{ #category : 'as yet unclassified' }
MRandomMineStrategy >> placeMinesOn: aBoard [
    aBoard boxesDoWithIndices: [ :box :i :j |
        | isMine newBox |
        isMine := random next > 0.75.
        isMine ifTrue: [
            newBox := MBox mine.
            newBox setPosition: i@j board: aBoard.
            aBoard replaceBox: box by: newBox ] ]

]

{ #category : 'instance creation' }
MRandomMineStrategy >> seed: anInteger [
    anInteger ifNil: [ 
        random := Random new.
        ^ self ].
    random := Random seed: anInteger.
    ^ self
]
