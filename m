Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A833CEB5
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440814; cv=none; b=boU+oztdzGBSGDkEYo8R6YUiyB6HvV101gmZ3fHgS/Pm5vWdUMwHt3rVJ5xy2F4Uy5B+kk4MZBjmTC+nq2J6T1OH/Kc3DnXH7HlpEAqU6scqF5aKLiee5kUPLD0wv/DbiArKkMD5tuDJW+84XFiik6EeFHQumab+i5p8RCnOJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440814; c=relaxed/simple;
	bh=EMXDvoXJ5/2vBtxSLRj4Me8GlfV7fukQDcxRRL6oaOc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLJAv2kX+7n3aor9IwwvD/mxqZN2KCUxaSxeSsk6JUanuU3lsAFhfSHI1nogCf0j4FMYhgw1OufEb4vKixEhZVe1AO62fg8zkB+HU4qsNdvGoc590HMFMMDZ8YDOWzVeLv2QTFYdrCSPlLLaXX/1vnAwtY2Wscp8jc5KX1XgMWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXVXipko; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXVXipko"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-435a517be33so2830402f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 07:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769440811; x=1770045611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7P/+mX1PWBDAGM9xKdya4BErpz7ZLdNNb0retKVcXWk=;
        b=RXVXipkoOiAeF85KDImKGHJKUZuW4Szk6OssvaL9AK4b7Cu8sCwXMDmlRwpKO/TWxe
         J1kEpa4hZmjTrq1u3fzy4TPv33+yNnUv8gnv47ysNNyUcwPjkqtFU2eYnM+eldRsGiA+
         jbUpAg9OJbeYk8BnN/pItKbFDlJg/uyZqko+jerHgZrW98ISxMwptlv48z7DHdj1O0xH
         HyZo87OPydT8YQBlhQWlGVMO6z8qrHCgrPsY7rdtwVfcFgVnGASADDnt+7TvzutdhbJ3
         LR44saZPnxG0WLd84WNsZAoWZHgNiKaS+YEcgWUOEnxl8XTnd+ppixeWgDIdz+R3EkA2
         OYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769440811; x=1770045611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7P/+mX1PWBDAGM9xKdya4BErpz7ZLdNNb0retKVcXWk=;
        b=U+jPVQ0SAhygTVw9xknYeu/tchmeaMlgGGf5P3HhL4B2+DbmArQ69uzCytD+w5jXtT
         +zgaD8uN3VXwt0lku0v3MCJaAnHvGXUimr74No4WSh8OK5ERjN9UakKxGxCmSJy/7Nw8
         Rn9UVq1AZts7u/xEJwmJiZZeD+MmxqSuEuUZABfvVFnlk+KhT7cU9jTvzCjhRgVZobyi
         7jQGYPlIugNGn95skMgG//r6MVCL3YHNxoDWMULTLjJaDmKczE7r+lcW4CwoxzcsL9Jo
         rqR6ZhlSsFgNliwvOPRg2YoWbJKZix+OPIrPufuGYcc5f8dF10zYQD8+t9TthlVOvnAO
         lkqA==
X-Forwarded-Encrypted: i=1; AJvYcCXXzrgf0Z8gFajsnqCe7w9mz1GR5LC6Or5tUEFli25uYUlNFNwEkNdburov0iPmbVa/5JwAS63xdSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8fXLsoycrWa64RvumomVXi+MY6uw9mdxmfrZ5J5HURB9y6iB5
	ZkHRma+DpvklGcJi3j/i/38J3s3Yuzl43w15g5IwdUIHmxRG02/wAG+MqSBqQw==
X-Gm-Gg: AZuq6aLEk1bSpAsmQ/UEyjsJxT0t88aQidXPpoKH2RgZYv2TOUrqocmM4ka0ptuBJ2i
	OmZ5i6wFWyqLyS2q796tEh2NKdhlFJ29mE2s36FdgMCPVF3JBzzuI5KRArkbVz+rGihX7fiJ/Wk
	vUTVdqWN9JPjj0ZRQPxdyfxOHGWQFZxVXGK9FQJZHlXgiMPhKTZTgSBVTB0+qcOX7ZOeS+DXy3y
	04jYggEIQdZyYampHPuvs2C0G3/Bm/McwninDoEI5EjdM0pnAiZqsAZQdf14WkLqLeSIr4kwkaI
	yJuVz1zPnlUutHBp1rH+MfTbj/wafNiJVvuiL5BqsxvuEDZI9BiSyCTPIcD7EiQxiRZSx+vPfFx
	zbSqpN127DB/ulAxUQgkNRvk2PAaybYWjnuIEWHwClxi4bxon5eRfnoWjCisBhnHlDnuwXeI7xW
	5Odve2CieKei6dGH1eXsMDJzPpMTWh5JE2bz0CoHaZ0EEPAdGtFDFiN7JJNR5CfPqzv48G0AIUM
	7Kt
X-Received: by 2002:a05:6000:2404:b0:435:8aa1:ff4d with SMTP id ffacd0b85a97d-435ca0ef8a3mr7243502f8f.22.1769440811285;
        Mon, 26 Jan 2026 07:20:11 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24f15sm31673845f8f.18.2026.01.26.07.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 07:20:10 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 26 Jan 2026 15:20:03 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <n2ms3esyxlegqibu4nluut3x4c4bkjxt5xrcd4gw35xxb2tipb@a2v73y25kroc>
