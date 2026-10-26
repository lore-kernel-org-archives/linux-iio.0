Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030018;
	b=q6YWnmT9cBDdUPdYbb/XKcrQu0hbxaXO/3nLrlXFpQ7OWUx30aVSkvGaHnTNX21bio+l
	 YCIJVvsWViox0+YHj0vkWNniNzH3wj5AWB3uYEmiF9j90I/hdGo0qEbDuNjJdqo5ngeHr
	 1QIDNvWBl34xVG82vKJ1B+MyIsX+Ba2FVB1ZtQyXh66J8YVxKB+1v6WNmsItEdFSOoXwc
	 HL2AGWBOSyTCBjAR0dhf50W36iggGAcrP2RVIYUiEt2IFlWhrzbXoy90IY5itUcpPk1W/
	 K8hh5nWmHqQgQO6LHxscGinpAnCr68KF2slaKkEx4L1kgEMd/J12HIcZE7GMKGJoRag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=u6wrdDfBUAx+lhpOjfgvo/YG0J1lc0DhZKLgshqkArk=;
	b=rBSGXKqXgixBDEixmjFkjI5kGlxocOP3SBkfjQwj3YyyMbYgN7O+9Z65vW29J0+Axe3g
	 5gmj0xiPVA42rOwXq1fMWLItJ0OULCP7azWuu3DW15zQ+86U0IvWSdnETyyPROp21v86m
	 Wa24J/rnSmEGDVX3u6GUrE+K9286SDTn06ZEr9xIARW1zew6OmS5gD2li875jT9CFesSL
	 SSz0fHZCNPNfvRQ2pV0IBUR+nTiXW5dOW9QkWv/n6lHZQEwlwWCnQffIh5q3tM7/SXXk2
	 HfTyqDMX9OGI2HY6zTTwq+h20Lee1wLWLE2h+dNwbiT5HbTGMlrWqVUK+HYfm12Wyxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D2pXuL95;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DDF606A31E
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 15:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69DDF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D2pXuL95
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b0dba37a7fso25637447b3.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793030017; x=1793634817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u6wrdDfBUAx+lhpOjfgvo/YG0J1lc0DhZKLgshqkArk=;
        b=D2pXuL954F33dcEoQ0l2BBjEirm7xH1311UAnQZlNeVJn15Fno9zyTIfnqI9esHlr0
         YcAAysF111tjJXZpXdYBWTNy1MIv0MQcziI/tPDlgWYYaa+tpJWzW8e7PtjV5Sv9G/Yu
         9g/xxILQN8m8h7RCISIIfZNwdGwo0j/a5fT2/Bo75EWcvEgyOsPcDeVR8v2p2JE5P5R6
         DBb1Oa3FPgzDJQHC1lyc9H2ig2JcZi2vTbsSHqfbTa90BhT8n8NHMwqKO0HJu7wluVLb
         CMPLd2O8Yf1EAaSsFuKl2Tj8wwzXw4sBArMT2EW6uIaynFdUXi+OFDjwoGYAl3nbILCf
         yG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030017; x=1793634817;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6wrdDfBUAx+lhpOjfgvo/YG0J1lc0DhZKLgshqkArk=;
        b=o2T2RChZ69tVtwsEuUptwK3NBFlB2wt46915x8+8Xga/xtvyZs+whpKWI8tT7KZ2bw
         JMomxHzSYMLzDqYlcL1S4TLxwDdi5CHGZ/wqlpPcbneIRAraxlHSFplF62L0+6bMo9bm
         051/Kk8jr3PX8YmBdNCNkj7l+kUtxhu7Opbk7G4LvnJYCM/lIO9qfXVnbkGaXisuxfsk
         wgsjc6dLyAmN6vDINdvm7Ttt2ObzUVZ/A+N+qpVAdrKpnPQZL8qnoWBZjndP47DIDKs/
         2rc4V4CkileL0D7Z68PcxrbJmusaUjHqKGM2Ps/T9qJgGJf45V7uaPaFiJ3lHp3oVhNk
         O5GA==
X-Forwarded-Encrypted: i=1; AKwUvBxd2N0r2lrxHD6026kZfjqOLBUJqwxlPg5l5ulrnwZraQXrZ2UXKYjhYClatK/HInoFVZ7B4GmSDXg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRSHDXZ0/EYMkIF89mxT7gxgnUbjRiJzAjg481R5zwDmz6T/0q
	wraHpmWo/A74qKN6hKKvLiavltSiJL1W3w84XyvNOpkNWeQ+9B4M2HA7NtapbQ==
X-Gm-Gg: AYBFou1NLkbXT2Pn9hPbCSpYsSpuxH8/vReDGVMoy8wyqixqE69R28A/BBKjwdUYn79
	M1eXxzFRx9ZMBKld00GowUaQYpKtPkOUXmvpcHC6rj1mXaGgNOrZNruXIm9g5OBXdpyeHbBow1V
	83D2xiTisuO7djSuSUhkshbLlUb7em+j9sVbklmqFC+0VY+D8sb84YWoDv+ZJUid20GkVyDOFBT
	vJB8yznbTxkorg17+IxJr4FmMn+vCDZfzZHR3RK+dSOPCYpm4ELqInjXjRPg/rc8tO6hynhrIMW
	QtWUTYWWqpKwpcGPdjxTGUs3f0zNr9fWaDzUZb72wCkyFTZRGotiHCbr3aUZRuOXVsG4DL/o9Ro
	AhqFpOJvGLMnhuN+FFhV5deJw6V/jEoNWLNlRQSsu6Jm6pUQkj6kfimsbLRA8ujs7YtkchYS6tj
	f51gYPXwnVzLRH4Zf/03QQ1YspYjSXcuqALm3R8BhPnMtOmm4dYlyt87SaBB4LJ03SAbcZdPplm
	lVyXU1lpdg3owWTa84OmBdekLwB4aBoXYuhYpTXElYwLLqMbyLNsXHHWOI5SXj2cgitvotlHUY8
	ESZXSUvnwjVvEAhy9YiHWUhmfbMynD0iJ+ddyAORQBVYP5nleEk=
