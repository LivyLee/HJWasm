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
$SG8616	DB	'atofloat(%s, 4): magnitude too large; FLT_MAX=%e FLT_MIN'
	DB	'=%e', 0aH, 00H
	ORG $+3
$SG8620	DB	'atofloat(%s, 8): magnitude too large', 0aH, 00H
_DATA	ENDS
PUBLIC	atofloat
PUBLIC	__real@0000000000000000
PUBLIC	__real@3810000000000000
PUBLIC	__real@47efffffe0000000
PUBLIC	__real@bff0000000000000
EXTRN	_errno:PROC
EXTRN	strtod:PROC
EXTRN	memset:PROC
EXTRN	strlen:PROC
EXTRN	DoDebugMsg:PROC
EXTRN	EmitErr:PROC
EXTRN	EmitWarn:PROC
EXTRN	strtotb:PROC
EXTRN	myatoi128:PROC
EXTRN	Parse_Pass:DWORD
EXTRN	_fltused:DWORD
pdata	SEGMENT
$pdata$atofloat DD imagerel $LN22
	DD	imagerel $LN22+578
	DD	imagerel $unwind$atofloat
pdata	ENDS
;	COMDAT __real@bff0000000000000
CONST	SEGMENT
__real@bff0000000000000 DQ 0bff0000000000000r	; -1
CONST	ENDS
;	COMDAT __real@47efffffe0000000
CONST	SEGMENT
__real@47efffffe0000000 DQ 047efffffe0000000r	; 3.40282e+38
CONST	ENDS
;	COMDAT __real@3810000000000000
CONST	SEGMENT
__real@3810000000000000 DQ 03810000000000000r	; 1.17549e-38
CONST	ENDS
;	COMDAT __real@0000000000000000
CONST	SEGMENT
__real@0000000000000000 DQ 00000000000000000r	; 0
CONST	ENDS
xdata	SEGMENT
$unwind$atofloat DD 011801H
	DD	08218H
xdata	ENDS
; Function compile flags: /Odtp
; File d:\hjwasm\hjwasm2.13.1s\hjwasm2.13.1s\atofloat.c
_TEXT	SEGMENT
tv81 = 32
float_value$ = 36
double_value$ = 40
p$1 = 48
end$2 = 56
out$ = 80
inp$ = 88
size$ = 96
negative$ = 104
ftype$ = 112
atofloat PROC

