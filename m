Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45121332918
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049407; cv=none; b=O/dbzedbandXnhueL7FZvA15npL8G55uE3byOTy5ktXJpjF369qBSHO5by5ZnPqpAeEzNbYUq07opqIvyKA/pC/EZsA8VeKWhrO0TiS7Nk17rlBdXI6BlR37zVg0j6Dn/fY+wnRtvVlJ33yI9IMgyASjxfrhCEaJ9NanjIobzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049407; c=relaxed/simple;
	bh=ZQ0cluxrrGAAgQmJ2b7UrPz8J+y8NMc4NZcDA7xAclU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhwjCIWD+kyk334uNR5NxM2VIVHLxZNgZ9exzI9zMPqtoGWxSDblxXBp+KewCw3KLI9KjZQZ04HlrYlnMiRqSLZmcb0vclj5Eg7HMbka1oMZuVzJSvHMIQhzY+QtoED+4VEDdq8aTj0r91i5cfwS3KNNP1LDQDGXBbVEpKD6jfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rL293tua; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rL293tua"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9961e4f71bso1015333266b.3
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775049405; x=1775654205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=apbYBRg9b/3DX+6GYzgJ9nE4vIASqDiH9mcyDG+Y7O4=;
        b=rL293tuab6Ab3LMDJXyCFrElCvLeraYcfqMV5T0rDhRghL9C/AU/eiHaOaWNFjkIDa
         6M05uARSXg0CJcTNdCm+bJIPNYv66Ky7rcG6aivbOO8/oYthyKhur0YgesCakERFgHoX
         xbUxZFktNfikw9SYs638qW3yqd/F0Ndhaipbfa4yo6qUPSJ3hd+Wxl8u0AZJ+XbOTH6w
         hBPd/BFDmSpDQvLqad2VBIeKPexuzZfC/RGPDKeO4EG5O8jI2CNtpzpPAiHVgEj9g4Gg
         JNai8rWkJiZt+Vlu7t3LuyBf9+8q4N9UyvhsCLPsU7juXVwN97FjyBUHQThTSOftBD18
         Um8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775049405; x=1775654205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apbYBRg9b/3DX+6GYzgJ9nE4vIASqDiH9mcyDG+Y7O4=;
        b=q6UX2Ay1NKDsK71KNd1E6c1h0coKggX07g5DjUxAJg0wZI+8594nxeSXrN1njWoH4B
         BZxj7ceaXXGIwClrncEVhfvsM73nHmC0J+VuhTSYp3Nso0k3vmSnj+xdDc4Qy9JyFYu4
         gVOJoTOnsqkGG2p5SGH5pCaNRaVIVs6FoJo3doJZ913Uxo/JqgLL/UXDnGEf3kG1tuNG
         F+yRWaQmuPnKzAQKBPG6EUWPfzw+TuRNJVyyRUlOs2sGJvbHrY9VZ1TGm4tp3EqDsclq
         N3iqyzYKuqQPVD78V3X3Pip7QDoLmPH9TWTrj9na4jUDMAIDAuM9Jv3zDmYUax41GEgn
         AhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+0rqQCib0jbtAAA1Jo/Oi0131NWCz4R6ih2KB4667KJfK5HLlhgKnEYzPh9xxck+YY8oXYPsJTvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+FPoXJFYZLRD3Je4IXQD4c36ehoThWe9CywcuTzSeqbRzwDaY
	Y1OVvIIVjk+c2XvGLwOc4kcmHG90g8ARC7JJ8t5XqU6E+TDHBGASwKty
X-Gm-Gg: ATEYQzw9qMv0X+O6j5H5UpGnJoIU1tTkkJ5eYYirtGHccWQZfQYHthqc3ZVwwQehY5h
	qKUKeAqdVgUvGWMfIYph5M/bI2+Dg27m/SR6LbfsfPbcpvZRRmppmVHJ2OPHKVdRCSwLxXDy1P+
	fveYyAWXjT6kvc+27Sl6NRjVIc2Nw4pSLriHhsCtg6Y7tgJ2jToYmv5SDawpCl2eH+CeRoe1Vfd
	/b2pAuv3+CUDHcAVQ/6ltnFAvMB/FJ/nTBIuziSArh2AIkC6wuwRU0uuapkP+rE67Vbcv8jNJ8O
	skkM3iwYLTqtrQIHWZBtHLI7hjq9gzoxPIkgAfIDVmL5MATt/8pO8zU8T18SVk0tIjWGlyNPDAS
	pWNvfvx756ysd5Gx0RFCAk4tC2kbin3eDC+7a/50RWslXqvJNBAZt7rSPwvWk8/sdKlWfMYd+Zv
	sLjlyukWNwlXp5tBl0oSe1jC4x3Vf3S38xEwNv027YQ9jCGLegGXPqxpTjlX+kMLUsGo2OBYcMs
	Axmz4rqw9ZgfssXlJbOtZAzMNC4ZoM3aYSUAxN0/dnWuWpOZ+0=
