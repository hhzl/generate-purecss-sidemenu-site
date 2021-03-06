Object subclass: #PublicationDirectory
	instanceVariableNames: 'publishDirPath'
	classVariableNames: 'Current'
	poolDictionaries: ''
	category: 'StaticSiteGenerator-Support'!
!PublicationDirectory commentStamp: 'hjh 3/15/2018 14:14' prior: 0!
A PublicationDirectory wraps access methods 
a) to create directories
b) to write files to the publication directory.

It is a thin layer to make the code work on Cuis, Pharo and Squeak.

A more comprehensive alternative is to use FileMan
http://wiki.squeak.org/squeak/6333
FileMan provides an API to file and directory tasks.
FileMan is a thin wrapper for various Smalltalk file libraries. It provides simple, portable interfaces for manipulating files and directories.

Or enhance this code by using part of 'Grease', the compatibilty layer for Seaside.
See GRPlatform  the protocol 'file library'.

SmalltalkImage current platformName
might be useful as well to include.

Instance Variables
	publishDirPath:		<Object>

publishDirPath
	- xxxxx
!
]style[(560 40 146),f1,!


!PublicationDirectory methodsFor: 'action' stamp: 'hjh 3/8/2018 13:24'!
at: aFileName put: aString
self subclassResponsibility! !

!PublicationDirectory methodsFor: 'action' stamp: 'hjh 3/8/2018 16:30'!
newLine
^String cr
! !

!PublicationDirectory methodsFor: 'action' stamp: 'hjh 3/8/2018 13:15'!
preparePublishDir

self subclassResponsibility						


	! !


!PublicationDirectory methodsFor: 'accessing' stamp: 'hjh 3/8/2018 11:35'!
publishDirPath
	^ publishDirPath! !

!PublicationDirectory methodsFor: 'accessing' stamp: 'hjh 3/15/2018 13:48'!
publishDirPath: anObject
	publishDirPath := anObject.
	self preparePublishDir! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

PublicationDirectory class
	instanceVariableNames: ''!

!PublicationDirectory class methodsFor: 'as yet unclassified' stamp: 'hjh 3/8/2018 13:25'!
at: aFileName put: aString

self current at: aFileName put: aString
! !

!PublicationDirectory class methodsFor: 'as yet unclassified' stamp: 'hjh 3/15/2018 12:35'!
current
	Current isNil
		ifTrue: [(Smalltalk
					at: #FileDirectory
					ifAbsent: []) notNil
			ifTrue: ["We use Squeak"
				Current := PublicationDirectorySqueak new]			
			ifFalse: [(Smalltalk
					at: #FmDirectoryEntry
					ifAbsent: []) notNil
				ifTrue: [Current := PublicationDirectoryFileMan new]
				ifFalse: [(Smalltalk
					at: #DirectoryEntry
					ifAbsent: []) notNil
					ifTrue: [Current := PublicationDirectoryCuis new]
					ifFalse: ["on Pharo or Squeak"
						Current := PublicationDirectoryPharo new
						]]]].
	^ Current! !

!PublicationDirectory class methodsFor: 'as yet unclassified' stamp: 'hjh 3/8/2018 16:28'!
newLine

^self current newLine
! !

!PublicationDirectory class methodsFor: 'as yet unclassified' stamp: 'hjh 3/8/2018 11:41'!
publishDirPath: anObject
	self current publishDirPath: anObject! !

!PublicationDirectory class methodsFor: 'as yet unclassified' stamp: 'hjh 3/15/2018 12:36'!
reset
"self reset"
	Current := nil! !


PublicationDirectory subclass: #PublicationDirectoryCuis
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StaticSiteGenerator-Support'!

!PublicationDirectoryCuis methodsFor: 'as yet unclassified' stamp: 'hjh 3/8/2018 17:02'!
at: aFileName put: aString 
	| directory |
	(Smalltalk
			at: #DirectoryEntry
			ifAbsent: []) notNil
		ifTrue: ["We use Cuis"
			directory := (Smalltalk at: #DirectoryEntry)
						pathName: self  publishDirPath.
			directory at: aFileName put: aString]
		ifFalse: [self error: 'The wrong PublicationDirectory class was chosen']! !

!PublicationDirectoryCuis methodsFor: 'as yet unclassified' stamp: 'hjh 3/8/2018 16:59'!
newLine

^(Character perform: #newLineCharacter) asString! !

!PublicationDirectoryCuis methodsFor: 'as yet unclassified' stamp: 'hjh 3/8/2018 13:14'!
preparePublishDir
	(Smalltalk
			at: #DirectoryEntry
			ifAbsent: []) notNil
		ifTrue: [((Smalltalk at: #DirectoryEntry)
				pathName: self publishDirPath) assureExistence]
		ifFalse: [self error: 'The wrong PublicationDirectorySubclass is used!!']! !


PublicationDirectory subclass: #PublicationDirectoryFileMan
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StaticSiteGenerator-Support'!
!PublicationDirectoryFileMan commentStamp: 'hjh 3/8/2018 17:21' prior: 0!
A PublicationDirectoryFileMan is for a Smalltalk version which has FileMan loaded

http://wiki.squeak.org/squeak/6333
https://github.com/mumez/FileMan!


!PublicationDirectoryFileMan methodsFor: 'as yet unclassified' stamp: 'hjh 3/8/2018 13:46'!
at: aFileName put: aString 
	| directory |
	(Smalltalk
			at: #FmDirectoryEntry
			ifAbsent: []) notNil
		ifTrue: [directory := (Smalltalk at: #FmDirectoryEntry)
						pathName: self publishDirPath.
			directory at: aFileName put: aString]
		ifFalse: [self error: 'The wrong PublicationDirectory class was chosen']! !

!PublicationDirectoryFileMan methodsFor: 'as yet unclassified' stamp: 'hjh 3/8/2018 16:29'!
newLine
^String cr
! !

!PublicationDirectoryFileMan methodsFor: 'as yet unclassified' stamp: 'hjh 3/8/2018 13:15'!
preparePublishDir
	(Smalltalk
			at: #FmDirectoryEntry
			ifAbsent: []) notNil
		ifTrue: [((Smalltalk at: #FmDirectoryEntry)
				pathName: self publishDirPath) assureExistence]
		ifFalse: [self error: 'The wrong PublicationDirectorySubclass is used!!']! !


PublicationDirectory subclass: #PublicationDirectoryPharo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StaticSiteGenerator-Support'!

!PublicationDirectoryPharo methodsFor: 'as yet unclassified' stamp: 'hjh 3/12/2018 14:56'!
at: aFileName put: aString 
      (self publishDir / aFileName) writeStreamDo: [:ws | ws nextPutAll: aString].! !

!PublicationDirectoryPharo methodsFor: 'as yet unclassified' stamp: 'hjh 3/11/2018 08:04'!
preparePublishDir

self publishDir perform: #ensureCreateDirectory
! !

!PublicationDirectoryPharo methodsFor: 'as yet unclassified' stamp: 'hjh 3/12/2018 15:07'!
publishDir
| fsClass dir |
	(Smalltalk
			at: #FileSystem
			ifAbsent: []) notNil
		ifTrue: [fsClass := Smalltalk at: #FileSystem.
			       dir := fsClass perform: #workingDirectory.
			       dir := dir  perform: #/ with: self publishDirPath.
			      ^dir]
		ifFalse: [self error: 'The wrong PublicationDirectorySubclass is used!!']
		
	
! !


PublicationDirectory subclass: #PublicationDirectorySqueak
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StaticSiteGenerator-Support'!

!PublicationDirectorySqueak methodsFor: 'as yet unclassified' stamp: 'hjh 3/15/2018 13:26'!
at: aFileName put: aString 
	| clsFileStream s |
	(Smalltalk
			at: #FileDirectory
			ifAbsent: []) notNil
		ifTrue: ["We use Squeak; code adapted from GRSqueakPlatform write:toFile:inFolder:"
			clsFileStream := Smalltalk at: #MultiByteFileStream.
			s := clsFileStream perform: #forceNewFileNamed: with: self  publishDirPath, aFileName.
			s perform: #ascii.
			s perform: #wantsLineEndConversion: with: true.
			s nextPutAll: aString.
			s close]
		ifFalse: [self error: 'The wrong PublicationDirectory class was chosen']! !

!PublicationDirectorySqueak methodsFor: 'as yet unclassified' stamp: 'hjh 3/15/2018 12:57'!
preparePublishDir
| clsFileDirectory dir  |
	(Smalltalk
			at: #FileDirectory
			ifAbsent: []) notNil
		ifTrue: [clsFileDirectory := Smalltalk at: #FileDirectory.
			       dir := clsFileDirectory perform: #on: with: self publishDirPath.
			       dir perform: #assureExistence.
			]
		ifFalse: [self error: 'The wrong PublicationDirectorySubclass is used!!']! !
