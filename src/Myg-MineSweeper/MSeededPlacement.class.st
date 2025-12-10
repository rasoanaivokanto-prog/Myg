Class {
	#name : 'MSeededPlacement',
	#superclass : 'MPlacementStrategy',
	#instVars : [
		'seed'
	],
	#category : 'Myg-MineSweeper-Model',
	#package : 'Myg-MineSweeper',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
MSeededPlacement class >> withSeed: aSeed [
    ^ (self new) seed: aSeed; yourself.
]

{ #category : 'as yet unclassified' }
MSeededPlacement >> placeMinesOn: aBoard withCount: aNumber [
    | positions w h rand count savedRandom |
    w := aBoard width.
    h := aBoard height.
    savedRandom := Random new.
    rand := Random new seed: seed.
    positions := OrderedCollection new.
    count := 0.
    [ count < aNumber ] whileTrue: [
        | x y |
        x := (1 to: w) atRandom: rand.
        y := (1 to: h) atRandom: rand.
        (positions includes: x@y) ifFalse: [
            positions add: x@y.
            count := count + 1 ] ].
    ^ positions.
]

{ #category : 'accessing' }
MSeededPlacement >> seed: aSeed [
    seed := aSeed.
]
