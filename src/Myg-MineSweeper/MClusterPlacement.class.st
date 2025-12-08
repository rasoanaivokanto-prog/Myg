Class {
	#name : 'MClusterPlacement',
	#superclass : 'MPlacementStrategy',
	#category : 'Myg-MineSweeper-Model',
	#package : 'Myg-MineSweeper',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
MClusterPlacement >> placeMinesOn: aBoard withCount: aNumber [
    | positions w h rand centerCount center posCount |
    w := aBoard width.
    h := aBoard height.
    rand := Random new.
    positions := OrderedCollection new.
    "Pick a center and make cluster(s)"
    centerCount := (aNumber // 5) max: 1.
    1 to: centerCount do: [:i |
        | cx cy |
        cx := (1 to: w) atRandom.
        cy := (1 to: h) atRandom.
        posCount := (aNumber // centerCount) floor.
        1 to: posCount do: [:k |
            | dx dy nx ny |
            dx := (-2 to: 2) atRandom.
            dy := (-2 to: 2) atRandom.
            nx := (cx + dx) clip: 1 to: w.
            ny := (cy + dy) clip: 1 to: h.
            (positions includes: nx @ ny) ifFalse: [ positions add: nx @ ny ] ] ].
    "If we have less than required, fill randomly"
    [ positions size < aNumber ] whileTrue: [
        positions add: ((1 to: w) atRandom) @ ((1 to: h) atRandom) ifAbsent: [] ].
    ^ positions first: aNumber.
]
