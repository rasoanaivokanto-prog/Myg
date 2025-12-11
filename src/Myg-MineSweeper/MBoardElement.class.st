"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	game:		<Object>


    Implementation Points
"
Class {
	#name : 'MBoardElement',
	#superclass : 'BlElement',
	#instVars : [
		'game',
		'selectionsLabel',
		'header',
		'footer',
		'gridContainer',
		'currentMemento'
	],
	#category : 'Myg-MineSweeper-UI',
	#package : 'Myg-MineSweeper',
	#tag : 'UI'
}

{ #category : 'as yet unclassified' }
MBoardElement class >> launchCrossPattern [
    "Lancer avec motif en croix"
    ^ self launchWithStrategy: MCrossMineStrategy new size: 10
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchFixedMines: count size: size [
    "Lancer avec nombre fixe de mines"
    | strategy |
    strategy := MFixedCountMineStrategy new mineCount: count.
    ^ self launchWithStrategy: strategy size: size
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchLarge16x16 [
    ^ self openWithModel: MBoard matrixLarge

]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchLarge16x16WithMagnifier: aNumber [
    ^ self openWithModel: MBoard matrixLarge withMagnifier: aNumber
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchMedium10x10 [
    ^ self openWithModel: (MBoard matrixMedium)
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchMedium10x10WithMagnifier: aNumber [
    ^ self openWithModel: MBoard matrixMedium withMagnifier: aNumber
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchReproducible [
    "Lancer avec seed fixe pour rejouabilité"
    | strategy board |
    strategy := MRandomMineStrategy new seed: 12345.
    board := MBoard new.
    board initializeWithSize: 10 height: 10.
    board seed: 12345.
    board mineStrategy: strategy.
    strategy placeMinesOn: board.
    ^ self openWithModel: board
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchSmall5x5 [
    ^ self openWithModel: (MBoard matrixSmall)
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchSmall5x5WithMagnifier: aNumber [
    ^ self openWithModel: MBoard matrixSmall withMagnifier: aNumber
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchVeryLarge20x20 [
    ^ self openWithModel: MBoard matrixVeryLarge
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchVeryLarge20x20WithMagnifier: aNumber [
    ^ self openWithModel: MBoard matrixVeryLarge withMagnifier: aNumber
]

{ #category : 'instance creation' }
MBoardElement class >> launchWithBoard: aBoard [
    | element |
    element := self new.
    element initialize.
    element game: aBoard.
    ^ element
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchWithStrategy: aStrategy size: aSize [
    | board |
    board := MBoard new.
    board initializeWithSize: aSize height: aSize.
    board mineStrategy: aStrategy.
    aStrategy placeMinesOn: board.
    ^ self openWithModel: board
]

{ #category : 'instance creation' }
MBoardElement class >> open [
	<script>

	| butSmall butRegular butLarge butVeryLarge space elt |
	butSmall := ToButtonModel new.
	butSmall labelText: ('Small' asRopedText fontSize: 50).
	butSmall whenClickedDo: [ self launchSmall5x5 ].

	butRegular := ToButtonModel new.
	butRegular labelText: ('Regular' asRopedText fontSize: 50).
	butRegular whenClickedDo: [ self launchMedium10x10  ].

	butLarge := ToButtonModel new.
	butLarge labelText: ('Large' asRopedText fontSize: 50).
	butLarge whenClickedDo: [ self launchLarge16x16 ].

	butVeryLarge := ToButtonModel new.
	butVeryLarge labelText: ('Very Large' asRopedText fontSize: 50).
	butVeryLarge whenClickedDo: [ self launchVeryLarge20x20 ].

	elt := BlElement new.
	elt layout: (BlGridLayout horizontal cellSpacing: 5).
	elt constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	elt layout columnCount: 2.

	space := BlSpace new.
	elt addChild: (butSmall onWidget
			 padding: (BlInsets all: 5);
			 constraintsDo: [ :c |
				 c horizontal matchParent.
				 c vertical matchParent ];
			yourself).
	elt addChild:
		(butRegular onWidget
			padding: (BlInsets all: 5);
			constraintsDo: [ :c |
				 c horizontal matchParent.
				 c vertical matchParent ];
			yourself).
	elt addChild:
		(butLarge onWidget
			padding: (BlInsets all: 5);
			constraintsDo: [ :c |
				 c horizontal matchParent.
				 c vertical matchParent ];
			yourself).
	elt addChild:
		(butVeryLarge onWidget
			padding: (BlInsets all: 5);
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			yourself).
	space root addChild: elt.
	space extent: 500 @ 250.
	space show
]

{ #category : 'instance creation' }
MBoardElement class >> openWithModel: aModel [

	^ self openWithModel: aModel withMagnifier: 1
]

{ #category : 'instance creation' }
MBoardElement class >> openWithModel: aModel withMagnifier: aNumber [

	| aGameElement space |
	space := BlSpace new.
	"Create the game model and the Bloc element."
	aGameElement := self new
		                game: (aModel magnifier: aNumber);
		                yourself.

	"The space represents the window"

	space root addChild: aGameElement.

	"Calculate the extent of the game board for the first time, to set it to the window."
	space pulse.
	space extent: aGameElement extent.
	space resizable: false.
	space show.
	^ space
]

{ #category : 'adding' }
MBoardElement >> addRadarButton [
    | radarBtn |
    radarBtn := self createSizeButton: '📡 Use Radar' action: [
        "Activer mode radar - prochain clic utilise le radar"
        game radarMode: true ].
    header addChild: radarBtn
]

{ #category : 'adding' }
MBoardElement >> addReplayButton [
    | replayBtn |
    replayBtn := self createSizeButton: '🔄 Replay' action: [
        currentMemento ifNotNil: [
            | newBoard newElement space |
            newBoard := MBoard fromMemento: currentMemento.
            newElement := MBoardElement new game: newBoard; yourself.
            newElement currentMemento: currentMemento.
            space := BlSpace new.
            space root addChild: newElement.
            space show ]].
    header addChild: replayBtn
]

{ #category : 'adding' }
MBoardElement >> addSizeButtons [

	| btn5 btn10 btn16 btn20 |
	btn5 := self
		        createSizeButton: '5x5'
		        action: [ MBoardElement launchSmall5x5 ].
	btn10 := self
		         createSizeButton: '10x10'
		         action: [ MBoardElement launchMedium10x10 ].
	btn16 := self
		         createSizeButton: '16x16'
		         action: [ MBoardElement launchLarge16x16 ].
	btn20 := self
		         createSizeButton: '20x20'
		         action: [ MBoardElement launchVeryLarge20x20 ].

	
	footer addChild: btn5.
	footer addChild: btn10.
	footer addChild: btn16.
	footer addChild: btn20.
]

{ #category : 'as yet unclassified' }
MBoardElement >> createSizeButton: label action: aBlock [
    | button |
    button := BlTextElement new.
    button text: (label asRopedText 
        fontSize: 14;
        foreground: Color white).
    button padding: (BlInsets all: 8).
    button margin: (BlInsets all: 3).
    button background: (Color fromHexString: '4A90E2').  "Bleu moderne"
    button geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
    button addEventHandlerOn: BlClickEvent do: [ :event | aBlock value ].
    
    "Effet hover"
    button addEventHandlerOn: BlMouseEnterEvent do: [ :event |
        button background: (Color fromHexString: '357ABD') ].
    button addEventHandlerOn: BlMouseLeaveEvent do: [ :event |
        button background: (Color fromHexString: '4A90E2') ].
    
    ^ button
]

{ #category : 'accessing' }
MBoardElement >> currentMemento: aMemento [
    currentMemento := aMemento
]

{ #category : 'accessing' }
MBoardElement >> game [ 
	^ game
]

{ #category : 'accessing' }
MBoardElement >> game: aMBoard [

	game := aMBoard.
	currentMemento := game createMemento.
	game announcer
		when: MBoxClickedAnnouncement
		send: #updateSelectionsLabel
		to: self.

	"Créer le label de sélections"
	selectionsLabel := BlTextElement new.
	selectionsLabel text: ('Sélections : 0' asRopedText
			 fontSize: 16;
			 bold).
	header addChild: selectionsLabel.
	"ajout des bouton pour rejouer et lancer un radar"
	self addRadarButton.
	self addReplayButton.

	"Créer un container pour la grille"
	gridContainer := BlElement new.
	gridContainer layout: (BlGridLayout horizontal
			 columnCount: game width;
			 cellSpacing: 5).
	gridContainer padding: (BlInsets all: 5 * game magnifier).
	gridContainer constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].

	"Ajouter les boxes à la grille"
	game grid do: [ :aBox |
			| boxElement |
			boxElement := MBoxElement createWithBox: aBox.
			gridContainer addChild: boxElement ].

	"Assembler : header + grille + footer"
	self addChild: gridContainer.
	self addChild: footer
]

{ #category : 'initialization' }
MBoardElement >> initialize [

	 super initialize. 
	
    self layout: BlLinearLayout vertical.
    self background: (BlBackground paint: Color veryVeryLightGray). 
    self constraintsDo: [ :aLayoutConstraints | 
        aLayoutConstraints horizontal fitContent. 
        aLayoutConstraints vertical fitContent ].

    header := BlElement new. 
    header layout: BlLinearLayout horizontal alignCenter.
    header constraintsDo: [:c | 
        c horizontal fitContent. 
        c vertical fitContent ].
    header padding: (BlInsets all: 5).
    
    footer := BlElement new.
    footer layout: BlLinearLayout horizontal alignCenter.
    footer constraintsDo: [:c | 
        c horizontal fitContent. 
        c vertical fitContent ].
    footer padding: (BlInsets all: 10).
    
   self addChild: header.
	self addSizeButtons.
]

{ #category : 'as yet unclassified' }
MBoardElement >> updateSelectionsLabel [
          selectionsLabel text: ('Sélections : ', game numberOfSelections printString) asRopedText.




]
