Class {
	#name : 'MBoardSizeStrategy',
	#superclass : 'Object',
	#category : 'Myg-MineSweeper-Model',
	#package : 'Myg-MineSweeper',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
MBoardSizeStrategy >> createBoard [
    ^ MBoard createWithMatrix: (CTNewArray2D 
        width: self width 
        height: self height 
        tabulate: [ :column :row | MBox randomCase ])
]

{ #category : 'accessing' }
MBoardSizeStrategy >> height [
    self subclassResponsibility
]

{ #category : 'as yet unclassified' }
MBoardSizeStrategy >> magnifierDefault [
    ^ 1
]

{ #category : 'accessing' }
MBoardSizeStrategy >> name [
    self subclassResponsibility
]

{ #category : 'accessing' }
MBoardSizeStrategy >> width [
    self subclassResponsibility
]