; 26   : {

$LN22:
	mov	BYTE PTR [rsp+32], r9b
	mov	DWORD PTR [rsp+24], r8d
	mov	QWORD PTR [rsp+16], rdx
	mov	QWORD PTR [rsp+8], rcx
	sub	rsp, 72					; 00000048H

; 27   :     //const char *inp;
; 28   :     double  double_value;
; 29   :     float   float_value;
; 30   : 
; 31   :     /* v2.04: accept and handle 'real number designator' */
; 32   :     if ( ftype ) {

	movzx	eax, BYTE PTR ftype$[rsp]
	test	eax, eax
	je	$LN7@atofloat

; 33   :         uint_8 *p;
; 34   :         uint_8 *end;
; 35   :         /* convert hex string with float "designator" to float.
; 36   :          * this is supposed to work with real4, real8 and real10.
; 37   :          * v2.11: use myatoi128() for conversion ( this function
; 38   :          *        always initializes and reads a 16-byte number ).
; 39   :          *        then check that the number fits in the variable.
; 40   :          */
; 41   :         myatoi128( inp, (uint_64 *)out, 16, strlen( inp ) - 1 );

	mov	rcx, QWORD PTR inp$[rsp]
	call	strlen
	dec	rax
	mov	r9d, eax
	mov	r8d, 16
	mov	rdx, QWORD PTR out$[rsp]
	mov	rcx, QWORD PTR inp$[rsp]
	call	myatoi128

; 42   :         for ( p = (uint_8 *)out + size, end = (uint_8 *)out + 16; p < end; p++ )

	mov	eax, DWORD PTR size$[rsp]
	mov	rcx, QWORD PTR out$[rsp]
	add	rcx, rax
	mov	rax, rcx
	mov	QWORD PTR p$1[rsp], rax
	mov	rax, QWORD PTR out$[rsp]
	add	rax, 16
	mov	QWORD PTR end$2[rsp], rax
	jmp	SHORT $LN4@atofloat
$LN2@atofloat:
	mov	rax, QWORD PTR p$1[rsp]
	inc	rax
	mov	QWORD PTR p$1[rsp], rax
$LN4@atofloat:
	mov	rax, QWORD PTR end$2[rsp]
	cmp	QWORD PTR p$1[rsp], rax
	jae	SHORT $LN3@atofloat

; 43   :             if ( *p != NULLC ) {

	mov	rax, QWORD PTR p$1[rsp]
	movzx	eax, BYTE PTR [rax]
	test	eax, eax
	je	SHORT $LN9@atofloat

; 44   :                 EmitErr( INVALID_DATA_INITIALIZER, inp );

	mov	rdx, QWORD PTR inp$[rsp]
	mov	ecx, 231				; 000000e7H
	call	EmitErr

; 45   :                 break;

	jmp	SHORT $LN3@atofloat
$LN9@atofloat:

; 46   :             }

	jmp	SHORT $LN2@atofloat
$LN3@atofloat:

; 47   :     } else {

	jmp	$LN8@atofloat
$LN7@atofloat:

; 48   :         switch ( size ) {

	mov	eax, DWORD PTR size$[rsp]
	mov	DWORD PTR tv81[rsp], eax
	cmp	DWORD PTR tv81[rsp], 4
	je	SHORT $LN10@atofloat
	cmp	DWORD PTR tv81[rsp], 8
	je	$LN14@atofloat
	cmp	DWORD PTR tv81[rsp], 10
	je	$LN17@atofloat
	jmp	$LN18@atofloat
$LN10@atofloat:

; 49   :         case 4:
; 50   : #if USESTRTOF
; 51   :             errno = 0;
; 52   :             float_value = strtof( inp, NULL );
; 53   :             if ( errno == ERANGE ) {
; 54   :                 DebugMsg(("atofloat(%s, 4): magnitude too large\n", inp ));
; 55   :                 EmitErr( MAGNITUDE_TOO_LARGE_FOR_SPECIFIED_SIZE );
; 56   :             }
; 57   :             if( negative )
; 58   :                 float_value *= -1;
; 59   : #else
; 60   :             double_value = strtod( inp, NULL );

	xor	edx, edx
	mov	rcx, QWORD PTR inp$[rsp]
	call	strtod
	movsd	QWORD PTR double_value$[rsp], xmm0

; 61   :             /* v2.06: check FLT_MAX added */
; 62   :             /* v2.11: check FLT_MIN (min positive value) added */
; 63   :             //if ( double_value > FLT_MAX )
; 64   :             if ( double_value > FLT_MAX || ( double_value < FLT_MIN && double_value != 0 ) ) {

	movsd	xmm0, QWORD PTR double_value$[rsp]
	comisd	xmm0, QWORD PTR __real@47efffffe0000000
	ja	SHORT $LN12@atofloat
	movsd	xmm0, QWORD PTR __real@3810000000000000
	comisd	xmm0, QWORD PTR double_value$[rsp]
	jbe	SHORT $LN11@atofloat
	movsd	xmm0, QWORD PTR double_value$[rsp]
	ucomisd	xmm0, QWORD PTR __real@0000000000000000
	jp	SHORT $LN21@atofloat
	je	SHORT $LN11@atofloat
$LN21@atofloat:
$LN12@atofloat:

; 65   :                 DebugMsg(("atofloat(%s, 4): magnitude too large; FLT_MAX=%e FLT_MIN=%e\n", inp, FLT_MAX, FLT_MIN ));

	movsd	xmm3, QWORD PTR __real@3810000000000000
	movd	r9, xmm3
	movsd	xmm2, QWORD PTR __real@47efffffe0000000
	movd	r8, xmm2
	mov	rdx, QWORD PTR inp$[rsp]
	lea	rcx, OFFSET FLAT:$SG8616
	call	DoDebugMsg

; 66   :                 EmitErr( MAGNITUDE_TOO_LARGE_FOR_SPECIFIED_SIZE );

	mov	ecx, 76					; 0000004cH
	call	EmitErr
$LN11@atofloat:

; 67   :             }
; 68   :             if( negative )

	movzx	eax, BYTE PTR negative$[rsp]
	test	eax, eax
	je	SHORT $LN13@atofloat

; 69   :                 double_value *= -1;

	movsd	xmm0, QWORD PTR double_value$[rsp]
	mulsd	xmm0, QWORD PTR __real@bff0000000000000
	movsd	QWORD PTR double_value$[rsp], xmm0
$LN13@atofloat:

; 70   :             float_value = double_value;

	cvtsd2ss xmm0, QWORD PTR double_value$[rsp]
	movss	DWORD PTR float_value$[rsp], xmm0

; 71   : #endif
; 72   :             *(float *)out = float_value;

	mov	rax, QWORD PTR out$[rsp]
	movss	xmm0, DWORD PTR float_value$[rsp]
	movss	DWORD PTR [rax], xmm0

; 73   :             break;

	jmp	$LN5@atofloat
$LN14@atofloat:

; 74   :         case 8:
; 75   :             errno = 0; /* v2.11: init errno; errno is set on over- and under-flow */

	call	_errno
	mov	DWORD PTR [rax], 0

; 76   :             double_value = strtod( inp, NULL );

	xor	edx, edx
	mov	rcx, QWORD PTR inp$[rsp]
	call	strtod
	movsd	QWORD PTR double_value$[rsp], xmm0

; 77   :             /* v2.11: check added */
; 78   :             if ( errno == ERANGE ) {

	call	_errno
	cmp	DWORD PTR [rax], 34			; 00000022H
	jne	SHORT $LN15@atofloat

; 79   :                 DebugMsg(("atofloat(%s, 8): magnitude too large\n", inp ));

	mov	rdx, QWORD PTR inp$[rsp]
	lea	rcx, OFFSET FLAT:$SG8620
	call	DoDebugMsg

; 80   :                 EmitErr( MAGNITUDE_TOO_LARGE_FOR_SPECIFIED_SIZE );

	mov	ecx, 76					; 0000004cH
	call	EmitErr
$LN15@atofloat:

; 81   :             }
; 82   :             if( negative )

	movzx	eax, BYTE PTR negative$[rsp]
	test	eax, eax
	je	SHORT $LN16@atofloat

; 83   :                 double_value *= -1;

	movsd	xmm0, QWORD PTR double_value$[rsp]
	mulsd	xmm0, QWORD PTR __real@bff0000000000000
	movsd	QWORD PTR double_value$[rsp], xmm0
$LN16@atofloat:

; 84   :             *(double *)out = double_value;

	mov	rax, QWORD PTR out$[rsp]
	movsd	xmm0, QWORD PTR double_value$[rsp]
	movsd	QWORD PTR [rax], xmm0

; 85   :             break;

	jmp	SHORT $LN5@atofloat
$LN17@atofloat:

; 86   :         case 10:
; 87   :             strtotb( inp, (struct TB_LD *)out, negative );

	movzx	r8d, BYTE PTR negative$[rsp]
	mov	rdx, QWORD PTR out$[rsp]
	mov	rcx, QWORD PTR inp$[rsp]
	call	strtotb

; 88   :             break;

	jmp	SHORT $LN5@atofloat
$LN18@atofloat:

; 89   :         default:
; 90   :             /* sizes != 4,8 or 10 aren't accepted.
; 91   :              * Masm ignores silently, HJWasm also unless -W4 is set.
; 92   :              */
; 93   :             if ( Parse_Pass == PASS_1 )

	cmp	DWORD PTR Parse_Pass, 0
	jne	SHORT $LN19@atofloat

; 94   :                 EmitWarn( 4, FP_INITIALIZER_IGNORED );

	mov	edx, 74					; 0000004aH
	mov	ecx, 4
	call	EmitWarn
$LN19@atofloat:

; 95   :             memset( (char *)out, 0, size );

	mov	eax, DWORD PTR size$[rsp]
	mov	r8d, eax
	xor	edx, edx
	mov	rcx, QWORD PTR out$[rsp]
	call	memset
$LN5@atofloat:
$LN8@atofloat:

; 96   :         }
; 97   :     }
; 98   :     return;
; 99   : }

	add	rsp, 72					; 00000048H
	ret	0
atofloat ENDP
_TEXT	ENDS
END