X-Received: by 2002:a17:907:2d1f:b0:b90:8016:cfe4 with SMTP id a640c23a62f3a-b9c137a088amr261514666b.10.1775049403891;
        Wed, 01 Apr 2026 06:16:43 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c0219ed95sm145275666b.29.2026.04.01.06.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 06:16:43 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 1 Apr 2026 14:16:36 +0100
To: Petr Mladek <pmladek@suse.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v9 2/9] lib: vsprintf: export simple_strntoull() in a
 safe prototype
Message-ID: <24jfl2btofko7iqxz7rlqdbr73yjaf46plfvnrc4zj77i4zbkj@apmruc23fw6f>
References: <20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com>
 <20260320-adf41513-iio-driver-v9-2-132f0d076374@analog.com>
 <acZDneLrIPOmU5ci@pathway.suse.cz>
 <acZLHAT5qJyjKTsp@ashevche-desk.local>
 <4uijfg4efzaapu3esobez55hfwqzszwagpeb4lxej2ybmifu76@s3c57fmnsme6>
 <acZaGUV0MwuHNDru@ashevche-desk.local>
 <x34d7jz7be4ommjh6efx5mcq5pbpellykwuyrqayr4ske3lywf@wh46mu3anmcz>
 <qnb3ozrhrq5n4zkh2luitkpwr5oj4omgcuo5vnvy2gatdfdqlg@cgsgux7etcql>
 <ac0N89sNYcKAJkAP@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac0N89sNYcKAJkAP@pathway.suse.cz>

On 26/04/01 02:22PM, Petr Mladek wrote:
> On Mon 2026-03-30 13:49:48, Rodrigo Alencar wrote:
> > On 26/03/27 03:17PM, Rodrigo Alencar wrote:
> > > On 26/03/27 12:21PM, Andy Shevchenko wrote:
> > > > On Fri, Mar 27, 2026 at 10:11:56AM +0000, Rodrigo Alencar wrote:
> > > > > On 26/03/27 11:17AM, Andy Shevchenko wrote:
> > > > > > On Fri, Mar 27, 2026 at 09:45:17AM +0100, Petr Mladek wrote:
> > > > > > > On Fri 2026-03-20 16:27:27, Rodrigo Alencar via B4 Relay wrote:
> > 
> > ...
> > 
> > > > > > Maybe we want to have kstrtof32() and kstrtof64() for these two cases?
> > > > > > 
> > > > > > With that we will always consider the fraction part as 32- or 64-bit,
> > > > > > imply floor() on the fraction for the sake of simplicity and require
> > > > > > it to be NUL-terminated with possible trailing '\n'.
> > > > > 
> > > > > I think this is a good idea, but calling it float or fixed point itself
> > > > > is a bit confusing as float often refers to the IEEE 754 standard and
> > > > > fixed point types is often expressed in Q-format.
> > > > 
> > > > Yeah... I am lack of better naming.
> > > 
> > > decimals is the name, but they are often represented as:
> > > 
> > > 	DECIMAL = INT * 10^X + FRAC
> > > 
> > > in a single 64-bit number, which would be fine for my end use case.
> > > However IIO decimal fixed point parsing is out there for quite some time a
> > > lot of drivers use that. The interface often relies on breaking parsed values
> > > into an integer array (for standard attributes int val and int val2 are expected).
> > 
> > Thinking about this again and in IIO drivers we end up doing something like:
> > 
> > val64 = (u64)val * MICRO + val2;
> > 
> > so that drivers often work with scaled versions of the decimal value.
> > then, would it make sense to have a function that already outputs such value?
> > That would allow to have more freedom over the 64-bit split between integer
> > and fractional parts.
> > As a draft:
> 
> My understanding is that you want to allow parsing frequencies
> in the range from microHz to GHz.

