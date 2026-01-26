Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C552215530C
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431385; cv=none; b=KtRUAgOi6zLTRnf/ahZGU+/eQdfdCX5qY+8oQBwnVbPO56Ep3zKdIsFQQZQumnE/Z99/uO3D0aIih9jrvA3PUzJbcqhbsm/tAlDl56vUMOR+gM+6u4q1MlcYE0NdBfjfAuxAHOlVZ+eTiN87N53D6b3UZ4WxVOU7Lkea9E3fcKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431385; c=relaxed/simple;
	bh=U+c2Hgblo3r/wja8rf5QoZTJIQ0uzSyWaG4sMBQzq28=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+x9xACIAoqE8L6ltHdBIEWhVLUOHGy/57AEK3mndYMKXo860hlvXMgAuR+quGBrjWSrwI4vkn1y4J9eS1AIWOL++p1CBRieTYkEUWh5RH6WllflIdkCVwyioRBqreg6AbIN57uSRG6H+WZpAcvcNc3451jdEWGhnv1m5uG5OLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AP8iuHwO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP8iuHwO"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so33875015e9.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 04:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769431382; x=1770036182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=do5TPbTmIbVmH05fNafBjej7yzR4YEVxfJZjwcPS6ic=;
        b=AP8iuHwOm5hL3BJ2pcE91GiIJmenew/V7KvNp9Nyk7C3WuJ8F9t7CLBfAyaArQ8PMn
         ge0NgJpI+rb3c5qc2TrNpE5jXcvw9IZj+wwjxTDurznVy0nVdO1+nCwdZ167tFOVA2qI
         8bTjqG841eLzgq1tbzTF4vNXA+6V4lgCKdj+vbIs+G4RYOL4ngNLb95L5aFKYgYq62Oh
         TYpPXFNbMuEeVPynfLhgWnPbRMfufTo0pkp0C5z0KXRNBpu4WiT6vTBqJ/aBUhbeYGtm
         jRGJj0F3BKEOYGsHPu11Jnl1DCp0f+uQAaS3Dg3rhORfrBsz3Wwr/CNMJwF5GSq5JxDL
         7uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769431382; x=1770036182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=do5TPbTmIbVmH05fNafBjej7yzR4YEVxfJZjwcPS6ic=;
        b=gYp4/16oKpqmxjh8T3wHthrmFYxj8mk0uKIG4xwTWJdYRC43ocv9KSMnjNKyCf1LdR
         MSA4CsyWS24+G36OEVQmLhccAuED09JwHSSFeUrU7kHeusp8+NEF+y52rYTwrZ9qR1/p
         2WjoWYyNdg0Ftvdjh7ycuAmKabLnI+tbOtRa1KoNQ8Anlrq7Oa0YjkwWil6MOcGtq18/
         GrLzCYYb6k7YtvE9hIYfbDEACGzyFk+9lHin0+A911X5umF85+hVi1VZk8O/BLk8XJrh
         4lJqoxkGPri727GvagFlSUiYmCEhTHDsz+GsvCZdOmRG1uDeSv8q/fvy9FXo72b6YePU
         iYxA==
X-Forwarded-Encrypted: i=1; AJvYcCXTNgrMvXvL864GZgDnOcBwlwjzBFgNNHtd6ttMpePAiRbKsh70N8nP4E5MvoqQ8gFSXMAIO55Yl7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR170YIPcwMoavs9jyUUEySyxlBdRycBTQvJmb5VJZJIyHoM8y
	mJtuI7P+vl0FJOQSYUizbeVyNImKEYkEnOftIt64ZWgb3CTUzOOFRwL5Qt4iDg==
X-Gm-Gg: AZuq6aK3W/Mz4O7vs7cWpYUu2WgRWBN3v/He/KRotPiZxwSGbtYbQBLWBN3TqewygPn
	evAxeEY8UzoPxj+cDswzoomQNiTDFTpDmh83sKYnp3r17O9vH0vyMiEY7TkUxDI/A43jOEonPrl
	cDAlQ9whoQqSgYs9nmhcuL97fSUQcx+/qVaE43s66A+zComoLDd7+yEnpYEUewW1jo+bKgpTVQ1
	ly4NiNggMgTJ99daeTrEfBujQn5MU/3UAd0ODuadsujEgTe2OUMPRR/cOeZ0Xo+Fr9M/Ytbn8bs
	IQGRjbhReS17Qb770Q6v6kRhp5ggdn/fqXd5yHvScG+7jJGX/RCrrx/5q3nQm+PVIPkOdhIcR7e
	AgjvXS9hvbf7tN+k10f4XgL36JHkTYp8feH8BsbSShzm537Gn4TSXrtaC5ieRa9R8VV0pbc+1ie
	mDeneWiWlj9b1IZy5XbjTr97VvjSHmxHpk+S8V3tHSgP3mmQW+uaP22fCJveRKPc61V0l+UHOc4
	4nT
