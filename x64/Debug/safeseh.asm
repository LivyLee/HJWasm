; Listing generated by Microsoft (R) Optimizing Compiler Version 19.00.23026.0 

include listing.inc

INCLUDELIB LIBCMTD
INCLUDELIB OLDNAMES

_DATA	SEGMENT
COMM	decoflags:BYTE
COMM	broadflags:BYTE
COMM	evex:BYTE
COMM	ZEROLOCALS:BYTE
_DATA	ENDS
_DATA	SEGMENT
$SG10655 DB	'coff', 00H
	ORG $+3
$SG10658 DB	'safeseh', 00H
_DATA	ENDS
PUBLIC	SafeSEHDirective
EXTRN	EmitErr:PROC
EXTRN	EmitWarn:PROC
EXTRN	QAddItem:PROC
EXTRN	SymCreate:PROC
EXTRN	SymFind:PROC
EXTRN	Options:BYTE
EXTRN	ModuleInfo:BYTE
EXTRN	Parse_Pass:DWORD
pdata	SEGMENT
$pdata$SafeSEHDirective DD imagerel $LN22
	DD	imagerel $LN22+554
	DD	imagerel $unwind$SafeSEHDirective
pdata	ENDS
xdata	SEGMENT
$unwind$SafeSEHDirective DD 010d01H
	DD	0620dH
xdata	ENDS
; Function compile flags: /Odtp
; File d:\hjwasm\hjwasm2.13.1s\hjwasm2.13.1s\safeseh.c
_TEXT	SEGMENT
sym$ = 32
node$ = 40
i$ = 64
tokenarray$ = 72
SafeSEHDirective PROC