Correct, the ABI requires the values in Hz, and I would like to support
micro Hz resolution, so that 10 GHz can be represensted as:

	10000000000.000000 
 
> So, you might want to support input in simple float numbers
> with some precision, for example, 1.2GHz, 0.345Hz, ...
> 
> By simple, I mean that there is no x10^3 or so.
> 
> > static int _kstrtodec64(const char *s, unsigned int scale, u64 *res)
> 
> I would personally change this to something like:
> 
>   static int _unit_float_ktstrtodec64(const char *s, unsigned int precision, u64 *res, char **unit)

I don't really need "unit" for my specific use case, IIUC this pattern is not
something to be handled by kstrto*(), because those function should requires NUL
termination. I am not sure why is that, but I like the idea of returning a
const char* pointer to the end of the conversion (that was the whole point of
having something like kstrntoull())
 
> It would allow to read float number in the the format XXXX.YYYYunit,
> for example 1.2Ghz
> 
> , where:
> 
>   + _unit_ means that it might set @unit pointer which point to the unit
>     string right after the number part.

as mentioned, the units is defined in the ABI, so this part is not really needed.

>   + _float_ means that it will be able to read float numbers

its a decimal fixed precision, decimal point should not float.

> 
>   + @precisions parameter defines the number of digits accepted
>     after the radix point. It is also used as multiplier for scaling
>     the output number.

precision != scale, for this case we have a fixed precision of 64-bits.
while scale is passed as parameter.

Reference:
	https://www.ibm.com/docs/ro/informix-servers/12.10.0?topic=types-decimalps-data 

> 
>   + @res is pointer to the read number multiplied by the given
>     @precision
> 
>   + @unit will be set to string after the number
> 
> For example:
> 
>   + s="1.2GHz", precision=3 will result in *res=1200, *unit="GHz"
>   + s="0.0100004", precision=3 will result in *res=10, *unit=""
>   + s=1.234567GHz, precision=3 will result in *res=1235, *unit="GHz"
> 
> Note that the result is rounded in the last example.
> 
> The function might be used like simple_strtoull() in memparse(),
> see lib/cmdline.c. Which is able to read the given size in B
> and handle various units like kB, GB, ...

As dicussed above, scaling the value based on the units is not my use case.

> 
> > {
> > 	u64 _res = 0, _frac = 0;
> > 	unsigned int rv;
> > 
> > 	if (*s != '.') {
> > 		rv = _parse_integer(s, 10, &_res);
> > 		if (rv & KSTRTOX_OVERFLOW)
> > 			return -ERANGE;
> > 		if (rv == 0)
> > 			return -EINVAL;
> > 		s += rv;
> > 	}
> > 
> > 	if (*s == '.') {
> > 		s++;
> > 		rv = _parse_integer_limit(s, 10, &_frac, scale);
> > 		if (rv & KSTRTOX_OVERFLOW)
> > 			return -ERANGE;
> > 		if (rv == 0)
> > 			return -EINVAL;
> > 		s += rv;
> > 		if (rv < scale)
> > 			_frac *= int_pow(10, scale - rv);
> > 		while (isdigit(*s)) /* truncate */
> > 			s++;
> 
> We might/should use the first digit to round the _frac.

flooring should not be a problem if it is documented like that.
I suppose we cannot afford to carry over all roundings from
subsequent digits. If so, we would be parsing it all and use
div64 which I would like avoid.

> > 	}
> > 
> > 	if (*s == '\n')
> > 		s++;
> > 	if (*s)
> > 		return -EINVAL;
> 
> I would omit this. Instead I would set @unit pointer so that the
> caller might handle units defined after the number.

I understand that this is the whole point of creating a kstrto*()
function.

> > 	if (check_mul_overflow(_res, int_pow(10, scale), &_res) ||
> > 	    check_add_overflow(_res, _frac, &_res))
> > 		return -ERANGE;
> > 
> > 	*res = _res;
> > 	return 0;
> > }
> 
> Otherwise, this approach looks sensible to me. IMHO, some generic
> API for reading numbers with misc units should be usable in more
> situations. And it would make the kernel interface more user
> friendly.
> 
> Of course, we must not over-engineer it. But the above does not
> look much more complex than we already have.

I really appreciate your time looking into this, thanks.
 
-- 
Kind regards,

Rodrigo Alencar
