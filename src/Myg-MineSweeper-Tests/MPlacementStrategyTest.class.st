Class {
	#name : 'MPlacementStrategyTest',
	#superclass : 'TestCase',
	#category : 'Myg-MineSweeper-Tests',
	#package : 'Myg-MineSweeper-Tests'
}

{ #category : 'tests' }
MPlacementStrategyTest >> testReplayCreatesSameSetup [
    | board original saved replay |
    board := MBoard new.
    board width: 5; height: 5.
    board placementStrategy: (MSeededPlacement withSeed: 123).
    board configureGridWithMineCount: 6.
    saved := board  savedSetup.
    replay := (MBoard new) replaySavedSetup.
    self assert: (saved = replay savedSetup).
]

{ #category : 'tests' }
MPlacementStrategyTest >> testSeededPlacementIsDeterministic [
    | s1 s2 board1 board2 strat1 strat2 pos1 pos2 |
    strat1 := MSeededPlacement  withSeed: 42.
    strat2 := MSeededPlacement  withSeed: 42.
    board1 := MBoard new.
    board1 width: 10; height: 10.
    board1 placementStrategy: strat1.
    pos1 := strat1 placeMinesOn: board1 withCount: 10.

    board2 := MBoard new.
    board2 width: 10; height: 10.
    board2 placementStrategy: strat2.
    pos2 := strat2 placeMinesOn: board2 withCount: 10.

    self assert: pos1 = pos2.
]
