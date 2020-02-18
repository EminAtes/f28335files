;############################################################################
;
; FILE:   DSP28xxx_SectionCopy_nonBIOS.asm
;
; DESCRIPTION:  Provides functionality for copying intialized sections from 
;				flash to ram at runtime before entering the _c_int00 startup
;				routine
;############################################################################
; Author: Tim Love
; Release Date: March 2008	
;############################################################################


	.ref _c_int00
	.global copy_sections
	.global _CinitLoadStart, _CinitRunStart, _CinitSize
	.global _EconstLoadStart, _EconstRunStart, _EconstSize
	.global _PinitLoadStart, _PinitRunStart, _PinitSize
	.global _SwitchLoadStart, _SwitchRunStart, _SwitchSize
	.global _TextLoadStart, _TextRunStart, _TextSize
	
***********************************************************************
* Function: copy_sections
*
* Description: Copies initialized sections from flash to ram
***********************************************************************

	.sect "copysections"

copy_sections:

	MOVL XAR5,#_CinitSize				; Store Section Size in XAR5
	MOVL ACC,@XAR5						; Move Section Size to ACC
	MOVL XAR6,#_CinitLoadStart			; Store Load Starting Address in XAR6
    MOVL XAR7,#_CinitRunStart			; Store Run Address in XAR7
    LCR  copy							; Branch to Copy

	MOVL XAR5,#_EconstSize				; Store Section Size in XAR5
	MOVL ACC,@XAR5						; Move Section Size to ACC
	MOVL XAR6,#_EconstLoadStart		; Store Load Starting Address in XAR6
    MOVL XAR7,#_EconstRunStart			; Store Run Address in XAR7
    LCR  copy							; Branch to Copy

	MOVL XAR5,#_PinitSize				; Store Section Size in XAR5
	MOVL ACC,@XAR5						; Move Section Size to ACC
	MOVL XAR6,#_PinitLoadStart			; Store Load Starting Address in XAR6
    MOVL XAR7,#_PinitRunStart			; Store Run Address in XAR7
    LCR  copy							; Branch to Copy 

	MOVL XAR5,#_SwitchSize				; Store Section Size in XAR5
	MOVL ACC,@XAR5						; Move Section Size to ACC
	MOVL XAR6,#_SwitchLoadStart		; Store Load Starting Address in XAR6
    MOVL XAR7,#_SwitchRunStart			; Store Run Address in XAR7
    LCR  copy							; Branch to Copy

	MOVL XAR5,#_TextSize				; Store Section Size in XAR5
	MOVL ACC,@XAR5						; Move Section Size to ACC
	MOVL XAR6,#_TextLoadStart			; Store Load Starting Address in XAR6
    MOVL XAR7,#_TextRunStart			; Store Run Address in XAR7
    LCR  copy							; Branch to Copy

	   
  	LB _c_int00				 			; Branch to start of boot.asm in RTS library

copy:	
	B return,EQ							; Return if ACC is Zero (No section to copy)

	SUBB ACC,#1

    RPT AL								; Copy Section From Load Address to
    || PWRITE  *XAR7, *XAR6++			; Run Address

return:
	LRETR								; Return

	.end
	
;//===========================================================================
;// End of file.
;//===========================================================================
