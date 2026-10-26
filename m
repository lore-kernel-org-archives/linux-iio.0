Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026471;
	b=tUx0m5GBNls+ZEEIPuh+7UKHLYjfPFDVkHG91ASyToYLSiSafrZtFV0prXB1nKdR96X5
	 wimaFlo5pN44QBP4/JKLObFtsgx31/yHxCQ1lGzB+Fxn6rgVw6+S5XS1NqrJvsSX5iBCo
	 RVH05gCxjh+WPexRhT94GPp3avReG1JDREr8tbm3Z1TN6sMEwOyiBA2HNbD1JKOFhUz0F
	 zjI5HYFBnj+e6ouXlKzZXl4hWDSYqVs+l7h9WVavTQb5H4QJttgKqA6MS+lYcnmLxAP78
	 HSAemPTMhG4M3oLpjB4nGKZjSUvlPZnmctaAZ+4ef4SbX5dYRPIGy8WS7bFQLeMlaeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026471;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=PPjLH4cKPpt60wqQSwVZpuEbLz9RRFMxTKYQZNlTZ/Y=;
	b=DsAMgPats5qNpGBoO42TEfKrB9wIPKamdQVNS5IcJiJnulC613D2pu/Ovi4DHfVmZBdR
	 UNHbqBn6XznFPJAZFWIZJKXRuuTp+wSsLWQ+3u1eKMiU3muL5T8oaB69egEd6VSNo/5F7
	 4CiYw5vUvoLL/hhhMo/obvAX9E+0QPmBdMTOd0p9rsQBJilfO6KNw8VG1Zj4kWNHc6Etu
	 hQJ2LnhlsxnAK5JURW/e+I+fl3mYKUtPRnfpago774kYKFvR7DpGsCrtyQY3kd5Y02Syf
	 5uY8A650/BYRumQakAOgRmcuBEr1zNlHB9+DqjyspOcegUF4OmOs18wlFdKfw+oOSlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qo0MNQoG;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6024D606A326;
	Mon, 26 Oct 2026 14:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6024D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qo0MNQoG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793026471; x=1824562471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gwraoF7GukRvcx8UZz9jxSEElzPELFxj9SAkV2Hm/28=;
  b=Qo0MNQoGF01TqZ1EJ0asJlM8GTENFfN+ajksAI93ZHPp/If2orIwnuYR
   2xj4Dcww5+FpJuTHyswpeToYcW1X1GYzULEV+wc4l1dOyzHl9gKWFIcr1
   G8XjoYmCmiYOTyZdcuZdIR5sjMxajerYmUkxwpWYkuoVzXBQs1z3QfzJr
   Y827csjFt0OHugNxeWARHYR44otlCqXHsti9aXJmNAJI3z9pAcdnds0CK
   07SLBHv37aoQzOZRfcFBlutSEuUVd7732VOzh52K6IzAZvWKcRBTCogP8
   bxA8EMt1YzjduMPOhhrUGk12CJGrQSD6UcJnqFCss5KvmlQIcvtmUQPKF
   A==;
X-CSE-ConnectionGUID: s/tKDUiNQXmOQWukQpUd0g==
X-CSE-MsgGUID: oX+d3zTTTHK12etpfus8gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1730701"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1730701"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 07:54:18 -0700
X-CSE-ConnectionGUID: xCZGvGX5RiakcqJnLIPDhQ==
X-CSE-MsgGUID: 6CA1Hb0EQku1j7B3GHbNcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4266229"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 07:54:16 -0700
Date: Mon, 26 Oct 2026 16:54:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v4 5/6] iio: core: use kstrtodec64() to parse fixed-point
 values
Message-ID: <at9plejNuVxO2V-A@ashevche-desk.local>
References: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
 <20261026-e-notation-v4-5-a366a6d14d57@analog.com>
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
In-Reply-To: <20261026-e-notation-v4-5-a366a6d14d57@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 08:54:09AM -0300, Rodrigo Alencar via B4 Relay wrote:

> Replace the open-coded __iio_str_to_fixpoint() parser with kstrtodec64(),
> so sysfs writes of fixed-point values also accept E notation.
> 
> The fractional part only keeps the sign when the integer part is zero,
> as before. The dB suffix for scale attributes is now handled by a separate
> __iio_str_to_fixpoint_units() helper. It strips an optional trailing
> newline and the "dB" or " dB" suffix before parsing.
> 
> When there is no fractional part (fract_mult == 0, or dec_scale == 0 for
> 64-bit values), try base-autodetecting kstrtoll() first so hexadecimal
> and octal input keeps its meaning ("010" is still 8). Fall back to
> kstrtodec64() on -EINVAL to accept E notation.

> As a side effect, inputs that used to be rejected for integer-only
> attributes are now accepted. An invalid octal number such as "08" is
> parsed as decimal 8, and a fractional value such as "1.5" is rounded
> to 2.

The main question here is: Do we want these side effects?
And follow up question is: Where is it going to be documented?
I consider this paragraph is very important for the users.

...

> +	/*
> +	 * Keep hex/octal support for integers. E notation and decimal values
> +	 * result in -EINVAL from kstrtoll, due to unexpected termination on '.'

kstrtoll()

> +	 * or 'e'. It falls back to kstrtodec64 for decimal fixed-point numbers
> +	 * with zero scale.
> +	 */
> +	ret = kstrtoll(str, 0, val);
> +	if (ret == -EINVAL)

> +		ret = kstrtodec64(str, 0, val);

		return kstrtodec64(str, 0, val);

?

> +	return ret;

...

>  int iio_str_to_fixpoint(const char *str, int fract_mult,
>  			int *integer, int *fract)
>  {
> -	return __iio_str_to_fixpoint(str, fract_mult, integer, fract, false);
> +	s64 dec64;
> +	int ret;
> +
> +	if (fract_mult) {
> +		/* scale = ffs(fract_mult) = ffs(10^n) = ffs(2^n * 5^n) = n + 1 */
> +		ret = kstrtodec64(str, ffs(fract_mult), &dec64);
> +		if (ret)
> +			return ret;
> +
> +		dec64 = div_s64_rem(dec64, fract_mult * 10, fract);
> +		/* only carry the sign in fract if the integer is zero */
> +		if (dec64)
> +			*fract = abs(*fract);

Should we actually switch to UB-free abs() implementation?

> +	} else {
> +		ret = iio_str_to_s64(str, &dec64);
> +		if (ret)
> +			return ret;
> +
> +		*fract = 0;
> +	}
> +
> +	if (dec64 > INT_MAX || dec64 < INT_MIN)
> +		return -ERANGE;
> +
> +	*integer = dec64;
> +
> +	return 0;
>  }

...

> +		if (scale_db)
> +			ret = iio_str_to_fixpoint_units(buf, "dB", fract_mult,
> +							&integer, &fract);

Can we actually make units to be the last argument? In this case we might join
two calls together, it also might be beneficial from code generation point of
view (as the units version calls the basic one at the end).

> +		else
> +			ret = iio_str_to_fixpoint(buf, fract_mult, &integer,
> +						  &fract);

-- 
With Best Regards,
Andy Shevchenko


