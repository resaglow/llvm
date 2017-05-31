	.text
	.intel_syntax noprefix
	.file	"main.cpp"
	.globl	_Z8example8v
	.p2align	4, 0x90
	.type	_Z8example8v,@function
_Z8example8v:                           # @_Z8example8v
	.cfi_startproc
# BB#0:                                 # %entry
	push	rbp
.Lcfi0:
	.cfi_def_cfa_offset 16
.Lcfi1:
	.cfi_offset rbp, -16
	mov	rbp, rsp
.Lcfi2:
	.cfi_def_cfa_register rbp
	mov	dword ptr [rbp - 4], 5
	mov	dword ptr [G], 11
	pop	rbp
	ret
.Lfunc_end0:
	.size	_Z8example8v, .Lfunc_end0-_Z8example8v
	.cfi_endproc

	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	push	rbp
.Lcfi3:
	.cfi_def_cfa_offset 16
.Lcfi4:
	.cfi_offset rbp, -16
	mov	rbp, rsp
.Lcfi5:
	.cfi_def_cfa_register rbp
	sub	rsp, 16
	mov	dword ptr [rbp - 4], 0
	mov	dword ptr [rbp - 8], 0
.LBB1_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmp	dword ptr [rbp - 8], 1
	jge	.LBB1_4
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB1_1 Depth=1
	call	_Z8example8v
# BB#3:                                 # %for.inc
                                        #   in Loop: Header=BB1_1 Depth=1
	mov	eax, dword ptr [rbp - 8]
	add	eax, 1
	mov	dword ptr [rbp - 8], eax
	jmp	.LBB1_1
.LBB1_4:                                # %for.end
	mov	eax, dword ptr [rbp - 4]
	add	rsp, 16
	pop	rbp
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc

	.type	G,@object               # @G
	.bss
	.globl	G
	.p2align	4
G:
	.zero	39999996
	.size	G, 39999996


	.ident	"clang version 4.0.0 (tags/RELEASE_400/final)"
	.section	".note.GNU-stack","",@progbits