X-Received: by 2002:a05:600c:681b:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-4805ce4bec4mr79129435e9.10.1769431381877;
        Mon, 26 Jan 2026 04:43:01 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d3fda30sm108016795e9.1.2026.01.26.04.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 04:43:01 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 26 Jan 2026 12:42:53 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <byitgzjli5gsq5v66topve7ip3inkk2udwhuihjdp6bknnkmos@tv226l7tek7s>
References: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
 <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>
 <aXdUvRZ9NmP5Nh95@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXdUvRZ9NmP5Nh95@smile.fi.intel.com>

On 26/01/26 01:49PM, Andy Shevchenko wrote:
> On Fri, Jan 23, 2026 at 03:53:07PM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> > Add iio_str_to_fixpoint64() function that leverages simple_strtoull()
> > to parse numbers from a string.
> > A helper function __iio_str_to_fixpoint64() replaces
> > __iio_str_to_fixpoint() implementation, extending its usage for
> > 64-bit fixed-point parsing.

...

> > +static int __iio_str_to_fixpoint64(const char *str, u64 fract_mult,
> > +				   s64 *integer, s64 *fract, bool scale_db)
> > +{
> > +	u64 i = 0, f = 0;
> > +	char *end;
> > +	int digit_count, precision = ffs(fract_mult);
> > +	bool negative = false;
> > +
> > +	if (str[0] == '-') {
> > +		negative = true;
> > +		str++;
> > +	} else if (str[0] == '+') {
> > +		str++;
> > +	}
> > +
> > +	i = simple_strtoull(str, &end, 10);
> > +	digit_count = end - str;
> > +	if (digit_count > 20)
> > +		return -EINVAL;
> 
> Not really. If we are talking about decimal (only) cases we need to also count
> leading 0:s.
> 
> 0000000000000000000000000000000025 is still 25, no overflow.
> 
> That's why I recommend to have a helper, maybe for now locally here, like
> 
> int safe_strtoull(..., unsigned long long *res)
> {
> 	...
> }

Are you suggesting to not use simple_strtoull then?
Understood, leading zeros can be ignored only when parsing the integer 
part. Also, would be nice to have truncation of the fractional part
while doing the parsing. How about:

static int iio_safe_strtoull(const char *str, const char **end,
			     size_t max_chars, u64 *res)

- max_chars = 0: ignores leading 0's and process all digits
- max_chars > 0: process only initial max_chars digits and ignores the rest

on overflow of u64, the function would return -EOVERFLOW

> that will do all necessary checks and returns -EINVAL, -ERANGE, et cetera.
> In the below we would need check for the error codes respectively.
> 
> > +	if (precision && *end == '.') {
> > +		str = end + 1;
> > +		f = simple_strtoull(str, &end, 10);
> > +		digit_count = end - str;
> > +		if (!digit_count || digit_count > 20)
> > +			return -EINVAL;
> > +
> > +		if (digit_count > precision) {
> > +			digit_count -= precision;
> > +			f = div64_u64(f, int_pow(10, digit_count));
> > +		} else {
> > +			digit_count = precision - digit_count;
> > +			f *= int_pow(10, digit_count);
> > +		}
> > +	} else if (!digit_count) {
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (scale_db) {
> 
> > +		/* Ignore the dB suffix */
> > +		if (!strncmp(end, " dB", sizeof(" dB") - 1))
> > +			end += sizeof(" dB") - 1;
> > +		else if (!strncmp(end, "dB", sizeof("dB") - 1))
> > +			end += sizeof("dB") - 1;
> 
> Now we have strends()

strends() would not account for the acceptable '\n' before the end.
I don't think we would need to test for " dB", " dB\n", "dB" and "dB\n"

...

> > +	if (integer64 < INT_MIN || integer64 > INT_MAX ||
> > +	    fract64 < INT_MIN || fract64 > INT_MAX)
> > +		return -ERANGE;
> 
> This needs to account the sign, right?
> It's fine to be UINT_MAX I believe. But I haven't checked the current
> implementation.

Yes, UINT_MAX should be valid, will add test case and adjust. Thanks.

Kind regards,

Rodrigo Alencar
