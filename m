Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D53B0AFA
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414991; cv=none; b=FHRyPiKGEra/O7ki71sJOU/NKoDp8acJwk1jzltlpZ0z3UBqs/eW0F5VOP7+JNzusB+1wNmVeqRKaYJSgrKYPEAqiX2MaE28RrjOxa9JjlGsrg/lDDLZlE0v9vAwd9yi7/PQDYN54quY4MpBnu54TMU2dPcG708m/eo8jiavdzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414991; c=relaxed/simple;
	bh=+6x6QSjg9WDHOM6OfwMMX46Jbd5d/tcXlvODjbQmQhI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drJpQHVyX65RTqAU/FL+Tc0ivx3SzQKdjb+N9O9k8Ft2lVk+P8e3hxhaCDb1aLT+NHdT5/iFRoV7Zg04GKzv7Y60SEXB5Uw6si3iuWYkMOxdvNAf78ro42CsHYpTosYtXYvfrxex+AwKiwXkhLV8ovkiEPQzbiv0QimM9H9qdOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmPcXyVm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmPcXyVm"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d7650202fso383764f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776414987; x=1777019787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CS4QQsQN7RmaHyI35F2RiAWiiiGHkRaNuLXPNb9Rp1U=;
        b=CmPcXyVmMFW/Ru5XQk+qJiv+A+2qOWiw7Xoh/2hhpSLmc0TsrJBuFPc++U+w+ubDQw
         O2qpD1ve7P6vJQTJIjQw/mZ4qdiiLQxXM8FZ1c2egt2vwLjCNxrBThJeJVmHwMD1Ilid
         fO0kZ1G0B8d0iStwhLTuGe1Usq/9Lf1pa1k8CMEc9AZxUtGbR9nV54nqtkys3I5Lcsl7
         17s08aj0xJGfR9BGJ630rAWEiVF11oH6FIJRLFfjnsrYjSQyfCpPmmBvklDOIyJnbUwU
         N3eX6bP0kR5M92glv8SXxBAKLxBF1L7cWcTg4Ytt5yKbjqd/RKKzejpgHafDUgGcEZbo
         FzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776414987; x=1777019787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CS4QQsQN7RmaHyI35F2RiAWiiiGHkRaNuLXPNb9Rp1U=;
        b=brDSdQ8K1Jq/FhAYWWfDw8PxbUdgZQHGCWZdfHNBTvuaRHN1VUeRwl2Bl7iNX3W9vM
         iNsJct9Nv6M/67Wdv4rmNzn8t9LnQb3Y0ej2NY9IDeoB2q9xpgkOQoZLNCnhjfwC9q59
         rb7Gsrv+rKirc4GIchCj/UB3+JYNQ4NlE+0nNHAKkoUebdcvN8+rvCXHjMa1Min19WRE
         64f7q+9sbwVrau7Alts1aB/dXexi81JaRJkdem0nDilJ6QFUp1nMgtpl0UY1YSyJFdiP
         4aa4Yok7VQ3l6zNlFtkaiDM/M9mTSI8taPHONLmAWl4C46gqIMSBisqxdcOUJUnnFgvr
         S+Ww==
X-Forwarded-Encrypted: i=1; AFNElJ+xQqbAKrujmhazB24JMnZfnEhB2+VGi+N+Di2YpsjLjODdTMfD/+m5zEgNitBeXFA2DUc2hd82ePs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbxSjDJz7Z/jEpxDy+jjWmB8o01wFfv3x/n6WX9wdCwbYizIsM
	EJkkBaXhFogYuRTJyzKbjEfDsOMLqnrgB9pgNRxFtuHJ8OAcpUjR0ybI
X-Gm-Gg: AeBDieveLQbptd5PtzwzIs92hjgT8krpbP0XP2U/wT43zK99g7NLayNC3Fs6s8cwDwi
	nOAgV8mP3oOsUyGKdXz9pi/bf1O9YTaluIryRC1eWr4B/jKa7UUZaBUP5iZswqekwEOjZ1Pon6L
	WscHPLDv8mCm6ZIimBABHAXPRcxgIgjn1+ehM29B4dLkFAzn4EErSOrrM/gMZYBVnZlk7okz+Ki
	Qd9STubRyfaEQYXi1tJhPzOkQWbY2RaiQP6DEpqVJZWLwo9rWFBAYCyPs9tahE7xf17eDdv6BIV
	0KjHZjIj390JIPqeXoLgVfqr3sJlBcLY7pFOjhyMtmt4hTEc6s0gtePD+zMYcaHSlxQ7MWbQfMl
	QgFbV2J8DPdKQYojZughKyBiq+/HyvRl4VUwhgnH/lu6bPkJs2QZJ3MjEQsXw484pZiDIJwYPOF
	L4Dvk5p2a5UBaSZokx+/6Qn28SsokFopWdf4sWaShFYypl6HpYHiICOgtUzMt6lLFeUDvz7dqg/
	zFLlWibVnl3mA2ClEupzStmzWg4uAR/DaqrfumrdYXlsHP6QUWjgKAcG1VLff5+V7adAYQU
X-Received: by 2002:a05:6000:2308:b0:43d:76d8:5794 with SMTP id ffacd0b85a97d-43fe3e14f8dmr2894776f8f.36.1776414987239;
        Fri, 17 Apr 2026 01:36:27 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0d51sm2911996f8f.10.2026.04.17.01.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 01:36:26 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 17 Apr 2026 09:36:20 +0100
To: Rodrigo Alencar <rodrigo.alencar@analog.com>, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v10 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <mhfgedq2t5lqtu6535ahdmpbvib2xzp2hmyt7ezflnf52r56jh@ze6tee7vpij3>
References: <20260415-adf41513-iio-driver-v10-0-df61046d5457@analog.com>
 <20260415-adf41513-iio-driver-v10-2-df61046d5457@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415-adf41513-iio-driver-v10-2-df61046d5457@analog.com>

On 26/04/15 10:51AM, Rodrigo Alencar wrote:
> Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> precision). After the decimal point, digits beyond the specified scale
> are ignored.

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

I have an alternative (slightly more complex) implementation of this function
that handles E notation. I find this particularly handy when writting big
values like 25 GHz when the ABI is defined in Hz, so instead of writing
25000000000, one can just use 25e9, or 2.5e10. I found that my python code
was printing big floating point values or really small ones using E notation
and that was giving me -EINVAL, so I had to adjust formatting when generating
the string input to the file. No big deal, and we would not need this here,
but if maintainers find this useful I could add it into a v11 of this series.

-- 
Kind regards,

Rodrigo Alencar
