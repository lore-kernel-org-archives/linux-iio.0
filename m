Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B7B3DD861
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665271; cv=none; b=vCcEc/5NiiUdmECciuA67GB3W/MADee+cZ6YhNjRfMXucHgO/cuIPko3iiNPVxk74EJj9PaISzFjlDedIjgUphwk5zc6eU8eCIDSVt8w1daRaZ1/fyekV2GmTD++6MOFL4xCGrTa//frrXnlxEsIpowoi/1XYhtz03WXRO9cfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665271; c=relaxed/simple;
	bh=PAU2R/mmEAtckT1JPUyhTUH7nnNckQQzn5lSj4Tw6o8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGEaqF3CeDUQwRMxYqPWwtLoe9b3sZNX+70X4voGthqr6qQAd8cEcPv8w3MukIcWJbo6Qvmhgrnhj5FmjeS6knzg23/SwCuZWjKlnPcFVR0VhebNDVdvXMPcRcObICQlq29mM/7bZDoF+GimI5LVNeP4Fokcku078JcpFeAwAvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asahv3DL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asahv3DL"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-459bf19e87bso1814401f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778665268; x=1779270068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OxLUoJngBn+Ee9sp6PTsXdvWew0l0KazwAtq9GZfxlQ=;
        b=asahv3DLvkanN8Eldv+07C5jRWKy9/AsEDUgRNjAbuC/q3tqv8KtIaOFGyMB0VHDEQ
         L0kHKf4s/MCt7ztelNFAxsscH8gghhSsJqTFmVfXpSWA+1Uw64K3TLhjctT1EaFCS5M4
         yoxf7ccJbSYEflDN7o1JJBQs8CO3v8UmQfVK79zTx5nrmKcxXCZcqMp0fsvbCJaH9pRo
         I9OqYJDSQJSQAa8KQfvU9l9iltYVcKn1m6RDeVUYwPwTu1ZHERdb13G901YleB1E2oJh
         Tln2WRsshpxaqCMG4W0EdgtjbAZO3NaOQtpkLWlZk8946QauPbhvVwlU60p6HlmA+XXT
         H6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778665268; x=1779270068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxLUoJngBn+Ee9sp6PTsXdvWew0l0KazwAtq9GZfxlQ=;
        b=TGaUCWK0zFyXeYsNmeorftwUGK/r8587i5vsTZca1rMktsk4Swkd/QKVcVlxW57T6C
         RYpcWIQ8Tfpm5PahESV12z8AeENEmcAUjJyv3WUzEvTDQeXvhKw0gKA8LYaMnEptOsMC
         hcz6gPkJcmcUoMN6Vuo2gOmtF3+5rMG4N+ZTTs7Z3XRAIPRd9uA5VUFdOkPjP2rZYJvJ
         BnnAWF5NgxAM7ggzgd3KrzeHKN4C2efq6evEglJ3ctxZHtbkEA/6mGu1DxYXZFYhhV7Z
         gBSQUwosEZXyhwlspBT/Xm4Tg87eQDPeIa9LPiikam0Yu/4F74rarAIpmBnVS3G0M/VU
         VzGA==
X-Forwarded-Encrypted: i=1; AFNElJ+Z7LNhcSWTdCt4o2NQAo3ETpr/UZ3TDZMzl149vyAs2xby5rGh/IPKWpQ0GyDysMGJA6xEblS+Wnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu+dN78R9yHe+cuQSkzvWb+X+7oBNISTLLogNRU7vcqXg9CBZF
	sGGfg+UFWZcbq1HRiuwu4IhS3+UgvYo5Lswn9urMwW/HX+B8wN3QIXF8
X-Gm-Gg: Acq92OHrxeUds7R5LZt5dSHV6mR3UYa6cCCrzMj/3MqUfxr0ivBoxuir30b8wkdVY2O
	dh4yvY7NZOX4llScp67RRPGqbilf2X5lAHw8R3VLCbHh+DBEmIIxSTdTm9eAMN9ENlCc9/qyVC/
	ec4IOJLDWM/ywCGvERK72arbGIobNc1bYvfGVyYxECpAx3MYx0R/7C2T/rSiJ4wFU+oPJtL+pVs
	xppWHI7xV+7Vk01PoPpTSgOFp3I4Bb6oOU6iBA7hLzztB4CtStML3c9I7OQJzh76N0grc9F8X+F
	cu/922J6FVyuO1i+2ZbfYk3eeDEuKZjWfnEa8Q6GD30rWIPWSG99VI3JFJmZWOII3xaNE1X0/oO
	DzgovItjqOed5Mr7dMFf+fSWmU7foN+CxuJH1igH+jLsZTZ+wd5JKidLWvDQ3X4r7DTl1Kavgth
	N7kxiWlYYPkynHFySA/xYfECYWIqXKm7Uq6bgTd9btlSXlcBBw0qCd0I/13xPJHMwPQ6MxefEe6
	wL3vLNn1XO5npPtHACJDvG6r5/UtPvsfVGzFJB+gXXcON6YbA==
