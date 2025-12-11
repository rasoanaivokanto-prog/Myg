"
I am a mine field.

I you want to play with me, have a look at 'player api' protocol.

You may want to subscribe to my announcer to react to what is going on during the game. Access it using #announcer accessor. See MFieldAnnouncement to know what I can announce.
"
Class {
	#name : 'MBoard',
	#superclass : 'MygBoard',
	#instVars : [
		'gameEnded',
		'announcer',
		'magnifier',
		'numberOfSelections',
		'mineStrategy',
		'seed',
		'radarMode'
	],
	#classInstVars : [
		'savesSetup'
	],
	#category : 'Myg-MineSweeper-Model',
	#package : 'Myg-MineSweeper',
	#tag : 'Model'
}

{ #category : 'instance creation' }
MBoard class >> createWithMatrix: aMatrix [

	^ self new
		  configureGrid: aMatrix;
		  yourself
]

{ #category : 'as yet unclassified' }
MBoard class >> fromMemento: aMemento [
    ^ aMemento restoreBoard
]

{ #category : 'as yet unclassified' }
MBoard class >> matrixLarge [
    "16x16 avec stratégie random"
    ^ self matrixWithWidth: 16 height: 16
]

{ #category : 'as yet unclassified' }
MBoard class >> matrixMedium [
    "10x10 avec stratégie random"
    ^ self matrixWithWidth: 10 height: 10
]

{ #category : 'as yet unclassified' }
MBoard class >> matrixSmall [
    "5x5 avec stratégie random"
    ^ self matrixWithWidth: 5 height: 5
]

{ #category : 'as yet unclassified' }
MBoard class >> matrixVeryLarge [
    "20x20 avec stratégie random"
    ^ self matrixWithWidth: 20 height: 20
]

{ #category : 'as yet unclassified' }
MBoard class >> matrixWithWidth: width height: height [
    ^ self matrixWithWidth: width height: height strategy: MRandomMineStrategy new

]

{ #category : 'as yet unclassified' }
MBoard class >> matrixWithWidth: width height: height strategy: aStrategy [

	| board randomSeed |
	board := self new.
	randomSeed := Time microsecondClockValue \\ 1000000.
	board initializeWithSize: width height: height.
	board seed: randomSeed. "Définir le seed"
	board mineStrategy: aStrategy.
	aStrategy seed: randomSeed. "Passer le seed à la stratégie"
	aStrategy placeMinesOn: board.
	^ board
]

{ #category : 'accessing' }
MBoard >> announcer [
	^ announcer
]

{ #category : 'enumerating' }
MBoard >> anyBoxSatisfy: aBlock [

	^ grid anySatisfy: aBlock
]

{ #category : 'as yet unclassified' }
MBoard >> booleanMatrixFrom: aMatrix [
    | w h boolMatrix |
    w := aMatrix width.
    h := aMatrix height.
    boolMatrix := CTNewArray2D width: w height: h tabulate: [ :c :r |
        (aMatrix at: c @ r) isMineBox ].
    ^ boolMatrix
]

{ #category : 'accessing' }
MBoard >> boxAt: x at: y [

	^ grid at: x @ y
]

{ #category : 'enumerating2' }
MBoard >> boxesAroundBox: aBox anySatisfy: aBlock [

	self
		boxesAroundBox: aBox
		do: [ :box | (aBlock value: box) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'enumerating2' }
MBoard >> boxesAroundBox: aBox collect: aBlock [

	| collected |
	collected := OrderedCollection new.
	self
		boxesAroundBox: aBox
		do: [ :box | collected add: (aBlock value: box) ].
	^ collected
]

{ #category : 'enumerating2' }
MBoard >> boxesAroundBox: aBox do: aBlock [

	self
		boxesAroundBox: aBox
		doWithIndexes: [ :box :i :j | aBlock value: box ]
]

{ #category : 'enumerating2' }
MBoard >> boxesAroundBox: aBox doWithIndexes: aBlock [

	|x y|
	x := aBox position x.
	y := aBox position y.
	^ (x - 1 to: x + 1) collect: [ :i |
		  (y - 1 to: y + 1) collect: [ :j |
			  ((i = x and: [ j = y ]) or: [
				   i < 1 or: [
					   j < 1 or: [ i > self height or: [ j > self width ] ] ] ])
				  ifFalse: [
				  aBlock value: (self boxAt: i at: j) value: i value: j ] ] ]
]

{ #category : 'enumerating2' }
MBoard >> boxesAroundBox: aBox select: aBlock [

	| collected |
	collected := OrderedCollection new.
	self
		boxesAroundBox: aBox
		do: [ :box | (aBlock value: box) ifTrue: [ collected add: box ] ].
	^ collected
]

{ #category : 'enumerating' }
MBoard >> boxesDoWithIndices: aBlock [
	1 to: self height do: [ :i |
		1 to: self width do: [ :j |
			aBlock value: (self boxAt: i at: j) value: i value: j ] ]
]

{ #category : 'enumerating' }
MBoard >> boxesSelect: aBlock [

	| selected |
	selected := OrderedCollection new.
	grid do: [ :box | (aBlock value: box) ifTrue: [ selected add: box ] ].
	^ selected
]

{ #category : 'player api' }
MBoard >> clickOnBox: aBox [

	| x y |
	gameEnded ifTrue: [ ^ self ].

	x := aBox position x.
	y := aBox position y.
	self radarMode ifTrue: [
			| radarBox |
			radarBox := self enableRadarForBox: aBox.
			radarBox useRadar.
			self radarMode: false.
			^ self ].

	(self boxAt: x at: y) click
]

{ #category : 'public api - configure' }
MBoard >> configureGrid: aMatrix [
    grid := aMatrix.
    self boxesDoWithIndices: [ :box :i :j |
        box setPosition: i@j board: self ]
]

{ #category : 'as yet unclassified' }
MBoard >> configureGridWithMineCount: mineCount [
	"Construire grid en utilisant la stratégie"

	| w h positions matrix |
	w := self width.
	h := self height.
	positions := self placementStrategy
		             placeMinesOn: self
		             withCount: mineCount.
	matrix := CTNewArray2D
		          width: w
		          height: h
		          tabulate: [ :c :r | MSafeBox new ].
	positions do: [ :pos |
			| x y |
			x := pos x.
			y := pos y.
			matrix at: x @ y put: MMineBox new ].
	self configureGrid: matrix. "sauvegarder setup pour replay"

	self savedSetup: matrix copy
]

{ #category : 'as yet unclassified' }
MBoard >> createMemento [
    | currentSeed |
    currentSeed := seed ifNil: [ Time microsecondClockValue \\ 1000000 ].
    ^ MBoardMemento new
        width: self width
        height: self height
        strategy: self mineStrategy copy
        seed: currentSeed
		  magnifier: (self magnifier ifNil: [ 1 ]);
        yourself
]

{ #category : 'as yet unclassified' }
MBoard >> enableRadarForBox: aBox [

	| radarBox |
	radarBox := MRadarBox new.
	radarBox decoratedBox: aBox.
	radarBox board: self.
	radarBox position: aBox position.
	self replaceBox: aBox by: radarBox.
	^ radarBox
]

{ #category : 'box api' }
MBoard >> flagCountAroundBox: aBox [

	^ (self boxesAroundBox: aBox collect: [ :box |
		   box isFlagged
			   ifTrue: [ 1 ]
			   ifFalse: [ 0 ] ]) sum
]

{ #category : 'accessing' }
MBoard >> gameEnded [
	^ gameEnded
]

{ #category : 'testing' }
MBoard >> hasBeenCleared [

	^ (self boxesSelect: #isSafeBox) allSatisfy: #isClicked
]

{ #category : 'testing' }
MBoard >> hasClickedBoxAroundBox: aBox [

	^ self boxesAroundBox: aBox anySatisfy: #isClicked
]

{ #category : 'testing' }
MBoard >> hasMineBoxAroundBox: aBox [

	^ self boxesAroundBox: aBox anySatisfy: #isMineBox 
]

{ #category : 'accessing' }
MBoard >> height [

	^ grid height
]

{ #category : 'player api' }
MBoard >> incrementSelections [
	numberOfSelections := numberOfSelections + 1.
	self announcer announce: MBoxClickedAnnouncement new.
]

{ #category : 'initialization' }
MBoard >> initialize [
	super initialize.
	announcer := Announcer new.
	gameEnded := false.
	numberOfSelections := 0.
	magnifier := 1.  
    radarMode := false

]

{ #category : 'initialization' }
MBoard >> initializeWithSize: width height: height [

	| randomSeed |
	self initialize .
	randomSeed := Time microsecondClockValue \\ 1000000. "Génère un seed aléatoire"
	seed := randomSeed.

	grid := CTNewArray2D
		        width: width
		        height: height
		        tabulate: [ :column :row |
				        | box |
				        box := MBox safe.
				        box setPosition: column @ row board: self.
				        box ].
	^ self
]

{ #category : 'accessing' }
MBoard >> magnifier [ 
	^ magnifier
]

{ #category : 'accessing' }
MBoard >> magnifier: aNumber [
	magnifier := aNumber 
]

{ #category : 'player api' }
MBoard >> mineCount [
	^ (self boxesSelect: #isMineBox) size
]

{ #category : 'box api' }
MBoard >> mineCountAroundBox: aBox [

	^ (self boxesAroundBox: aBox collect: [ :box |
		   box isMineBox
			   ifTrue: [ 1 ]
			   ifFalse: [ 0 ] ]) sum
]

{ #category : 'accessing' }
MBoard >> mineStrategy [
    ^ mineStrategy ifNil: [ mineStrategy := MRandomMineStrategy new ]

]

{ #category : 'accessing' }
MBoard >> mineStrategy: aStrategy [
    mineStrategy := aStrategy
]

{ #category : 'player api' }
MBoard >> numberOfSelections [
    ^ numberOfSelections.
]

{ #category : 'box api' }
MBoard >> playerLoose [

	gameEnded := true.
	self revealBoard.
	
]

{ #category : 'box api' }
MBoard >> playerWin [

	gameEnded ifTrue: [ ^ self ].
	gameEnded := true.
	self revealBoard
]

{ #category : 'printing' }
MBoard >> printOn: aStream [
	aStream
		<< self width asString;
		<< self height asString;
		<< Smalltalk os lineEnding.
	1 to: self width do: [ :i |
		1 to: self height do: [ :j |
			|box|
			box := self boxAt: i at: j.
			box printOn: aStream ].
		i = self width ifFalse: [ aStream	<< Smalltalk os lineEnding ] ]
]

{ #category : 'as yet unclassified' }
MBoard >> radarCount [
    "Compter les radars disponibles/utilisés"
    ^ (self boxesSelect: [ :box | box class = MRadarBox ]) size
]

{ #category : 'accessing' }
MBoard >> radarMode [
    ^ radarMode ifNil: [ radarMode := false ]
]

{ #category : 'accessing' }
MBoard >> radarMode: aBoolean [
    radarMode := aBoolean
]

{ #category : 'box api' }
MBoard >> replaceBox: aBox by: aNewBox [

	| x y |
	x := aBox position x.
	y := aBox position y.
	grid at: x @ y put: aNewBox
]

{ #category : 'as yet unclassified' }
MBoard >> replaySavedSetup [
	|src  w h matrix |
	src := self savedSetup ifNil: [ self class lastSavedSetup ].
    src ifNil: [ ^ nil ].
    w := src width.
    h := src height.
    matrix := CTNewArray2D width: w height: h tabulate: [ :c :r |
        (src at: c @ r)
            ifTrue: [ MMineBox new ]
            ifFalse: [ MSafeBox new ] ].
    ^ self class  createWithMatrix: matrix.
]

{ #category : 'as yet unclassified' }
MBoard >> restoreFromMemento: aMemento [
    | restoredBoard |
    restoredBoard := aMemento restoreBoard.
    grid := restoredBoard grid.
    mineStrategy := restoredBoard mineStrategy.
    seed := restoredBoard seed.
    self configureGrid: grid
]

{ #category : 'as yet unclassified' }
MBoard >> revealBoard [

	self boxesDoWithIndices: [ :aBox :i :j |
		aBox isSafeBox
			ifTrue: [ aBox announcer announce: MBoxClickedAnnouncement new ]
			ifFalse: [ aBox announcer announce: MBoxExplosionAnnouncement new ] ]
]

{ #category : 'accessing' }
MBoard >> rightFlagCountAroundBox: aBox [

	^ (self flagCountAroundBox: aBox)
	  = (self mineCountAroundBox: aBox)
]

{ #category : 'accessing' }
MBoard >> savedSetup [
    ^ self class savedSetup
]

{ #category : 'accessing' }
MBoard >> savedSetup: aBoolMatrix [
    self class savedSetup: aBoolMatrix.
]

{ #category : 'accessing' }
MBoard >> seed [
    ^ seed
]

{ #category : 'accessing' }
MBoard >> seed: anInteger [
    seed := anInteger.
    self mineStrategy ifNotNil: [ self mineStrategy seed: anInteger ]
]

{ #category : 'accessing' }
MBoard >> width [

	^ grid width
]
