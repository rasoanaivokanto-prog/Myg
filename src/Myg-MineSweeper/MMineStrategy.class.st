Class {
	#name : 'MMineStrategy',
	#superclass : 'Object',
	#category : 'Myg-MineSweeper-MineStrategy',
	#package : 'Myg-MineSweeper',
	#tag : 'MineStrategy'
}

{ #category : 'copying' }
MMineStrategy >> copy [
    ^ self class new
]

{ #category : 'as yet unclassified' }
MMineStrategy >> placeMinesOn: aBoard [
    "Algorithme abstrait pour placer les mines"
    self subclassResponsibility
]

{ #category : 'instance creation' }
MMineStrategy >> seed: anInteger [
    "Hook method pour permettre la reproductibilité"
    "Par défaut ne fait rien, les sous-classes peuvent override"
    ^ self
]
