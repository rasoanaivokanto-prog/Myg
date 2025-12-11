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


    Implementation Points
"
Class {
	#name : 'MineSweeper',
	#superclass : 'Object',
	#category : 'Myg-MineSweeper-Model',
	#package : 'Myg-MineSweeper',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
MineSweeper class >> menuBar [

	| bar |
	bar := ToMenuBar new
		       hMatchParent;
		       vFitContent.
	bar
		background: Color veryVeryLightGray;
		border: (BlBorder paint: Color veryDarkGray).
	^ bar
]

{ #category : 'as yet unclassified' }
MineSweeper class >> menuHelp [

	| menu |
	menu := ToMenu new.
	menu labelText: 'Help'.
	menu iconImage: (Smalltalk ui icons iconNamed: #glamorousHelp).
	menu clickAction: [
			| container lab space |
			lab := ToLabel text: 'How to play:
         
The Minesweeper is a famous game where you need to clear a field without touching any bomb.

- You can click on a cell to uncover it and reveal the number of bombs around this cell.
- Right-click on a cell to flag it and avoid clicking on it, right-click again to unflag.
- When you flagged as many neighbouring cells as bombs around a cell, you can click on this cell to uncover all unflagged neighbouring cells.

NEW FEATURES:
- 📡 Radar button: Use it to reveal if a cell is safe or has a mine without exploding
- 🔄 Replay button: Replay the exact same mine configuration
- Choose different mine placement strategies from the menu
            
The game ends when you have cleared all safe cells.
            
Have fun !'.
			lab beMultiLine.
			lab hMatchParent.
			container := BlElement new
				             background: Color lightBlue;
				             padding: (BlInsets all: 15);
				             layout: BlLinearLayout vertical;
				             constraintsDo: [ :c |
						             c horizontal fitContent.
						             c vertical fitContent ].
			container addChild: lab.
			space := BlSpace new.
			space root
				layout: BlFrameLayout new;
				addChild: container;
				constraintsDo: [ :c |
						c horizontal fitContent.
						c vertical fitContent ].
			space pulse.
			space extent: container extent.
			space show ].
	^ menu
]

{ #category : 'as yet unclassified' }
MineSweeper class >> menuPlay [

	| menu |
	menu := ToMenu new.
	menu labelText: 'Play'.
	menu iconImage: (Smalltalk ui icons iconNamed: #solidMenu).
	menu addItem:
		(ToMenuItem new
			labelText: 'Small';
			clickAction: [ MBoardElement launchSmall5x5 ];
			yourself).
	menu addItem:
		(ToMenuItem new
			labelText: 'Regular';
			clickAction: [ MBoardElement launchMedium10x10 ];
			yourself).
	menu addItem:
		(ToMenuItem new
			labelText: 'Large';
			clickAction: [ MBoardElement launchLarge16x16 ];
			yourself).
	menu addItem:
		(ToMenuItem new
			labelText: 'Very Large';
			clickAction: [ MBoardElement launchVeryLarge20x20 ];
			yourself).

	^ menu
]

{ #category : 'as yet unclassified' }
MineSweeper class >> menuStrategies [
     | menu |
    menu := ToMenu new.
    menu labelText: 'Mine Patterns'.
    menu iconImage: (Smalltalk ui icons iconNamed: #configurationOption).
    
    "Stratégie Random"
    menu addItem:
        (ToMenuItem new
            labelText: 'Random Mines';
            clickAction: [ 
                | board strategy randomSeed |
                randomSeed := Time microsecondClockValue \\ 1000000.
                board := MBoard new.
                board initializeWithSize: 10 height: 10.
                board seed: randomSeed.
                strategy := MRandomMineStrategy new seed: randomSeed.
                board mineStrategy: strategy.
                strategy placeMinesOn: board.
                MBoardElement openWithModel: board ];
            yourself).
    
    "Stratégie Fixed Count"
    menu addItem:
        (ToMenuItem new
            labelText: 'Fixed Count (15 mines)';
            clickAction: [ 
                | board strategy randomSeed |
                randomSeed := Time microsecondClockValue \\ 1000000.
                board := MBoard new.
                board initializeWithSize: 10 height: 10.
                board seed: randomSeed.
                strategy := MFixedCountMineStrategy new mineCount: 15.
                strategy seed: randomSeed.
                board mineStrategy: strategy.
                strategy placeMinesOn: board.
                MBoardElement openWithModel: board ];
            yourself).
    
    "Stratégie Cross"
    menu addItem:
        (ToMenuItem new
            labelText: 'Cross Pattern';
            clickAction: [ 
                | board |
                board := MBoard new.
                board initializeWithSize: 11 height: 11.
                board seed: 0.  "Pas de seed pour cross"
                board mineStrategy: MCrossMineStrategy new.
                board mineStrategy placeMinesOn: board.
                MBoardElement openWithModel: board ];
            yourself).
    
    "Stratégie Reproductible"
    menu addItem:
        (ToMenuItem new
            labelText: 'Reproducible Game (seed: 12345)';
            clickAction: [ 
                | board strategy |
                board := MBoard new.
                board initializeWithSize: 10 height: 10.
                board seed: 12345.
                strategy := MRandomMineStrategy new seed: 12345.
                board mineStrategy: strategy.
                strategy placeMinesOn: board.
                MBoardElement openWithModel: board ];
            yourself).
    
    ^ menu
]

{ #category : 'instance creation' }
MineSweeper class >> open [

	<script>
	| space playMenu helpMenu strategiesMenu  bar title |
	playMenu := self menuPlay.
	helpMenu := self menuHelp.
	strategiesMenu := self menuStrategies. 
	bar := self menuBar.
	title := self title.

	bar addItem: playMenu.
	bar addItem: strategiesMenu. 
	bar addItem: helpMenu.
	space := BlSpace new.


	space root addChild: title.
	space root addChild: bar.
	space extent: 300 @ 300.
	space show
]

{ #category : 'accessing' }
MineSweeper class >> title [ 
	|title|
	title := BlElement new background: Color lightBlue.
	title constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	title layout: BlFrameLayout new.
	title addChild: ((BlTextElement new text:
			  (('Minesweeper' asRopedText fontName: 'Phosphate') fontSize: 50))
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter ]).
	^ title 
]

{ #category : 'see class side' }
MineSweeper >> seeClassSide [ 
]
