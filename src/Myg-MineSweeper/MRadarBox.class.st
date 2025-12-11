Class {
	#name : 'MRadarBox',
	#superclass : 'MygAbstractBox',
	#instVars : [
		'decoratedBox',
		'radarUsed'
	],
	#category : 'Myg-MineSweeper-Model',
	#package : 'Myg-MineSweeper',
	#tag : 'Model'
}

{ #category : 'accessing' }
MRadarBox >> announcer [
    ^ decoratedBox announcer
]

{ #category : 'accessing' }
MRadarBox >> board [
    ^ decoratedBox board
]

{ #category : 'accessing' }
MRadarBox >> board: aMBoard [
    board := aMBoard.
    decoratedBox ifNotNil: [ decoratedBox board: aMBoard ]
]

{ #category : 'public' }
MRadarBox >> click [
    decoratedBox click
]

{ #category : 'accessing' }
MRadarBox >> decoratedBox [
    ^ decoratedBox
]

{ #category : 'accessing' }
MRadarBox >> decoratedBox: aBox [
    decoratedBox := aBox
]

{ #category : 'initialization' }
MRadarBox >> hasUsedRadar [
    ^ radarUsed
]

{ #category : 'initialization' }
MRadarBox >> initialize [
    super initialize.
    radarUsed := false
]

{ #category : 'testing' }
MRadarBox >> isClicked [
    ^ decoratedBox isClicked
]

{ #category : 'testing' }
MRadarBox >> isFlagged [
    ^ decoratedBox isFlagged
]

{ #category : 'testing' }
MRadarBox >> isMineBox [
    ^ decoratedBox isMineBox
]

{ #category : 'testing' }
MRadarBox >> isSafeBox [
    ^ decoratedBox isSafeBox
]

{ #category : 'accessing' }
MRadarBox >> position [
    ^ decoratedBox position
]

{ #category : 'accessing' }
MRadarBox >> position: aPoint [
    position := aPoint.
    decoratedBox ifNotNil: [ decoratedBox position: aPoint ]
]

{ #category : 'as yet unclassified' }
MRadarBox >> useRadar [
    radarUsed := true.
    self announcer announce: MRadarUsedAnnouncement new
]
