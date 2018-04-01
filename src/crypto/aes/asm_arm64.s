// Copyright 2017 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

#include "textflag.h"

// func encryptBlockAsm(nr int, xk *uint32, dst, src *byte)
TEXT ·encryptBlockAsm(SB),NOSPLIT,$0
	MOVD	nr+0(FP), R9
	MOVD	xk+8(FP), R10
	MOVD	dst+16(FP), R11
	MOVD	src+24(FP), R12

	VLD1	(R12), [V0.B16]

	CMP	$12, R9
	BLT	enc128
	BEQ	enc196
enc256:
	VLD1.P	32(R10), [V1.B16, V2.B16]
	AESE	V1.B16, V0.B16
	AESMC	V0.B16, V0.B16
	AESE	V2.B16, V0.B16
	AESMC	V0.B16, V0.B16
enc196:
	VLD1.P	32(R10), [V3.B16, V4.B16]
	AESE	V3.B16, V0.B16
	AESMC	V0.B16, V0.B16
	AESE	V4.B16, V0.B16
	AESMC	V0.B16, V0.B16
enc128:
	VLD1.P	64(R10), [V5.B16, V6.B16, V7.B16, V8.B16]
	VLD1.P	64(R10), [V9.B16, V10.B16, V11.B16, V12.B16]
	VLD1.P	48(R10), [V13.B16, V14.B16, V15.B16]
	AESE	V5.B16, V0.B16
	AESMC	V0.B16, V0.B16
	AESE	V6.B16, V0.B16
	AESMC	V0.B16, V0.B16
	AESE	V7.B16, V0.B16
	AESMC	V0.B16, V0.B16
	AESE	V8.B16, V0.B16
	AESMC	V0.B16, V0.B16
	AESE	V9.B16, V0.B16
	AESMC	V0.B16, V0.B16
	AESE	V10.B16, V0.B16
	AESMC	V0.B16, V0.B16
	AESE	V11.B16, V0.B16
	AESMC	V0.B16, V0.B16
	AESE	V12.B16, V0.B16
	AESMC	V0.B16, V0.B16
	AESE	V13.B16, V0.B16
	AESMC	V0.B16, V0.B16
	AESE	V14.B16, V0.B16
	VEOR    V0.B16, V15.B16, V0.B16
	VST1	[V0.B16], (R11)
	RET

// func decryptBlockAsm(nr int, xk *uint32, dst, src *byte)
TEXT ·decryptBlockAsm(SB),NOSPLIT,$0
	MOVD	nr+0(FP), R9
	MOVD	xk+8(FP), R10
	MOVD	dst+16(FP), R11
	MOVD	src+24(FP), R12

	VLD1	(R12), [V0.B16]

	CMP	$12, R9
	BLT	dec128
	BEQ	dec196
dec256:
	VLD1.P	32(R10), [V1.B16, V2.B16]
	AESD	V1.B16, V0.B16
	AESIMC	V0.B16, V0.B16
	AESD	V2.B16, V0.B16
	AESIMC	V0.B16, V0.B16
dec196:
	VLD1.P	32(R10), [V3.B16, V4.B16]
	AESD	V3.B16, V0.B16
	AESIMC	V0.B16, V0.B16
	AESD	V4.B16, V0.B16
	AESIMC	V0.B16, V0.B16
dec128:
	VLD1.P	64(R10), [V5.B16, V6.B16, V7.B16, V8.B16]
	VLD1.P	64(R10), [V9.B16, V10.B16, V11.B16, V12.B16]
	VLD1.P	48(R10), [V13.B16, V14.B16, V15.B16]
	AESD	V5.B16, V0.B16
	AESIMC	V0.B16, V0.B16
	AESD	V6.B16, V0.B16
	AESIMC	V0.B16, V0.B16
	AESD	V7.B16, V0.B16
	AESIMC	V0.B16, V0.B16
	AESD	V8.B16, V0.B16
	AESIMC	V0.B16, V0.B16
	AESD	V9.B16, V0.B16
	AESIMC	V0.B16, V0.B16
	AESD	V10.B16, V0.B16
	AESIMC	V0.B16, V0.B16
	AESD	V11.B16, V0.B16
	AESIMC	V0.B16, V0.B16
	AESD	V12.B16, V0.B16
	AESIMC	V0.B16, V0.B16
	AESD	V13.B16, V0.B16
	AESIMC	V0.B16, V0.B16
	AESD	V14.B16, V0.B16
	VEOR    V0.B16, V15.B16, V0.B16
	VST1	[V0.B16], (R11)
	RET