References: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
 <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>
 <aXdUvRZ9NmP5Nh95@smile.fi.intel.com>
 <byitgzjli5gsq5v66topve7ip3inkk2udwhuihjdp6bknnkmos@tv226l7tek7s>
 <aXdtpkL5QUhhB_hh@smile.fi.intel.com>
 <ty6hptfh65k2rkqo6c6mg5z6vismuvyqsu3emvqarr2rbhpvcz@kn6tzjk5xi2o>
 <aXd_0uNVm8c_Fhwd@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXd_0uNVm8c_Fhwd@smile.fi.intel.com>

On 26/01/26 04:53PM, Andy Shevchenko wrote:
> On Mon, Jan 26, 2026 at 02:26:20PM +0000, Rodrigo Alencar wrote:
> > On 26/01/26 03:35PM, Andy Shevchenko wrote:
> > > On Mon, Jan 26, 2026 at 12:42:53PM +0000, Rodrigo Alencar wrote:
> > > > On 26/01/26 01:49PM, Andy Shevchenko wrote:
> > > > > On Fri, Jan 23, 2026 at 03:53:07PM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> ...
> 
> > > > > > +static int __iio_str_to_fixpoint64(const char *str, u64 fract_mult,
> > > > > > +				   s64 *integer, s64 *fract, bool scale_db)
> > > > > > +{
> > > > > > +	u64 i = 0, f = 0;
> > > > > > +	char *end;
> > > > > > +	int digit_count, precision = ffs(fract_mult);
> > > > > > +	bool negative = false;
> > > > > > +
> > > > > > +	if (str[0] == '-') {
> > > > > > +		negative = true;
> > > > > > +		str++;
> > > > > > +	} else if (str[0] == '+') {
> > > > > > +		str++;
> > > > > > +	}
> > > > > > +
> > > > > > +	i = simple_strtoull(str, &end, 10);
> > > > > > +	digit_count = end - str;
> > > > > > +	if (digit_count > 20)
> > > > > > +		return -EINVAL;
> > > > > 
> > > > > Not really. If we are talking about decimal (only) cases we need to also count
> > > > > leading 0:s.
> > > > > 
> > > > > 0000000000000000000000000000000025 is still 25, no overflow.
> > > > > 
> > > > > That's why I recommend to have a helper, maybe for now locally here, like
> > > > > 
> > > > > int safe_strtoull(..., unsigned long long *res)
> > > > > {
> > > > > 	...
> > > > > }
> > > > 
> > > > Are you suggesting to not use simple_strtoull then?
> > > 
> > > Nope, I suggest to do an additional step before checking for the range.
> > 
> > You mean, conditionally skip leading 0's when parsing the integer part?
> > e.g.
> > 
> > /*function entry and arg check */
> > while(*str == '\0')
> > 	str++;
> > /* then call simple_strtoull() */
> 
> Not skipping, but counting them.
> 
> > simple_strtoull() is not overflow-safe,
> 
> Yes, I know. That's why all these additional checks are required,
> 
> > as it does not use
> > check_mul_overflow() or check_add_overflow(), only checking the
> > amount of digits is not enough.
> 
> Why? Can you elaborate how checking amount of digits is different to
> check_mul_overflow()?

consider U64_MAX = 18_446_744_073_709_551_615 as the limit:
- 19_000_000_000_000_000_000 contains the same amount of digits but overflows.
- 18_446_744_073_710_000_000 contains the same amount of digits but overflows.

to catch those cases, we need to check for the overflow, everytime we read a
character and accumulate:

u64 acc;

while(isdigit(*str))
	if (check_mul_overflow(acc, 10, &acc) ||
	    check_add_overflow(acc, *str - '0', &acc))
		return -EOVERFLOW;

*res = acc;

acc can get weird results if not checked. 

> 
> > Previous implementation of fixpoint parsing didn't care about that.
> 
> Do we have test cases for the current implementation?

No, I am adding a kunit test in this patch.

> > > > Understood, leading zeros can be ignored only when parsing the integer 
> > > > part. Also, would be nice to have truncation of the fractional part
> > > > while doing the parsing. How about:
> > > > 
> > > > static int iio_safe_strtoull(const char *str, const char **end,
> > > > 			     size_t max_chars, u64 *res)
> > > 
> > > > - max_chars = 0: ignores leading 0's and process all digits
> > > > - max_chars > 0: process only initial max_chars digits and ignores the rest
> > > 
> > > I'm not sure why we would need that. It should parse the whole line until the
> > > first invalid character or overflow.
> > 
> > "process all digits" and "ignores the rest" would be for digits only, so it
> > would stop until the first invalid character is found. I suppose proper
> > overflow check is implemented with check_mul_overflow() and check_add_overflow(),
> 
> I don't see the need. Amount of digits defines the order of the number (in
> power-of-ten).
> 
> > while iterating over the characters and accumulating the value.
> 
> The problem that you can refer to is the corner case when the first
> (most significant digit(s)) are already give an overflow while being
> inside the allowed length. But it also can be checked.
> 

Yes. Not sure how to do that without checking every digit again.

> 
> The benefit of simple_strto*() over kstrto*() that they do not require
> a temporary buffer and work over constant data (always).

Agreed.
 
> If you see a way how to refactor lib/kstrtox.c and lib/vsprintf.c to have
> an implementation there directly that may operate over constant buffers,
> I will be glad to help with it. That would be good for existing cases,
> such as Intel QAT driver, and any newcomers. I actually don't know why
> the heck kstrto*() were made against non-constant buffers. Perhaps to
> avoid this 'end' parameter...

That would be out of the scope of this patch.

Kind regards,

Rodrigo Alencar
