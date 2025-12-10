Class {
	#name : 'MBoxRadarAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'box',
		'isMine'
	],
	#category : 'Myg-MineSweeper-Announcements',
	#package : 'Myg-MineSweeper',
	#tag : 'Announcements'
}

{ #category : 'accessing' }
MBoxRadarAnnouncement >> box [
    ^ box.
]

{ #category : 'accessing' }
MBoxRadarAnnouncement >> box: aBox [
    box := aBox.
]

{ #category : 'accessing' }
MBoxRadarAnnouncement >> isMine [
    ^ isMine.
]

{ #category : 'accessing' }
MBoxRadarAnnouncement >> isMine: aBoolean [
    isMine := aBoolean.
]
