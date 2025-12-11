Class {
	#name : 'MBoardMemento',
	#superclass : 'Object',
	#instVars : [
		'width',
		'height',
		'strategy',
		'seed',
		'magnifier'
	],
	#category : 'Myg-MineSweeper-Model',
	#package : 'Myg-MineSweeper',
	#tag : 'Model'
}

{ #category : 'converting' }
MBoardMemento >> asString [
    ^ String streamContents: [ :stream |
        stream 
            << width printString; << 'x'; << height printString;
            << '-'; << strategy class name;
            << '-seed:'; << seed printString ]
]

{ #category : 'accessing' }
MBoardMemento >> height [
    ^ height
]

{ #category : 'accessing' }
MBoardMemento >> magnifier [
    ^ magnifier
]

{ #category : 'as yet unclassified' }
MBoardMemento >> restoreBoard [

	| board |
    board := MBoard new.
    board initializeWithSize: width height: height.
    board magnifier: magnifier.  "AJOUTER"
    board seed: seed.
    board mineStrategy: strategy copy.
    board mineStrategy seed: seed.
    board mineStrategy placeMinesOn: board.
    ^ board
]

{ #category : 'accessing' }
MBoardMemento >> seed [
    ^ seed
]

{ #category : 'accessing' }
MBoardMemento >> strategy [
    ^ strategy
]

{ #category : 'accessing' }
MBoardMemento >> width [
    ^ width
]

{ #category : 'as yet unclassified' }
MBoardMemento >> width: w height: h strategy: s seed: aSeed magnifier: aMagnifier [
    width := w.
    height := h.
    strategy := s.
    seed := aSeed.
    magnifier := aMagnifier
]
