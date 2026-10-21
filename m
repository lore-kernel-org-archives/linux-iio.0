Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572350;
	b=raeDD3aiU8nkHArv0FtBzsScEztzx5U15FK6G2ReJgJc1KT+490Bkt0gUPUVTPi2Qa4E
	 Km8AjJrH/PyK9a/ww7WaDacEq7ALYzscfGQrahS9lA3Dzk3AasqyKX1rO71XOOvHUTfMY
	 cB/cRz0xjIDWX8GvKUu+9eO+GjrLuaj2zpWPt6IS4FidYcURF5SgtHk8vaOowo1ABCTZQ
	 1gb+wGtzZ87ArEr83h+TjJLBcDOCUjvWvjiKtXZ7xrlFdLjllwjI3klPjBvFIbpsLiuW9
	 OlnTYwIxXMffNezO2kh6QQjDPigV3KvWBoLBIt5tUJCWBbwe0PqQ02tkYDkjsO0XpoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572350;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=AARjICxL8VrFHoz+suOARviUU9Ne1BklF6CHzUpRPSw=;
	b=vU3j876TXwPSCG9xjJu+uTv5xIkCSMEQOvjFbPByU8hBKj7/cvfO0CXd+JTAhg1wCew2
	 TpC9VlJY5H/U5LQB3XJgR23sKAsc2PbOhch61FUbiZev52GwIkf+2wIJG8ZcbHHEB3M44
	 +IVgIhB8tOGCbqxazWip6IRX7UDLD+2sMiYM48NH4aeJxFl1Vc2jekBsr6vr8eHu0d8fj
	 7c92/Jmyv9XX+zu3SsvRv4hDOjeWI6Q1Zw5QMeDSqgxdLXQOXDhjoEIzi7Ijr5+hu3rr0
	 /Ipc1bsAvw3bccymQyy/fec2XK2v9ypxem1zVfd/b70zqlhQKXRPDaoCaFkBwHk1KJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ai4x5ZgP;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B75B606A31A;
	Wed, 21 Oct 2026 08:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B75B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ai4x5ZgP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792572348; x=1824108348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ib4hqcr4bgirXLtFsNzST2o2zl/q2tlReuJvgkT8iUw=;
  b=Ai4x5ZgP+FZYvTOvk5dSvI71hNsOkeC+MBW/CL03U8RfmnbfzRwTqhWM
   Qs+aNL+beL1KFY8HzHbyh+0p089b6IIH6Y0ln0dm+jseF/OZbXX2s4sFj
   Wwpkw8g9azebWSyT3MZyfEQglJdKvwj7g+2JdmYnxGiedFOOQuSf7jtiy
   1lBNc+DuwLQs+GPmC7x7bCzdqRo5U7Yw7Dp3rIKVBOgpiJiFTcwGSzkwF
   8Ujcig/LCiJ6uE3SPwsywCtra2+sMhItX4NeXVcein7qjqjiqHE4/lOsS
   JW7Gy1OpNIWUB0jnXQAFWq7OQQYK/vdyf9xMQaEYv0n7b8BXRpmrIpgD0
   w==;
X-CSE-ConnectionGUID: nNljsuM7TjiraHpe8FnFbQ==
X-CSE-MsgGUID: uVRbJqW2TgSCwhBRWXjPJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1392828"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1392828"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 01:45:48 -0700
X-CSE-ConnectionGUID: BxrYpE7uRwaEbVezZlY71g==
X-CSE-MsgGUID: 3/KOeasURcusPk6sMQ98Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2976706"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 01:45:45 -0700
Date: Wed, 21 Oct 2026 11:45:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC v3 1/5] lib: kstrtox: support E notation in
 kstrtoudec64() and kstrtodec64()