; 28   : {

$LN22:
	mov	QWORD PTR [rsp+16], rdx
	mov	DWORD PTR [rsp+8], ecx
	sub	rsp, 56					; 00000038H

; 29   :     struct asym    *sym;
; 30   :     struct qnode   *node;
; 31   : 
; 32   :     if ( Options.output_format != OFORMAT_COFF ) {

	cmp	DWORD PTR Options+160, 2
	je	SHORT $LN5@SafeSEHDir

; 33   :         if ( Parse_Pass == PASS_1)

	cmp	DWORD PTR Parse_Pass, 0
	jne	SHORT $LN6@SafeSEHDir

; 34   :             EmitWarn( 2, DIRECTIVE_IGNORED_WITHOUT_X, "coff" );

	lea	r8, OFFSET FLAT:$SG10655
	mov	edx, 262				; 00000106H
	mov	ecx, 2
	call	EmitWarn
$LN6@SafeSEHDir:

; 35   :         return( NOT_ERROR );

	xor	eax, eax
	jmp	$LN1@SafeSEHDir
$LN5@SafeSEHDir:

; 36   :     }
; 37   :     if ( Options.safeseh == FALSE ) {

	movzx	eax, BYTE PTR Options+155
	test	eax, eax
	jne	SHORT $LN7@SafeSEHDir

; 38   :         if ( Parse_Pass == PASS_1)

	cmp	DWORD PTR Parse_Pass, 0
	jne	SHORT $LN8@SafeSEHDir

; 39   :             EmitWarn( 2, DIRECTIVE_IGNORED_WITHOUT_X, "safeseh" );

	lea	r8, OFFSET FLAT:$SG10658
	mov	edx, 262				; 00000106H
	mov	ecx, 2
	call	EmitWarn
$LN8@SafeSEHDir:

; 40   :         return( NOT_ERROR );

	xor	eax, eax
	jmp	$LN1@SafeSEHDir
$LN7@SafeSEHDir:

; 41   :     }
; 42   :     i++;

	mov	eax, DWORD PTR i$[rsp]
	inc	eax
	mov	DWORD PTR i$[rsp], eax

; 43   :     if ( tokenarray[i].token != T_ID ) {

	movsxd	rax, DWORD PTR i$[rsp]
	imul	rax, rax, 32				; 00000020H
	mov	rcx, QWORD PTR tokenarray$[rsp]
	movzx	eax, BYTE PTR [rcx+rax]
	cmp	eax, 8
	je	SHORT $LN9@SafeSEHDir

; 44   :         return( EmitErr( SYNTAX_ERROR_EX, tokenarray[i].string_ptr ) );

	movsxd	rax, DWORD PTR i$[rsp]
	imul	rax, rax, 32				; 00000020H
	mov	rcx, QWORD PTR tokenarray$[rsp]
	mov	rdx, QWORD PTR [rcx+rax+8]
	mov	ecx, 209				; 000000d1H
	call	EmitErr
	jmp	$LN1@SafeSEHDir
$LN9@SafeSEHDir:

; 45   :     }
; 46   :     sym = SymSearch( tokenarray[i].string_ptr );

	movsxd	rax, DWORD PTR i$[rsp]
	imul	rax, rax, 32				; 00000020H
	mov	rcx, QWORD PTR tokenarray$[rsp]
	mov	rcx, QWORD PTR [rcx+rax+8]
	call	SymFind
	mov	QWORD PTR sym$[rsp], rax

; 47   : 
; 48   :     /* make sure the argument is a true PROC */
; 49   :     if ( sym == NULL || sym->state == SYM_UNDEFINED ) {

	cmp	QWORD PTR sym$[rsp], 0
	je	SHORT $LN12@SafeSEHDir
	mov	rax, QWORD PTR sym$[rsp]
	cmp	DWORD PTR [rax+32], 0
	jne	SHORT $LN10@SafeSEHDir
$LN12@SafeSEHDir:

; 50   :         if ( Parse_Pass != PASS_1 ) {

	cmp	DWORD PTR Parse_Pass, 0
	je	SHORT $LN13@SafeSEHDir

; 51   :             return( EmitErr( SYMBOL_NOT_DEFINED, tokenarray[i].string_ptr ) );

	movsxd	rax, DWORD PTR i$[rsp]
	imul	rax, rax, 32				; 00000020H
	mov	rcx, QWORD PTR tokenarray$[rsp]
	mov	rdx, QWORD PTR [rcx+rax+8]
	mov	ecx, 102				; 00000066H
	call	EmitErr
	jmp	$LN1@SafeSEHDir
$LN13@SafeSEHDir:

; 52   :         }

	jmp	SHORT $LN11@SafeSEHDir
$LN10@SafeSEHDir:

; 53   :     } else if ( sym->isproc == FALSE ) {

	mov	rax, QWORD PTR sym$[rsp]
	movzx	eax, BYTE PTR [rax+41]
	shr	al, 3
	and	al, 1
	movzx	eax, al
	test	eax, eax
	jne	SHORT $LN14@SafeSEHDir

; 54   :         return( EmitErr( SAFESEH_ARGUMENT_MUST_BE_A_PROC, tokenarray[i].string_ptr ) );

	movsxd	rax, DWORD PTR i$[rsp]
	imul	rax, rax, 32				; 00000020H
	mov	rcx, QWORD PTR tokenarray$[rsp]
	mov	rdx, QWORD PTR [rcx+rax+8]
	mov	ecx, 261				; 00000105H
	call	EmitErr
	jmp	$LN1@SafeSEHDir
$LN14@SafeSEHDir:
$LN11@SafeSEHDir:

; 55   :     }
; 56   : 
; 57   :     if ( Parse_Pass == PASS_1 ) {

	cmp	DWORD PTR Parse_Pass, 0
	jne	$LN15@SafeSEHDir

; 58   :         if ( sym ) {

	cmp	QWORD PTR sym$[rsp], 0
	je	SHORT $LN16@SafeSEHDir

; 59   :             for ( node = ModuleInfo.g.SafeSEHQueue.head; node; node = node->next )

	mov	rax, QWORD PTR ModuleInfo+48
	mov	QWORD PTR node$[rsp], rax
	jmp	SHORT $LN4@SafeSEHDir
$LN2@SafeSEHDir:
	mov	rax, QWORD PTR node$[rsp]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR node$[rsp], rax
$LN4@SafeSEHDir:
	cmp	QWORD PTR node$[rsp], 0
	je	SHORT $LN3@SafeSEHDir

; 60   :                 if ( node->elmt == sym )

	mov	rax, QWORD PTR node$[rsp]
	mov	rcx, QWORD PTR sym$[rsp]
	cmp	QWORD PTR [rax+8], rcx
	jne	SHORT $LN18@SafeSEHDir

; 61   :                     break;

	jmp	SHORT $LN3@SafeSEHDir
$LN18@SafeSEHDir:
	jmp	SHORT $LN2@SafeSEHDir
$LN3@SafeSEHDir:

; 62   :         } else {

	jmp	SHORT $LN17@SafeSEHDir
$LN16@SafeSEHDir:

; 63   :             sym = SymCreate( tokenarray[i].string_ptr );

	movsxd	rax, DWORD PTR i$[rsp]
	imul	rax, rax, 32				; 00000020H
	mov	rcx, QWORD PTR tokenarray$[rsp]
	mov	rcx, QWORD PTR [rcx+rax+8]
	call	SymCreate
	mov	QWORD PTR sym$[rsp], rax

; 64   :             node = NULL;

	mov	QWORD PTR node$[rsp], 0
$LN17@SafeSEHDir:

; 65   :         }
; 66   :         if ( node == NULL ) {

	cmp	QWORD PTR node$[rsp], 0
	jne	SHORT $LN19@SafeSEHDir

; 67   :             sym->used = TRUE; /* make sure an external reference will become strong */

	mov	rax, QWORD PTR sym$[rsp]
	movzx	eax, BYTE PTR [rax+40]
	or	al, 1
	mov	rcx, QWORD PTR sym$[rsp]
	mov	BYTE PTR [rcx+40], al

; 68   : #if 0 /* v2.11: use QAddItem() */
; 69   :             node = LclAlloc( sizeof( struct qnode ) );
; 70   :             node->elmt = sym;
; 71   :             node->next = NULL;
; 72   :             if ( ModuleInfo.g.SafeSEHQueue.head == 0 )
; 73   :                 ModuleInfo.g.SafeSEHQueue.head = ModuleInfo.g.SafeSEHQueue.tail = node;
; 74   :             else {
; 75   :                 ((struct qnode *)ModuleInfo.g.SafeSEHQueue.tail)->next = node;
; 76   :                 ModuleInfo.g.SafeSEHQueue.tail = node;
; 77   :             }
; 78   : #else
; 79   :             QAddItem( &ModuleInfo.g.SafeSEHQueue, sym );

	mov	rdx, QWORD PTR sym$[rsp]
	lea	rcx, OFFSET FLAT:ModuleInfo+48
	call	QAddItem
$LN19@SafeSEHDir:
$LN15@SafeSEHDir:

; 80   : #endif
; 81   :         }
; 82   :     }
; 83   :     i++;

	mov	eax, DWORD PTR i$[rsp]
	inc	eax
	mov	DWORD PTR i$[rsp], eax

; 84   :     if ( tokenarray[i].token != T_FINAL ) {

	movsxd	rax, DWORD PTR i$[rsp]
	imul	rax, rax, 32				; 00000020H
	mov	rcx, QWORD PTR tokenarray$[rsp]
	movzx	eax, BYTE PTR [rcx+rax]
	test	eax, eax
	je	SHORT $LN20@SafeSEHDir

; 85   :         return( EmitErr( SYNTAX_ERROR_EX, tokenarray[i].string_ptr ) );

	movsxd	rax, DWORD PTR i$[rsp]
	imul	rax, rax, 32				; 00000020H
	mov	rcx, QWORD PTR tokenarray$[rsp]
	mov	rdx, QWORD PTR [rcx+rax+8]
	mov	ecx, 209				; 000000d1H
	call	EmitErr
	jmp	SHORT $LN1@SafeSEHDir
$LN20@SafeSEHDir:

; 86   :     }
; 87   : 
; 88   :     return( NOT_ERROR );

	xor	eax, eax
$LN1@SafeSEHDir:

; 89   : }

	add	rsp, 56					; 00000038H
	ret	0
SafeSEHDirective ENDP
_TEXT	ENDS
END
