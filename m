Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793183470;
	b=rc6B6m1ao5AoNGcaV5WMI34my23g9rgkBVHjn4dcHyxQDQgbOkcoREwPykdIKiya3HKQ
	 OBQmSWLqKcHWrSz6YfGqLXOdAGogj8dcleYCtkVFOxvmMJxW2ZehBObfZfZn3rJmP8ZEr
	 sM8/SHWP5y1MSdQV53jQ/79vAIX6JZia9KvpMwS2gAkg3oJnZ3WZ2Hylr6Ky2Wo+q0NcN
	 eYIig9Au3Ueau1SGSoUwljNLnoc9i7jay7roAkGZPZWnUDgFWf9BAUPUuB5pv0QLwO0Aw
	 DWV6jBKnU81ZTTIqsQR3KlKahOhT7g/kxZqTM3HRNK9comjjY8M2ucIFXGOBTS4sswg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793183470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HTHxbZ6qE5Era12xleC9JgAV+z8lPfOhstehEnGxVpw=;
	b=EJ4aBaZ0XVzum0C5lyJSn96AHRuRsXLeiKgi2SSoVcHWUGXTGJ00Wd65dKEeC+nqDz7a
	 a/xcMlhDD0ExRTU2KsFk8wj6UrcyTJOPh2frl8W65boVsAw3SqTExAmdbZJAA923s3dJN
	 8SeVDq2N8PG2/dEo2KC53T2/EpgMZlbcyXp4/edcwJP5OTEcYCCmLVU6OJxi4WNJq00zT
	 KpCltMbTKvl1d9hva4PFE2wodZpbOqPiAnVhZxE7ctMTcGK+Wx04uoJL1Uux4Z3VFnsAa
	 M3cRHv4f+Rl1AZwUJBXG1tu5Mj5S6em+cwfPNwPZqHgDuqUVs8J3lODPcSy864fNQCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wF2X2R7Y;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A1606A31C
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 10:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 510A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wF2X2R7Y
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so7289435e9.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793183468; x=1793788268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HTHxbZ6qE5Era12xleC9JgAV+z8lPfOhstehEnGxVpw=;
        b=wF2X2R7YzgOGqqkrWOJGYWNH//5VT3msW5jN0tuiRxlDW3pDuT5rM/B9QT5Q8QJf0h
         vfF9XXVy369N6QGZVc3IQh4ul38PMO81wHB9elDwMEaun6m36pHNQwO9sPVUMTcBsJ5g
         U2yIy0Fe/BTH2NDJHTQglJw49MsR9xrN8kepGMvwUN0n7ekkdN73bxD9iIgVlojCpoPf
         pLTQdp6qc/dfYGs55FUymgISy+CM5gJ5svCBCrdnIjxtMnTy+CfWUojNKRXyUtqcIVUi
         GwyKZ7Et9qKtkBo4A38e+snBl06h9rl/hTAJ4F0bGJmSVXfWD7YnU94p7H8BMXgVzVpp
         XQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793183468; x=1793788268;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HTHxbZ6qE5Era12xleC9JgAV+z8lPfOhstehEnGxVpw=;
        b=JJddA6yc+9qItIo9+AHX5dur+bvvx4sBdOizGtQlHYlvDAOFEhRq+gS5GstNaMvX2d
         zqixfxDsCZhJ0u0AjGEllugXnL1y1HEdnVbAQRZiA8bDbOPW8bqQinnz9SiTiMpbrXL7
         FpoO6I00SnR6VraDTyH9CYb6yxZEriridMTRGAcFcPHA2D78sQrHHRD8iR+WWuCZ9gXm
         wAscgxtESmpjn259GNDIZGe2S2uRACiAXC9vBVpKOgvC9hErIHc35cBhIxk1cvqB4vRF
         Ikj/xSID6reHd/pSMDc64mxsMQDoKeM1yRCgTHCfFiW8Zce0fF6ah7bh3BK2unFLg3KX
         XVQw==
X-Forwarded-Encrypted: i=1; AKwUvBzjuR0ZwNchkzdEfRn3L4iGi1wckxwScsa0/HBXZ5IUeudbceJCRQlhLLExCKzbD47+8gy4KK5fgRw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/ehCAyYbGJyerICAamY2feKPCfDTM7JxAYzsKSQdhz92+beHN
	XyOPjSYggDEZYY4xxbprRxXAnwhj/hvf3FsiuuzDAF66H2RdPN2trLhv
X-Gm-Gg: AYBFou0F3MoIjtm24YfkdUCxZCnZG0WD4GVTKadp00EjNHF+t6kKz8sy6G7hm8CUpfb
	BlLrOGlWffbWW6urSccGJx/ucO90KSd5Lcc0aE8AaV1dSiHNpjWDPLR5SJ7QSONseb4v/6tyvNh
	pVYHJA6KkTkt6jZWlYMR4t+DpApi9tdEIN2aq3GNoIjPde8OW904+e1lr/HGWi8n+sGY9V3VQ4y
	O8kwqgP3iLt+HXaHT4Q9K3dWlQuRGQ/du740EyCNdRRte7UkzRAKYpD4oh+IfKc/w9sIOd4R/zd
	G3k6GgpkN/HbjT5pOTYtArcqujHPQTWljWdEhMoiKyi4LyxP7ysz2PvCQ18/NBvfKCsuf6Jy3g7
	lQRYzw1zjh/4R7xJtYFacWr15q2BwQuihXGxsXZLlQ1aY90nV/D0+2/lu9Z6krxCmDoQtUfntOE
	XqaOvCSjdZfD7g+d5toluEKoKGFB9X3Qcqx8qkj8CDFGv+QRTgn+ssx/UxmW2YhPJLuhHREWCov
	SMfH1yZ7zXPy2nb6Vs7V/nnQZwnnCVHgyq5X1HWVItgLRXlmC/4wM8g+8gLQhzPp8CFQJ1b+9QZ
	ewNUxhVuPrPmocFVUwTHUzGQfF94ABdTjUx8zr/m2gSE4SQ+JSgT3qn/D/MvjmRQWw==
