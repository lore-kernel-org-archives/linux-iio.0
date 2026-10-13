Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB9E5349D4;
	Tue, 13 Oct 2026 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917311; cv=none; b=apBxp8wraPOEWc+0iwfNdsHFzEkgOQxfibmmIYe5j7JV6MWg/2zDBJ/CvrksceA4Pst3Z3D/YAZ4+7owbeZfDh650FHGPLs1RdirDP2HYTq4MRQS/k7i/yLWSorEQDSqAdeOnlk0+raKk3Qt2n7JjaGADkw3lA/IMkU+uk1bUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917311; c=relaxed/simple;
	bh=ZmCYv8j+nLMv2u6MnmV5qPnPBb9Ww1XUC5uuSLp2I/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlsXpThYZEqOqn2FtgBUylCPpwvV7+uVNqULHNOWJUkr7z/fnG9Bfc9UhafUrZ/rnYhFqb8Yg4NUlYkkLJjkX2S13pzSK+KXXhL+UHZXVnkwLIPt19kMRHtLisqQWaarnKFNghLmF0cjpqTTtNJ4F7FdWXxdMlkzT9zb9U2peHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkxETIS5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkxETIS5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791917310; x=1823453310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZmCYv8j+nLMv2u6MnmV5qPnPBb9Ww1XUC5uuSLp2I/o=;
  b=KkxETIS56rwQTRLuHK8NQVCGBgiCnVGPlGAeuA3u3AiEQd3PVs/ZZcvD
   2XztRJHkeulRu1BPBBddJzv9xK3QrPxA0fEIeEk0APgfvd9TPTsFJe9s+
   YXWpKYLe8Rt8egu45Ia4FLzrBytuIgU3qWE21A5r/kxSpLb05hyjtTiSe
   ShHSAvVmrk3z1il9b39tBGylgTvsJ4CPRxAQxxi+lG9Uro5tjo6JQDTL+
   ZRD5Hh11jMyXI7EhO4x7e11n+NA/A5yHLg1lIZTXj3dJ1nP70tZWRsHfO
   VKc+YlaTGilQGc9Kze83m9l0un/TZxcmnLGoCvGU8WQQhlVCLRJlmX3Am
   Q==;
X-CSE-ConnectionGUID: jtr8gEVATOq4nYWlWrzh0w==
X-CSE-MsgGUID: PYvuVQuUSuGBn8OViA6++Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="757548"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="757548"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:48:30 -0700
X-CSE-ConnectionGUID: HPjUTOB6Qpapf9mT77Rx/A==
X-CSE-MsgGUID: v6XEGaXoSCCkFOgV0frGhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1337293"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:48:27 -0700
Date: Tue, 13 Oct 2026 21:48:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC v2 1/4] lib: kstrtox: support E notation in
 kstrtoudec64() and kstrtodec64()
Message-ID: <as58-c9H0SL_Qkl6@ashevche-desk.local>
References: <20261013-e-notation-v2-0-d4adb5e193fc@analog.com>
 <20261013-e-notation-v2-1-d4adb5e193fc@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-e-notation-v2-1-d4adb5e193fc@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 10:36:44AM -0300, Rodrigo Alencar via B4 Relay wrote:

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

static int skip_digits(const char **s)
{
	const char *start = *s;

	while (isdigit(**s))
		(*s)++;

	return *s - start;
}


>  static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
>  {
> -	unsigned int rv_int, rv_frac;
> +	const char *s_int, *s_frac;
> +	int exp = 0, len_int = 0;

	int len_int, len_frac;
	int exp = 0;

> +	unsigned int rv;
>  	u64 _res = 0;
> +	int ret;
>  
> -	rv_int = _parse_integer(s, 10, &_res);
> -	if (rv_int & KSTRTOX_OVERFLOW)
> -		return -ERANGE;
> -	s += rv_int;

> +	s_int = s;

> +	while (isdigit(*s)) {
> +		s++;
> +		len_int++;
> +	}

	len_int = skip_digits(&s);

>  	if (*s == '.')
>  		s++; /* skip decimal point */
>  
> -	rv_frac = _parse_integer(s, 10, &_res, scale, _res);
> -	if (rv_frac & KSTRTOX_OVERFLOW)
> +	s_frac = s;
> +	while (isdigit(*s))
> +		s++;

	len_frac = skip_digits(&s);

> +	if (!len_int && s_frac == s)

	if (!len_int && !len_frac)

> +		return -EINVAL;
> +
> +	if (*s == 'e' || *s == 'E') { /* E Notation */
> +		s++;
> +		ret = kstrtoint(s, 10, &exp);
> +		if (ret)
> +			return ret;
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
>  
>  	*res = _res;

-- 
With Best Regards,
Andy Shevchenko