X-Received: by 2002:a05:690c:7445:b0:8a6:1205:12e8 with SMTP id 00721157ae682-8b166c1b1bemr49338827b3.44.1793030017363;
        Mon, 26 Oct 2026 08:53:37 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.30.netskope-rdns.com. [158.95.44.30])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e46a93sm33895977b3.26.2026.10.26.08.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:53:36 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 26 Oct 2026 12:53:28 -0300
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v4 5/6] iio: core: use kstrtodec64() to parse fixed-point
 values
Message-ID: <5ufw5zi4x5rrhs3wcm7kt7k3a2xv2edibbrzoucn3pxr2lddyw@op6eytgbgn2a>
References: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
 <20261026-e-notation-v4-5-a366a6d14d57@analog.com>
 <at9plejNuVxO2V-A@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at9plejNuVxO2V-A@ashevche-desk.local>

On 26/10/26 16:54, Andy Shevchenko wrote:
> On Mon, Oct 26, 2026 at 08:54:09AM -0300, Rodrigo Alencar via B4 Relay wrote:
> 
> > Replace the open-coded __iio_str_to_fixpoint() parser with kstrtodec64(),
> > so sysfs writes of fixed-point values also accept E notation.
> > 
> > The fractional part only keeps the sign when the integer part is zero,
> > as before. The dB suffix for scale attributes is now handled by a separate
> > __iio_str_to_fixpoint_units() helper. It strips an optional trailing
> > newline and the "dB" or " dB" suffix before parsing.
> > 
> > When there is no fractional part (fract_mult == 0, or dec_scale == 0 for
> > 64-bit values), try base-autodetecting kstrtoll() first so hexadecimal
> > and octal input keeps its meaning ("010" is still 8). Fall back to
> > kstrtodec64() on -EINVAL to accept E notation.
> 
> > As a side effect, inputs that used to be rejected for integer-only
> > attributes are now accepted. An invalid octal number such as "08" is
> > parsed as decimal 8, and a fractional value such as "1.5" is rounded
> > to 2.
> 
> The main question here is: Do we want these side effects?
> And follow up question is: Where is it going to be documented?
> I consider this paragraph is very important for the users.

I see that those side effects turn the sysfs interface more robust to user input,
not an interface change, but indeed a behavior change on edge cases. To answer
the first question, yes, I would want those...

Userspace can do floating point math on physical values and scales and write the
result to raw integer attributes as is. Rounding to nearest acceptable values is
something that drivers often do themselves.

I am not really concerned about the invalid octal case input.

Also, no valid input being used so far is being invalidated with this.

As for the follow up question, I can add some details to iio_str_to_fixpoint() doc
header, which is the exported symbol here.

> 
> ...
> 
> > +	/*
> > +	 * Keep hex/octal support for integers. E notation and decimal values
> > +	 * result in -EINVAL from kstrtoll, due to unexpected termination on '.'
> 
> kstrtoll()
> 
> > +	 * or 'e'. It falls back to kstrtodec64 for decimal fixed-point numbers
> > +	 * with zero scale.
> > +	 */
> > +	ret = kstrtoll(str, 0, val);
> > +	if (ret == -EINVAL)
> 
> > +		ret = kstrtodec64(str, 0, val);
> 
> 		return kstrtodec64(str, 0, val);
> 
> ?
> 
> > +	return ret;
> 
> ...
> 
> >  int iio_str_to_fixpoint(const char *str, int fract_mult,
> >  			int *integer, int *fract)
> >  {
> > -	return __iio_str_to_fixpoint(str, fract_mult, integer, fract, false);
> > +	s64 dec64;
> > +	int ret;
> > +
> > +	if (fract_mult) {
> > +		/* scale = ffs(fract_mult) = ffs(10^n) = ffs(2^n * 5^n) = n + 1 */
> > +		ret = kstrtodec64(str, ffs(fract_mult), &dec64);
> > +		if (ret)
> > +			return ret;
> > +
> > +		dec64 = div_s64_rem(dec64, fract_mult * 10, fract);
> > +		/* only carry the sign in fract if the integer is zero */
> > +		if (dec64)
> > +			*fract = abs(*fract);
> 
> Should we actually switch to UB-free abs() implementation?

abs(fract) here is always less than 10^9 (largest power of 10 that fits 32-bits),
I'd say that this is not a concern. 

> 
> > +	} else {
> > +		ret = iio_str_to_s64(str, &dec64);
> > +		if (ret)
> > +			return ret;
> > +
> > +		*fract = 0;
> > +	}
> > +
> > +	if (dec64 > INT_MAX || dec64 < INT_MIN)
> > +		return -ERANGE;
> > +
> > +	*integer = dec64;
> > +
> > +	return 0;
> >  }

...

-- 
Kind regards,

Rodrigo Alencar
