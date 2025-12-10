Class {
	#name : 'MBoardDecorator',
	#superclass : 'Object',
	#instVars : [
		'decoratedBoard'
	],
	#category : 'Myg-MineSweeper-Model',
	#package : 'Myg-MineSweeper',
	#tag : 'Model'
}

{ #category : 'accessing' }
MBoardDecorator >> announcer [
    ^ decoratedBoard announcer
]

{ #category : 'accessing' }
MBoardDecorator >> boxAt: x at: y [
    ^ decoratedBoard boxAt: x at: y
]

{ #category : 'enumerating2' }
MBoardDecorator >> boxesAroundBox: aBox do: aBlock [
    decoratedBoard boxesAroundBox: aBox do: aBlock
]

{ #category : 'enumerating2' }
MBoardDecorator >> boxesAroundBox: aBox doWithIndexes: aBlock [
    decoratedBoard boxesAroundBox: aBox doWithIndexes: aBlock
]

{ #category : 'enumerating' }
MBoardDecorator >> boxesDoWithIndices: aBlock [
    decoratedBoard boxesDoWithIndices: aBlock
]

{ #category : 'enumerating' }
MBoardDecorator >> boxesSelect: aBlock [
    ^ decoratedBoard boxesSelect: aBlock
]

{ #category : 'accessing' }
MBoardDecorator >> decoratedBoard: aBoard [
    decoratedBoard := aBoard
]

{ #category : 'accessing' }
MBoardDecorator >> gameEnded [
    ^ decoratedBoard gameEnded

]

{ #category : 'accessing' }
MBoardDecorator >> grid [
    ^ decoratedBoard grid
]

{ #category : 'accessing' }
MBoardDecorator >> height [
    ^ decoratedBoard height

]

{ #category : 'accessing' }
MBoardDecorator >> magnifier [
    ^ decoratedBoard magnifier
]

{ #category : 'accessing' }
MBoardDecorator >> magnifier: aNumber [
    decoratedBoard magnifier: aNumber
]

{ #category : 'box api' }
MBoardDecorator >> playerLoose [
    decoratedBoard playerLoose
]

{ #category : 'accessing' }
MBoardDecorator >> width [
    ^ decoratedBoard width
]
