Class {
	#name : 'MSelectionCounterDecorator',
	#superclass : 'MBoardDecorator',
	#instVars : [
		'numberOfSelections'
	],
	#category : 'Myg-MineSweeper-Model',
	#package : 'Myg-MineSweeper',
	#tag : 'Model'
}

{ #category : 'instance creation' }
MSelectionCounterDecorator class >> decorate: aBoard [
    ^ self new
        decoratedBoard: aBoard;
        yourself
]

{ #category : 'accessing' }
MSelectionCounterDecorator >> decoratedBoard: aBoard [
    decoratedBoard := aBoard.
    self initialize.
    decoratedBoard announcer
        when: MBoxClickedAnnouncement
        send: #incrementSelections
        to: self
]

{ #category : 'player api' }
MSelectionCounterDecorator >> incrementSelections [
    numberOfSelections := numberOfSelections + 1
]

{ #category : 'initialization' }
MSelectionCounterDecorator >> initialize [
    super initialize.
    numberOfSelections := 0
]

{ #category : 'accessing' }
MSelectionCounterDecorator >> numberOfSelections [
    ^ numberOfSelections
]