Message-ID: <ath7t0hj12kXGgxs@ashevche-desk.local>
References: <20261020-e-notation-v3-0-fd385c0fbf65@analog.com>
 <20261020-e-notation-v3-1-fd385c0fbf65@analog.com>
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
In-Reply-To: <20261020-e-notation-v3-1-fd385c0fbf65@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 09:26:59AM -0300, Rodrigo Alencar via B4 Relay wrote:
> 
> Allow decimal strings to carry an exponent suffix, such as "2.7e10" or
> "271828e-5", in kstrtoudec64() and kstrtodec64(). The exponent is added
> to the requested scale to work out how many integer and fractional digits
> are consumed. A negative effective exponent drops integer digits. Digits
> beyond the resulting precision are truncated, as before.
> 
> The digits are now scanned first and the string termination is checked
> before any conversion. A missing or malformed exponent ("1e", "1e+")
> returns -EINVAL. An exponent that overflows when added to the scale, or
> that makes the result exceed 64 bits, returns -ERANGE.

...

> +static int _skip_digits(const char **s)

Leading underscore is unneeded here.

...

>  static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
>  {
> -	unsigned int rv_int, rv_frac;
> +	const char *s_int, *s_frac;
> +	int len_int, len_frac;
> +	unsigned int rv;
>  	u64 _res = 0;
> +	int exp = 0;
> +	int ret;
>  
> -	rv_int = _parse_integer(s, 10, &_res);
> -	if (rv_int & KSTRTOX_OVERFLOW)
> -		return -ERANGE;
> -	s += rv_int;
> +	s_int = s;
> +	len_int = _skip_digits(&s);
>  
>  	if (*s == '.')
>  		s++; /* skip decimal point */

So, I know that '.NNN' is valid notation, but is 'NNN.'?

> -	rv_frac = _parse_integer(s, 10, &_res, scale, _res);
> -	if (rv_frac & KSTRTOX_OVERFLOW)
> +	s_frac = s;
> +	len_frac = _skip_digits(&s);
> +
> +	if (!len_int && !len_frac)
> +		return -EINVAL;
> +
> +	if (*s == 'e' || *s == 'E') { /* E Notation */

You may use _tolower() helper (yes, the one with a single leading underscore).

> +		s++;
> +		ret = kstrtoint(s, 10, &exp);
> +		if (ret)
> +			return ret;

So, with the above in mind, this may lead to 'NNN.e10' input which I find a bit
confusing.

> +	} else { /* verify termination */
> +		if (*s == '\n')
> +			s++;
> +		if (*s)
> +			return -EINVAL;
> +	}
> +
> +	if (check_add_overflow(exp, (int)scale, &exp))
>  		return -ERANGE;
> -	s += rv_frac;
>  
> -	/*
> -	 * Check input beyond rv_int and rv_frac to cover cases like ".5" with
> -	 * scale 0, which is considered a valid input, being parsed as 0.
> -	 */
> -	if (!rv_int && !rv_frac && !isdigit(*s))
> -		return -EINVAL;
> +	if (exp < 0) {
> +		len_int = max(len_int + exp, 0);
> +		exp = 0;
> +	}
>  
> -	while (isdigit(*s)) /* truncate digits */
> -		s++;
> +	rv = _parse_integer(s_int, 10, &_res, len_int);
> +	if (rv & KSTRTOX_OVERFLOW)
> +		return -ERANGE;
>  
> -	if (*s == '\n')
> -		s++;
> -	if (*s)
> -		return -EINVAL;
> +	rv = _parse_integer(s_frac, 10, &_res, exp, _res);
> +	if (rv & KSTRTOX_OVERFLOW)
> +		return -ERANGE;
>  
> -	if (_res && ((scale - rv_frac) > 19 /* log10(2^64) = 19.26 */ ||
> -		     check_mul_overflow(_res, int_pow(10, scale - rv_frac), &_res)))
> +	exp -= rv;
> +	if (_res && (exp > 19 /* log10(2^64) = 19.26 */ ||
> +		     check_mul_overflow(_res, int_pow(10, exp), &_res)))
>  		return -ERANGE;

-- 
With Best Regards,
Andy Shevchenko


