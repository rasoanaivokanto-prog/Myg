"
I am an abstract box held by the mine field.
"
Class {
	#name : 'MBox',
	#superclass : 'MygAbstractBox',
	#instVars : [
		'announcer',
		'flagged',
		'clicked'
	],
	#category : 'Myg-MineSweeper-Model',
	#package : 'Myg-MineSweeper',
	#tag : 'Model'
}

{ #category : 'subclass instance creation' }
MBox class >> mine [
	^ MMineBox new
]

{ #category : 'subclass instance creation' }
MBox class >> safe [
	^ MSafeBox new
]

{ #category : 'accessing' }
MBox >> announcer [ 
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : 'accessing' }
MBox >> board [
    ^ board
]

{ #category : 'accessing' }
MBox >> board: aMBoard [
    board := aMBoard
]

{ #category : 'clicking' }
MBox >> click [
	
	self subclassResponsibility.
	
]

{ #category : 'accessing' }
MBox >> clicked: aBoolean [

	clicked := aBoolean 
]

{ #category : 'accessing' }
MBox >> flag [

	self flagged: self isFlagged not
]

{ #category : 'accessing' }
MBox >> flagged: aBoolean [
	flagged:= aBoolean 
]

{ #category : 'initialization' }
MBox >> initialize [

	flagged := false.
	clicked := false.
	
]

{ #category : 'testing' }
MBox >> isClicked [ 

	^ clicked
]

{ #category : 'testing' }
MBox >> isFlagged [ 
	^ flagged
]

{ #category : 'testing' }
MBox >> isMineBox [
	^ false
]

{ #category : 'testing' }
MBox >> isSafeBox [
	^ false
]

{ #category : 'accessing' }
MBox >> position [
    ^ position
]

{ #category : 'accessing' }
MBox >> position: aPoint [
    position := aPoint
]

{ #category : 'clicking' }
MBox >> propagateClick [

	((self board hasMineBoxAroundBox: self) not or: [
		 self board rightFlagCountAroundBox: self ]) ifTrue: [
		self board
			boxesAroundBox: self
			do: [ :box | box isClicked ifFalse: [ box click ] ] ]
]

{ #category : 'accessing' }
MBox >> setPosition: aPoint board: aMBoard [
    position := aPoint.
    board := aMBoard.
    ^ self
]
