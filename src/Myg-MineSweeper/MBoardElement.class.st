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
		'header'
	],
	#category : 'Myg-MineSweeper-UI',
	#package : 'Myg-MineSweeper',
	#tag : 'UI'
}

{ #category : 'instance creation' }
MBoardElement class >> launchLarge [
	^ self withMatrixTest5x5WithMagnifier: 2
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
    ^ self openWithModel: MBoard matrixMedium
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchMedium10x10WithMagnifier: aNumber [
    ^ self openWithModel: MBoard matrixMedium withMagnifier: aNumber
]

{ #category : 'instance creation' }
MBoardElement class >> launchRegular [
	^ self withMatrixTest5x5 
]

{ #category : 'instance creation' }
MBoardElement class >> launchSmall [
	^ self withMatrixTest5x5WithMagnifier: 0.5
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchSmall5x5 [
    ^ self openWithModel: MBoard matrixSmall
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchSmall5x5WithMagnifier: aNumber [
    ^ self openWithModel: MBoard matrixSmall withMagnifier: aNumber
]

{ #category : 'instance creation' }
MBoardElement class >> launchVeryLarge [
	^ self withMatrixTest5x5WithMagnifier: 4
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
MBoardElement class >> open [
	<script>

	| butSmall butRegular butLarge butVeryLarge space elt |
	butSmall := ToButtonModel new.
	butSmall labelText: ('Small' asRopedText fontSize: 50).
	butSmall whenClickedDo: [ self launchSmall ].

	butRegular := ToButtonModel new.
	butRegular labelText: ('Regular' asRopedText fontSize: 50).
	butRegular whenClickedDo: [ self launchRegular ].

	butLarge := ToButtonModel new.
	butLarge labelText: ('Large' asRopedText fontSize: 50).
	butLarge whenClickedDo: [ self launchLarge ].

	butVeryLarge := ToButtonModel new.
	butVeryLarge labelText: ('Very Large' asRopedText fontSize: 50).
	butVeryLarge whenClickedDo: [ self launchVeryLarge ].

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

{ #category : 'execution' }
MBoardElement class >> withMatrixForField [

	^ self openWithModel: MBoard matrixForField
]

{ #category : 'execution' }
MBoardElement class >> withMatrixForFieldWithMagnifier: aNumber [

	^ self openWithModel: MBoard matrixForField withMagnifier: aNumber 
]

{ #category : 'execution' }
MBoardElement class >> withMatrixTest5x5 [

	^ self openWithModel: MBoard matrixTest5x5
]

{ #category : 'execution' }
MBoardElement class >> withMatrixTest5x5WithMagnifier: aNumber [

	^ self openWithModel: MBoard matrixTest5x5 withMagnifier: aNumber 
]

{ #category : 'adding' }
MBoardElement >> addSizeButtons [
    | btn5 btn10 btn16 btn20 |
    
    btn5 := self createSizeButton: '5x5' action: [ MBoardElement launchSmall5x5 ].
    btn10 := self createSizeButton: '10x10' action: [ MBoardElement launchMedium10x10 ].
    btn16 := self createSizeButton: '16x16' action: [ MBoardElement launchLarge16x16 ].
    btn20 := self createSizeButton: '20x20' action: [ MBoardElement launchVeryLarge20x20 ].
    
    header addChild: btn5.
    header addChild: btn10.
    header addChild: btn16.
    header addChild: btn20.
]

{ #category : 'as yet unclassified' }
MBoardElement >> createSizeButton: label action: aBlock [
    | button |
    button := BlTextElement new.
    button text: label asRopedText.
    button padding: (BlInsets all: 5).
    button margin: (BlInsets all: 2).
    button background: Color lightGray.
    button addEventHandlerOn: BlClickEvent do: [ :event | aBlock value ].
    ^ button
]

{ #category : 'accessing' }
MBoardElement >> game [ 
	^ game
]

{ #category : 'accessing' }
MBoardElement >> game: aMBoard [
    game := aMBoard.
    
    game announcer
        when: MBoxClickedAnnouncement
        send: #updateSelectionsLabel
        to: self.
    
    self padding: (BlInsets all: 5 * game magnifier).
    self layout columnCount: game width.
    
    selectionsLabel := BlTextElement new.
    selectionsLabel text: 'Sélections : 0' asRopedText.
    self addChild: selectionsLabel.
    
    game grid do: [ :aBox |
        | boxElement |
        boxElement := MBoxElement createWithBox: aBox.
        self addChild: boxElement ]
]

{ #category : 'initialization' }
MBoardElement >> initialize [

	super initialize. 
	header := BlElement new. 
	header layout: BlLinearLayout horizontal. 
	header constraintsDo: [:c | c horizontal fitContent. c vertical fitContent ]. 
	
	 self addSizeButtons.
	
	self background: (BlBackground paint: Color veryVeryLightGray). 
	self layout: (BlGridLayout horizontal cellSpacing: 5). 
	self constraintsDo: [ :aLayoutConstraints | aLayoutConstraints horizontal fitContent. aLayoutConstraints vertical fitContent ].  
	self addChild: header.
	"selectionsLabel := BlTextElement new. 
	selectionsLabel text: 'Sélections : 0' asRopedText. 
	""header addChild: selectionsLabel. ""
	self addChild:  selectionsLabel."
]

{ #category : 'as yet unclassified' }
MBoardElement >> updateSelectionsLabel [
          selectionsLabel text: ('Sélections : ', game numberOfSelections printString) asRopedText.




]
