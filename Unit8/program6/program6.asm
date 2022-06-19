; Assembly code emitted by HLA compiler
; Version 1.76 build 9932 (prototype)
; HLA compiler written by Randall Hyde
; FASM compatible output

		format	MS COFF


offset32	equ	 
ptr	equ	 

macro global [symbol]
{
 local isextrn
 if defined symbol & ~ defined isextrn
   public symbol
 else if used symbol
   extrn symbol
   isextrn = 1
 end if
}

macro global2 [symbol,type]
{
 local isextrn
 if defined symbol & ~ defined isextrn
   public symbol
 else if used symbol
   extrn symbol:type
   isextrn = 1
 end if
}


ExceptionPtr__hla_	equ	fs:0

		include	'program6.extpub.inc'




		section	'.data' data readable writeable align 16
		include	'program6.data.inc'

		dd	0	;dummy to keep linker happy
		section	'.bss' readable writeable align 16
		include	'program6.bss.inc'

		rb	4	;dummy to keep linker happy
		section	'.text' code readable executable align 16
		include	'program6.consts.inc'

		include	'program6.ro.inc'

; Code begins here:



;/* HWexcept__hla_ gets called when Windows raises the exception. */

HWexcept__hla_ :
		jmp	HardwareException__hla_
;HWexcept__hla_  endp

DfltExHndlr__hla_:
		jmp	DefaultExceptionHandler__hla_
;DfltExHndlr__hla_ endp



_HLAMain       :


;/* Set up the Structured Exception Handler record */
;/* for this program. */

		call	BuildExcepts__hla_
		pushd	0		;/* No Dynamic Link. */
		mov	ebp, esp	;/* Pointer to Main's locals */
		push	ebp		;/* Main's display. */


		jmp	L811_continue__hla_
L811_while__hla_:
		push	L826_str__hla_
		call	STDOUT_PUTS	; puts
		push	eax
		call	STDIN_GETI16	; geti16
		mov	word ptr [L806_value1__hla_+0], ax	;/* value1 */
		pop	eax
		mov	ax, word ptr [L806_value1__hla_+0]	;/* value1 */
		add	word ptr [L809_sum__hla_+0], ax	;/* sum */
		cmp	word ptr [L806_value1__hla_+0], 08h	;/* value1,8 */
		jne	L835_false__hla_
		mov	word ptr [L810_flag__hla_+0], 1	;/* flag */
L835_false__hla_:
		push	L849_str__hla_
		call	STDOUT_PUTS	; puts
		push	eax
		call	STDIN_GETI16	; geti16
		mov	word ptr [L807_value2__hla_+0], ax	;/* value2 */
		pop	eax
		mov	ax, word ptr [L807_value2__hla_+0]	;/* value2 */
		add	word ptr [L809_sum__hla_+0], ax	;/* sum */
		cmp	word ptr [L807_value2__hla_+0], 08h	;/* value2,8 */
		jne	L858_false__hla_
		mov	word ptr [L810_flag__hla_+0], 1	;/* flag */
L858_false__hla_:
		push	L872_str__hla_
		call	STDOUT_PUTS	; puts
		push	eax
		call	STDIN_GETI16	; geti16
		mov	word ptr [L808_value3__hla_+0], ax	;/* value3 */
		pop	eax
		mov	ax, word ptr [L808_value3__hla_+0]	;/* value3 */
		add	word ptr [L809_sum__hla_+0], ax	;/* sum */
		cmp	word ptr [L808_value3__hla_+0], 08h	;/* value3,8 */
		jne	L881_false__hla_
		mov	word ptr [L810_flag__hla_+0], 1	;/* flag */
L881_false__hla_:
		cmp	word ptr [L810_flag__hla_+0], 01h	;/* flag,1 */
		jne	L882_false__hla_
		push	L896_str__hla_
		call	STDOUT_PUTS	; puts
		call	STDOUT_NEWLN	; newln
		mov	word ptr [L810_flag__hla_+0], 0	;/* flag */
		jmp	L882_endif__hla_
L882_false__hla_:
		mov	word ptr [L810_flag__hla_+0], 1	;/* flag */
		mov	ax, word ptr [L809_sum__hla_+0]	;/* sum */
		mov	cl, 10
		div	cl
		cmp	ah, 08h	;/* 8 */
		jne	L901_false__hla_
		push	L915_str__hla_
		call	STDOUT_PUTS	; puts
		call	STDOUT_NEWLN	; newln
		mov	word ptr [L810_flag__hla_+0], 0	;/* flag */
L901_false__hla_:
L882_endif__hla_:
L811_continue__hla_:
		cmp	word ptr [L810_flag__hla_+0], 00h	;/* flag,0 */
		je	L811_while__hla_
L811_exitloop__hla_:

		push	L933_str__hla_
		call	STDOUT_PUTS	; puts
		call	STDOUT_NEWLN	; newln
		push	L951_str__hla_
		call	STDOUT_PUTS	; puts
		push	word 00h
		push	word ptr [L809_sum__hla_+0]	; (type int16 sum)
		call	STDOUT_PUTI16	; puti16
QuitMain__hla_:
		push	dword 00h
		call	dword ptr [__imp__ExitProcess@4]
;_HLAMain        endp

