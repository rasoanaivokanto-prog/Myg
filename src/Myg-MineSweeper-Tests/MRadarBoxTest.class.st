Class {
	#name : 'MRadarBoxTest',
	#superclass : 'TestCase',
	#instVars : [
		'board',
		'radarBox'
	],
	#category : 'Myg-MineSweeper-Tests-Tests',
	#package : 'Myg-MineSweeper-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
MRadarBoxTest >> testRadarDoesNotTriggerExplosion [
    | mineBox decorated announced newMine |
    board := MBoard new initializeWithSize: 3 height: 3.
    
    "Créer une mine et la positionner"
    newMine := MBox mine.
    newMine setPosition: 1@1 board: board.
    board replaceBox: (board boxAt: 1 at: 1) by: newMine.
    
    mineBox := board boxAt: 1 at: 1.
    decorated := MRadarBox new.
    decorated decoratedBox: mineBox.
    
    announced := false.
    mineBox announcer 
        when: MBoxExplosionAnnouncement 
        send: #value 
        to: [ announced := true ].
    
    decorated useRadar.
    
    self deny: announced
]

{ #category : 'tests' }
MRadarBoxTest >> testRadarRevealsMineBox [
    | mineBox decorated newMine |
    board := MBoard new initializeWithSize: 3 height: 3.
    
    "Créer une mine et la positionner"
    newMine := MBox mine.
    newMine setPosition: 1@1 board: board.
    board replaceBox: (board boxAt: 1 at: 1) by: newMine.
    
    mineBox := board boxAt: 1 at: 1.
    decorated := MRadarBox new decoratedBox: mineBox.
    decorated useRadar.
    
    self assert: decorated hasUsedRadar.
    self assert: decorated isMineBox
]

{ #category : 'tests' }
MRadarBoxTest >> testRadarRevealsSafeBox [
    | safeBox decorated |
    board := MBoard new initializeWithSize: 3 height: 3.
    safeBox := board boxAt: 1 at: 1.
    
    decorated := MRadarBox new decoratedBox: safeBox.
    decorated useRadar.
    
    self assert: decorated hasUsedRadar.
    self assert: decorated isSafeBox
]
