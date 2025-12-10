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
		'radarMode'
	],
	#category : 'Myg-MineSweeper-UI',
	#package : 'Myg-MineSweeper',
	#tag : 'UI'
}

{ #category : 'as yet unclassified' }
MBoardElement class >> allSizeStrategies [
    ^ { MSmallBoardStrategy new.
        MMediumBoardStrategy new.
        MLargeBoardStrategy new.
        MVeryLargeBoardStrategy new }

]

{ #category : 'instance creation' }
MBoardElement class >> launchLarge [
	^ self withMatrixTest5x5WithMagnifier: 2
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchLarge16x16 [
    ^ self launchWithStrategy: MLargeBoardStrategy new
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchLarge16x16WithMagnifier: aNumber [
    ^ self openWithModel: MBoard matrixLarge withMagnifier: aNumber
]

{ #category : 'as yet unclassified' }
MBoardElement class >> launchMedium10x10 [
    ^ self launchWithStrategy: MMediumBoardStrategy new
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
    ^ self launchWithStrategy: MSmallBoardStrategy new

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
    ^ self launchWithStrategy: MVeryLargeBoardStrategy new
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
MBoardElement class >> launchWithStrategy: aStrategy [
    | board |
    board := aStrategy createBoard.
    board magnifier: aStrategy magnifierDefault.
    ^ self openWithModel: board

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

	^ self openWithModel: MBoard matrixSmall withMagnifier: aNumber 
]

{ #category : 'adding' }
MBoardElement >> addRadarButton [
    | btn |
    btn := self createSizeButton: 'Radar' action: [ self toggleRadarMode ].
    footer addChild: btn.

]

{ #category : 'adding' }
MBoardElement >> addSizeButtons [
	self class allSizeStrategies do: [ :strategy |
        | button |
        button := self createSizeButton: strategy name 
                  action: [ self class launchWithStrategy: strategy ].
        footer addChild: button ]
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
    button background: (Color fromHexString: '4A90E2').
    button geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
    button addEventHandlerOn: BlClickEvent do: [ :event | aBlock value ].
    
    button addEventHandlerOn: BlMouseEnterEvent do: [ :event |
        button background: (Color fromHexString: '357ABD') ].
    button addEventHandlerOn: BlMouseLeaveEvent do: [ :event |
        button background: (Color fromHexString: '4A90E2') ].
    
    ^ button
]

{ #category : 'accessing' }
MBoardElement >> game [ 
	^ game
]

{ #category : 'accessing' }
MBoardElement >> game: aMBoard [
    game := MSelectionCounterDecorator decorate: aMBoard.
    
    game announcer
        when: MBoxClickedAnnouncement
        send: #updateSelectionsLabel
        to: self.
    
    self padding: (BlInsets all: 5 * game magnifier).
    
    selectionsLabel := BlTextElement new.
    selectionsLabel text: ('Sélections : 0' asRopedText 
        fontSize: 16;
        bold).
    header addChild: selectionsLabel.
    
    gridContainer := BlElement new.
    gridContainer layout: (BlGridLayout horizontal 
        columnCount: game width;
        cellSpacing: 5).
    gridContainer padding: (BlInsets all: 5 * game magnifier).
    gridContainer constraintsDo: [ :c | 
        c horizontal fitContent. 
        c vertical fitContent ].
    
    game grid do: [ :aBox |
        | boxElement |
        boxElement := MBoxElement createWithBox: aBox.
        gridContainer addChild: boxElement ].
    
    self addChild: gridContainer.
    self addChild: footer.
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

{ #category : 'accessing' }
MBoardElement >> radarMode: aBoolean [
    radarMode := aBoolean.
]

{ #category : 'as yet unclassified' }
MBoardElement >> toggleRadarMode [
    self radarMode: (self radarMode not).
    "Update footer button appearance accordingly"
]

{ #category : 'as yet unclassified' }
MBoardElement >> updateSelectionsLabel [
          selectionsLabel text: ('Sélections : ', game numberOfSelections printString) asRopedText.




]