X-Received: by 2002:a05:6000:144c:b0:44b:cd2f:a3c8 with SMTP id ffacd0b85a97d-45c580ce3abmr3330603f8f.4.1778665268082;
        Wed, 13 May 2026 02:41:08 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491bae13csm37966733f8f.29.2026.05.13.02.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:41:07 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 13 May 2026 10:41:01 +0100
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v12 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <kwjoyikbygik4futknqpua2tlzokradms25n2dmfa5czyj2uts@4rdfl6zlul2q>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>

On 26/05/10 01:42PM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> precision). After the decimal point, digits beyond the specified scale
> are ignored.

Hi Andy,

I am starting over here, the other conversation is getting hard to follow.
This is my new proposal...

...

> +static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
> +{
> +	u64 _res = 0, _frac = 0;
> +	unsigned int rv;
> +
> +	if (scale > 19) /* log10(2^64) = 19.26 */
> +		return -EINVAL;
> +
> +	if (*s != '.') {
> +		rv = _parse_integer(s, 10, &_res);
> +		if (rv & KSTRTOX_OVERFLOW)
> +			return -ERANGE;
> +		if (rv == 0)
> +			return -EINVAL;
> +		s += rv;
> +	}
> +
> +	if (*s == '.' && scale) {
> +		s++; /* skip decimal point */
> +		rv = _parse_integer_limit(s, 10, &_frac, scale);
> +		if (rv & KSTRTOX_OVERFLOW)
> +			return -ERANGE;
> +		if (rv == 0)
> +			return -EINVAL;
> +		s += rv;
> +		if (rv < scale)
> +			_frac *= int_pow(10, scale - rv);
> +		while (isdigit(*s)) /* truncate */
> +			s++;
> +	}
> +
> +	if (*s == '\n')
> +		s++;
> +	if (*s)
> +		return -EINVAL;
> +
> +	if (check_mul_overflow(_res, int_pow(10, scale), &_res) ||
> +	    check_add_overflow(_res, _frac, &_res))
> +		return -ERANGE;
> +
> +	*res = _res;
> +	return 0;
> +}

This function now becomes:

	static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
	{
		u64 _res = 0;
		unsigned int rv_int, rv_frac;

		rv_int = _parse_integer(s, 10, &_res);
		if (rv_int & KSTRTOX_OVERFLOW)
			return -ERANGE;
		s += rv_int;

		if (*s == '.')
			s++; /* skip decimal point */

		rv_frac = _parse_integer_limit_init(s, 10, _res, &_res, scale);
		if (rv_frac & KSTRTOX_OVERFLOW)
			return -ERANGE;
		s += rv_frac;

		if (!rv_int && !rv_frac && !isdigit(*s))
			return -EINVAL; /* no digits at all */

		while (isdigit(*s)) /* truncate digits */
			s++;

		if (*s == '\n')
			s++;
		if (*s)
			return -EINVAL;

		if (_res && (scale > (19 + rv_frac) || /* log10(2^64) = 19.26 */
		    check_mul_overflow(_res, int_pow(10, scale - rv_frac), &_res)))
			return -ERANGE;

		*res = _res;
		return 0;
	}

The new thing here is _parse_integer_limit_init(), which is a local modified
helper that accepts an init value, so _parse_integer_limit() becomes:

	unsigned int _parse_integer_limit(const char *s, unsigned int base,
					  unsigned long long *p, size_t max_chars)
	{
		return _parse_integer_limit_init(s, base, 0, p, max_chars);
	}

with init = 0:

	static unsigned int _parse_integer_limit_init(const char *s, unsigned int base,
						      unsigned long long init,
						      unsigned long long *p,
						      size_t max_chars)
	{
		unsigned long long res;
		unsigned int rv;

		res = init;
		/* ...
		 * the rest is the same implementation as _parse_integer_limit()
		 * ...
		 */
		return rv;
	}

That allows to accumulate the final value into the same variable, which makes
things simpler and decreases the amount of overflow checks.

The scale can now be a bigger value, like 0.00000000000000000000000000000000423
can be parsed with scale = 35, resulting into 423.

The truncation loop is still there... I think this implementation is better,
and I am not sure what is the input limit that you would consider ok to allow
non-zero digits to be truncated once the scale can now be something bigger than 19.
As long as the output fits into a u64 variable, the parser still works.

I am also adding new test cases for that!

-- 
Kind regards,

Rodrigo Alencar
