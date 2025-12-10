Class {
	#name : 'MPlacementStrategy',
	#superclass : 'Object',
	#category : 'Myg-MineSweeper-Model',
	#package : 'Myg-MineSweeper',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
MPlacementStrategy class >> placeMinesOn: aBoard withCount: aNumber [
    self subclassResponsibility.
]
