Class {
	#name : 'MCrossMineStrategy',
	#superclass : 'MMineStrategy',
	#category : 'Myg-MineSweeper-MineStrategy',
	#package : 'Myg-MineSweeper',
	#tag : 'MineStrategy'
}

{ #category : 'as yet unclassified' }
MCrossMineStrategy >> placeMinesOn: aBoard [

	| centerX centerY |
	centerX := aBoard height // 2.
	centerY := aBoard width // 2.

	"Ligne horizontale"
	1 to: aBoard width do: [ :j |
			| box newBox |
			box := aBoard boxAt: centerX at: j.
			newBox := MBox mine.
			newBox setPosition: centerX @ j board: aBoard.
			aBoard replaceBox: box by: newBox ].

	"Ligne verticale"
	1 to: aBoard height do: [ :i |
			| box newBox |
			box := aBoard boxAt: i at: centerY.
			newBox := MBox mine.
			newBox setPosition: i @ centerY board: aBoard.
			aBoard replaceBox: box by: newBox ]
]

{ #category : 'instance creation' }
MCrossMineStrategy >> seed: anInteger [
    "Pas d'aléatoire ici"
    ^ self
]
