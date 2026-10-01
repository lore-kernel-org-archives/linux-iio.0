Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44007364E96;
	Thu,  1 Oct 2026 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790882958; cv=none; b=EnuSKFZIge6e+GVjbPnNUdFmFb+O3tedFYUACXrMZfuChDXym68BwOAQJmc7V0HljejACte2BGe/wFvlafwuQDd4KZ46TKK/FSqwq42Qnp6rbdC2Cnu5LjQVVH0bNmBOW2+85bgtPYC8Q2riI+p6hosMTQv42O3Zv8x9uVwHdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790882958; c=relaxed/simple;
	bh=OMtNdUkPoAP8kd989gtFmsnffCAA1xtaNZg/DQMqjqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBn7Zjoh4pq96OCSKJSinRXn3uLjMMdWV8LLHIod0I/CVqVv/7J5mu9T2NwWalyR/QNhe31Q8uag0lg1iL/acCDiLrrlJYrbmt68tK1+YUNMLpwCkzBYWn0lQM0OGHiPKhIiBkW7BLyGmze1qYFc991lqeQ8XnzB5zcFYaDMFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYzkbHhz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYzkbHhz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790882957; x=1822418957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OMtNdUkPoAP8kd989gtFmsnffCAA1xtaNZg/DQMqjqc=;
  b=eYzkbHhzwoia3oeEcp0XYEH1UVXlwMVACXOD/tOrbi94+XzS5fxC4wr6
   RCDd3usZi6dtUey2a/9tLL8xnKdmr55Ef4ZtebUlVLBm4IRPSc95dCo3R
   nqZaOPGA+tVI/EawU2788afEpPkYNexSK4y/GCJIXUQ8OBYygwHwBV9PF
   QdsIJEreItwAkW6nfg8fhU1qNEayOYPtww8Bvlh6bRWffzBOyyM4xaGBU
   sBS+4nlWoy39+6P13mKboEF+XkKpOfkmcH+ph8k0iZ9Ucl53p060wik7q
   2k9nsn7GDMrMBzYPSm1oZkGm1IjdxiSw+KG1OdpvOb+/Y3NrfURR4F9/L
   A==;
X-CSE-ConnectionGUID: q4KOq0I2Qdq/Ii9r9wWHFA==
X-CSE-MsgGUID: GhVyR9XXRReD2w/iZBZJ3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="100986779"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="100986779"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 12:29:16 -0700
X-CSE-ConnectionGUID: EFZBs3KCQOu/zUxnOMdfmg==
X-CSE-MsgGUID: DV5BFFn4TWWtVdnYsSAlUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="274701182"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.27])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 12:29:13 -0700
Date: Thu, 1 Oct 2026 22:29:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 3/3] iio: core: use kstrtodec64() to parse
 fixed-point values
Message-ID: <ar60h2px1C8hM4-O@ashevche-desk.local>
References: <20261001-e-notation-v1-0-75187bf06c10@analog.com>
 <20261001-e-notation-v1-3-75187bf06c10@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-e-notation-v1-3-75187bf06c10@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 12:34:58PM -0300, Rodrigo Alencar via B4 Relay wrote:

> Replace the open-coded __iio_str_to_fixpoint() parser with
> kstrtodec64(), so sysfs writes of fixed-point values also accept E
> notation. The scale passed to kstrtodec64() comes from fract_mult, which
> is a power of ten, 10^n, so ffs(10^n) = n + 1. The fractional part only
> keeps the sign when the integer part is zero, as before.
> 
> The dB suffix for scale attributes is now handled by a separate
> iio_str_to_fixpoint_units() helper. It strips an optional trailing
> newline and the "dB" or " dB" suffix before parsing.
> 
> When there is no fractional part (fract_mult == 0, or dec_scale == 0 for
> 64-bit values), try base-autodetecting kstrtoll() first so hexadecimal
> and octal input keeps its meaning ("010" is still 8). Fall back to
> kstrtodec64() on -EINVAL to accept E notation.
> 
> As a side effect, inputs that used to be rejected for integer-only
> attributes are now accepted. An invalid octal number such as "08" is
> parsed as decimal 8, and a fractional value such as "1.5" is truncated
> to 1, matching how kstrtodec64() drops digits beyond the requested
> scale.

...

> +	/* fract_mult = 10^n, so ffs(10^n) = ffs(2^n * 5^n) = n + 1 */
> +	unsigned int scale = ffs(fract_mult);
> +	s64 dec64;
> +	int ret;
> +
> +	ret = -EINVAL;
> +	if (!fract_mult) /* keep hex/octal support for integers */
> +		ret = kstrtoll(str, 0, &dec64);
> +	if (ret == -EINVAL)
> +		ret = kstrtodec64(str, scale, &dec64);
> +	if (ret)
> +		return ret;

Wouldn't be better to write as

	if (fract_mult) {
		ret = kstrtodec64(str, scale, &dec64);
	} else {
		/* keep hex/octal support for integers */
		ret = kstrtoll(str, 0, &dec64);
		if (ret == -EINVAL)
			ret = kstrtodec64(str, scale, &dec64);
	}
	if (ret)
		return ret;

> +	if (fract_mult > 0)
> +		dec64 = div_s64_rem(dec64, fract_mult * 10, fract);
> +	else
> +		*fract = 0;
> +
> +	if (dec64 > INT_MAX || dec64 < INT_MIN)
> +		return -ERANGE;
> +
> +	*integer = (int)dec64;
> +	/* only carry the sign in the fractional part if the integer is zero */
> +	if (*integer)
> +		*fract = abs(*fract);
> +

...

> +static int iio_str_to_fixpoint_units(const char *str, const char *units,
> +				     int fract_mult, int *integer, int *fract)
> +{
> +	size_t units_len = strlen(units);
> +	size_t num_len = strlen(str);
> +	const char *dec_str = str;
> +	char buf[64];
> +
> +	if (num_len && str[num_len - 1] == '\n')
> +		num_len--;
> +
> +	if (num_len > units_len &&
> +	    !strncmp(str + num_len - units_len, units, units_len)) {
> +		num_len -= units_len;
> +		if (str[num_len - 1] == ' ')
> +			num_len--;
> +		if (num_len >= sizeof(buf))
> +			return -EINVAL;
> +		memcpy(buf, str, num_len);
> +		buf[num_len] = '\0';
> +		dec_str = buf;
> +	}
> +
> +	return iio_str_to_fixpoint(dec_str, fract_mult, integer, fract);
> +}

This won't support cases when we have too many leading 0:s.
All these functions should also strip leading and unneeded 0:s.

-- 
With Best Regards,
Andy Shevchenko


