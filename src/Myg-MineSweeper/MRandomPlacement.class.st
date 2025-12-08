Class {
	#name : 'MRandomPlacement',
	#superclass : 'MPlacementStrategy',
	#category : 'Myg-MineSweeper-Model',
	#package : 'Myg-MineSweeper',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
MRandomPlacement >> placeMinesOn: aBoard withCount: aNumber [
    | positions w h rand count |
    w := aBoard width.
    h := aBoard height.
    rand := Random new.
    positions := OrderedCollection new.
    count := 0.
    [ count < aNumber ] whileTrue: [
        | x y |
        x := (1 to: w) atRandom.
        y := (1 to: h) atRandom.
        (positions includes: x@y) ifFalse: [
            positions add: x@y.
            count := count + 1 ] ].
    ^ positions.
]