X-Received: by 2002:a05:600c:37c3:b0:4a1:7c7d:8881 with SMTP id 5b1f17b1804b1-4a96695f317mr37325365e9.13.1793183467424;
        Wed, 28 Oct 2026 03:31:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd354asm26676045f8f.43.2026.10.28.03.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 03:31:06 -0700 (PDT)
Date: Wed, 28 Oct 2026 10:31:05 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, David Laight
 <David.Laight@aculab.com>, Victor Chernyakin
 <chernyakin.victor.j@outlook.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iio: prepare iio_format_value to handle
 higher-precision IIO_VAL_DECIMAL64_* formats
Message-ID: <20261028103105.0053c079@pumpkin>
In-Reply-To: <auGuGfSqa-D9sceB@ashevche-desk.local>
References: <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
	<SN1PR12MB2528906BE220765FAF201080A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
	<25g6fr7y4bmd6bzomvlvoejtps7wzbnbuuxxipmcrnozujno2l@klcfyrmqsifd>
	<auGuGfSqa-D9sceB@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Oct 2026 10:11:05 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Oct 27, 2026 at 03:56:35PM -0300, Rodrigo Alencar wrote:
> > On 26/10/26 11:51, Victor Chernyakin wrote:  
> 
> +Cc: David Laight
> 
> ...
> 
> > > +/*
> > > + * Regular abs(LLONG_MIN) causes signed overflow, which is undefined
> > > + * behavior. This variant avoids that by performing the computation in an
> > > + * unsigned type, for which negation is always well-defined.
> > > + */
> > > +static inline u64 abs_s64_no_overflow(s64 x)
> > > +{
> > > +	return x < 0 ? -(u64)x : (u64)x;
> > > +}  
> > 
> > I think I've seen Andy doing mentions to a needed 'safe' abs() a couple of times.
> > Don't we have something in the tree already? if not, Why not adding a
> > 'unsigned' abs function to math.h? something like:  
> 
> Or maybe something clever using the s64/u64 domain for all.
> Let's gather David Laight's opinion.

Well, it might be UB, but that is probably mostly related to '1s compliment'
and 'sign overpunch' number schemes.
So, in practise (u64)(x < 0 ? -x : x) probably always gives the right answer.
The kernel is also compiled with -Wno-strict-overflow which also stops the
compiler doing unexpected things.
OTOH clang is know for 'silently just throwing away code' if it detects UB
behaviour, so code that is fine with variables can get miscompiled for
constants.
(All not helped by it being undefined behaviour, not undefined result.
And the 'behaviour' bit really being 'might trap'.)

This should work for all types (except s128 - not used in the kernel):
#define abs(x) ((x) >= 0 ? (x) : (u64)-((x) + 1) + 1)
or maybe the equivalent:
#define abs(x) ((x) >= 0 ? (x) : -((x) + 1) + 1ull)
which will generate the correct bit-pattern for s128.

The negate is always well defined and its result in non-negative.

gcc and clang also realise that the (u64) cast always zero extends
so can be optimised away for 32bit values (especially relevant for
32bit compiles).
Note that optimisation may not happen (I've not checked) if you use
a real function with an s64 argument.
(Which also has a downside if code passes a very large unsigned value.)

Oh, and the compilers realise the '+ 1' cancel out and throw them away.

David

> 
> > /**
> >  * uabs - return absolute value of an argument as an unsigned type
> >  * @x: the value.
> >  *
> >  * Unlike abs(), the result is well defined when @x is the minimum value of
> >  * a signed type, since the negation is done in the unsigned domain.
> >  *
> >  * Return: an absolute value of @x, as the unsigned counterpart of its type.
> >  */
> > #define uabs(x)	__uabs_choose_expr(x, long long,			\
> > 		__uabs_choose_expr(x, long,				\
> > 		__uabs_choose_expr(x, int,				\
> > 		__uabs_choose_expr(x, short,				\
> > 		__uabs_choose_expr(x, char,				\
> > 		__builtin_choose_expr(					\
> > 			__builtin_types_compatible_p(typeof(x), char),	\
> > 			({ signed char __x = (x);			\
> > 			   (unsigned char)(__x < 0 ? -(unsigned char)__x :	\
> > 						     (unsigned char)__x); }),	\
> > 			((void)0)))))))
> > 
> > #define __uabs_choose_expr(x, type, other) __builtin_choose_expr(	\
> > 	__builtin_types_compatible_p(typeof(x),   signed type) ||	\
> > 	__builtin_types_compatible_p(typeof(x), unsigned type),		\
> > 	({ signed type __x = (x);					\
> > 	   (unsigned type)(__x < 0 ? -(unsigned type)__x :		\
> > 				     (unsigned type)__x); }), other)  
> 

