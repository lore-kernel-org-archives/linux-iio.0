Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C91B4138;
	Tue,  2 Jun 2026 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434021; cv=none; b=s0bkjcP0ZT8UJ5uDwF6Q4vXWtBzkXNQhrKTHAfmxrgXX89Asa/OidMDsOVjylKsRjUSMLRPfgfNeFTEKtiJ7uAFklNJzHGduB0so4XQR6hfsSYMb461TDOnQjUO1aMqSyrl20+FfvBOxeJIv9WMFFtOBrF65gvEI3S2gTZn59ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434021; c=relaxed/simple;
	bh=DjWzZbt2IRB8RfbyspIxQTHfC/bhFQZ3cqPYf193Jc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVzoH7vwPZB2DeIjFf/Be7/YIzzRHIPz7mEhSrFoVB9SYdP5PHoHKdNqrIgzyE72rwhL4/QfkD6Up2bCVNABvQculxEADrUts2aVM7uYe06KLyJrybXmb5qZmfK2i9nXK/L/+UqwyVQKiP4YPaPuIrQ/iE36ld4iqdE3/wRa+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFy3e/He; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFy3e/He"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780434020; x=1811970020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DjWzZbt2IRB8RfbyspIxQTHfC/bhFQZ3cqPYf193Jc0=;
  b=LFy3e/Heb8/1VU+00Ba7BzTQHS+0UaiQZI0QV8Y6khDWaeMAFYxTaaQT
   XhNe0/LyNHtbm5ucVM5cfyq+MsDFFJBEvx2m0QDTRrZocpKVi7h61rumP
   m6tMB+sFWrkIQ/qabtgbNprq5Lh/Ncb+lr5d77D58tWTZyuql9D70FUc6
   0IR6KTk9Y035OW2bWpxESaP1TAZNDyNgUfC/cHnea2O32hIpv69qSY8cV
   UDDLUkGcNdUSy2kI5rN7QcGlKHoFcVBBAHrsaUikvQ3vKzua3wCZZYYNc
   psdNLa0sg4+N3/vDCQLyJZUKIVyaaaNRih8wO4D901y/qNwyj+x4KVnZC
   w==;
X-CSE-ConnectionGUID: jxQHk5p9SEKi/dJDyLR2eA==
X-CSE-MsgGUID: LqX0evIkT5CAy3o5U2KUCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80373765"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="80373765"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 14:00:19 -0700
X-CSE-ConnectionGUID: /xxe5FilRvqaG+sb9fp5oA==
X-CSE-MsgGUID: vJQgfoRETruV1exjT7MU5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="267885994"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 14:00:15 -0700
Date: Wed, 3 Jun 2026 00:00:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v15 03/12] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <ah9EXNnutqk1FoV2@ashevche-desk.local>
References: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
 <20260531-adf41513-iio-driver-v15-3-da09adf1c0dd@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531-adf41513-iio-driver-v15-3-da09adf1c0dd@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 31, 2026 at 09:30:46AM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> Add helpers that parses decimal numbers into 64-bit number, i.e., decimal
> point numbers with pre-defined scale are parsed into a 64-bit value (fixed
> precision). After the decimal point, digits beyond the specified scale
> are ignored.

...

> +static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
> +{
> +	u64 _res = 0;
> +	unsigned int rv_int, rv_frac;
> +
> +	rv_int = _parse_integer(s, 10, &_res);
> +	if (rv_int & KSTRTOX_OVERFLOW)
> +		return -ERANGE;
> +	s += rv_int;
> +
> +	if (*s == '.')
> +		s++; /* skip decimal point */
> +
> +	rv_frac = _parse_integer_limit_init(s, 10, _res, &_res, scale);
> +	if (rv_frac & KSTRTOX_OVERFLOW)
> +		return -ERANGE;
> +	s += rv_frac;

> +	if (!rv_int && !rv_frac && !isdigit(*s))

Do we care about isdigit() here? Why?

> +		return -EINVAL; /* no digits at all */

> +	while (isdigit(*s)) /* truncate digits */
> +		s++;

> +	if (*s == '\n')
> +		s++;
> +	if (*s)
> +		return -EINVAL;
> +
> +	if (_res && (scale > (19 + rv_frac) || /* log10(2^64) = 19.26 */

It's better to make comment closer to the operand

	if (_res && (scale > (19 + rv_frac) /* log10(2^64) = 19.26 */ ||

> +	    check_mul_overflow(_res, int_pow(10, scale - rv_frac), &_res)))

Can we deduplicate the scale - rv_frac?
I mean, would it be possible to do

	if (_res && ((scale - rv_frac) > 19 /* log10(2^64) = 19.26 */ ||

without possible wraparound?

> +		return -ERANGE;
> +
> +	*res = _res;
> +	return 0;
> +}

...

> +/**
> + * kstrtoudec64() - Convert a string to an unsigned 64-bit value that represents
> + *		    a scaled decimal number.
> + * @s: The start of the string. The string must be null-terminated, and may also
> + *  include a single newline before its terminating null. The first character
> + *  may also be a plus sign, but not a minus sign. Digits beyond the specified
> + *  scale are ignored.
> + * @scale: The number of digits to the right of the decimal point. For example,
> + *  a scale of 2 would mean the number is represented with two decimal places,
> + *  so "123.45" would be represented as 12345.
> + * @res: Where to write the result of the conversion on success.

I believe it's better to leave short descriptions short and describe the
examples and other considerations here, in the description section.

All the same for the second one below.

> + * Return: 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> + */

-- 
With Best Regards,
Andy Shevchenko


