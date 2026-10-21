Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573701;
	b=jxoIRKVOVeXjCcVQhYsRcsatVo0TdQWXl59HUaWyF0oelWQk9IXjesl40e0xtd+0l/zy
	 Xo0/F/7du6qdyd/rsVUxiwvxTqXsMr3zMEhPFCFayAQaUZsTTm//eezmD0HWad8CHoXSZ
	 vqXwKHyVNpkoG4oGKQ8HIETVAObOiU+2DGLx6PwDJEHLYFlAvMYIkZ9f5i5V1GJVEmwyo
	 mR8hKVy77xt07XTNVNFvzp7VKNMj1xhfDxUiQyDZWqzHUDTKxQ87/ONQNbuBVsnQjUP7M
	 Z5ebcITGQ9RcUV2qfZVolOZp0HKD3WgdLNLtavYl4xhGmtJHW2aaiuUi0OUZGgoT3jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573701;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=jqdq9X5bM15xc7OisIWWI/YuPfesz0tDyYQssUckQMQ=;
	b=K29GhgiTYVaMdWlgRRNB3Hkh5jSLtDRUV6xP+os2W3WjACMpwJGtWTujencREcHRIKt4
	 ww+Qz3C1Jd+42eshnuaM1X68LE33pqOHpPMKUg8PYu+NVEJHAM8HLFrjomRa/3w6zXnMU
	 EAgmdRtjyZEgFab1ca3jiurN1Jn24q+uIca4rwJqvgjLH+YyQwIgRXO3eSRwBmMKmJJry
	 iAV0fMgNHo9VrWMbqo9V1UyJBO2RIMPvG7b7eQeNTEhhfSgHbKCW1CWaZ5UlTqWbQpekw
	 7Q4xRVLsmynA5OGHQ1UMNFzqPekWtIcQg0qxCh67Wz+EaenDQj/zrGexKmQKr5U/hRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kv73UDwU;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E27606A319;
	Wed, 21 Oct 2026 09:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92E27606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kv73UDwU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792573701; x=1824109701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gk2GYl6TMKu5dIgZTAcq2eScBOSs/fNp+ZWZ/sjwShM=;
  b=kv73UDwU/+6lRx+fuza+lCf43/aK6pxvdrxPMXmAATRiyhx7l0DAepVg
   SoPE11UPMi8IrMS6P3u0vSOhytIdMZVlP7b2NeWvmdxaiQZUVZmOrfwFf
   JEzecEvL7a3cyvtpVn5ps2xgK71ZqFdvPsgFSfskDQEmzuYIgQSsYcGQc
   7a8RuZbq/oREWMNGvEZBntvs40KU/TLXWPZpIt3QuAQp96Xh4K8zhtCor
   btt/8oFYPivbqyWi01bIda/kGQjPwNbJCSISmn9uAZE1jK5qTExRj0ryH
   R/Ky/DIIYWZ5EKHpBBPzgEwg0mYj7bV+1pGoaiUTHRHc1bU7cqO8Hyx1Q
   w==;
X-CSE-ConnectionGUID: lf6Yvd+XTNu+BQlSIFGVnw==
X-CSE-MsgGUID: mNL/rlOaSeu5vxxP6Ktu0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1172183"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1172183"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 02:08:20 -0700
X-CSE-ConnectionGUID: HSprE5gvTOqTv7VcR6t7pw==
X-CSE-MsgGUID: 4Txs6F0fSRyn2tf/Lqj+QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2985101"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 02:08:17 -0700
Date: Wed, 21 Oct 2026 12:08:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC v3 4/5] iio: core: use kstrtodec64() to parse
 fixed-point values
Message-ID: <atiA_Z_kIbvzS7EQ@ashevche-desk.local>
References: <20261020-e-notation-v3-0-fd385c0fbf65@analog.com>
 <20261020-e-notation-v3-4-fd385c0fbf65@analog.com>
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
In-Reply-To: <20261020-e-notation-v3-4-fd385c0fbf65@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 09:27:02AM -0300, Rodrigo Alencar via B4 Relay wrote:

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
> 
> As a side effect, inputs that used to be rejected for integer-only
> attributes are now accepted. An invalid octal number such as "08" is
> parsed as decimal 8, and a fractional value such as "1.5" is rounded
> to 2.

...

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
> +	} else {
> +		/* keep hex/octal support for integers */
> +		ret = kstrtoll(str, 0, &dec64);
> +		if (ret == -EINVAL)

The ret can be something else as well. Why only -EINVAL? Perhaps add a comment
on top of if ()?

> +			ret = kstrtodec64(str, 0, &dec64);
> +		if (ret)
> +			return ret;
> +
> +		*fract = 0;
> +	}
> +
> +	if (dec64 > INT_MAX || dec64 < INT_MIN)
> +		return -ERANGE;
> +
> +	*integer = (int)dec64;

Do you need casting?

...

> +/**
> + * __iio_str_to_fixpoint_units() - Parse a fixed-point number with units from a string
> + * @str: The string to parse
> + * @units: The units to expect at the end of the string
> + * @fract_mult: Multiplier for the first decimal place, should be a power of 10
> + * @integer: The integer part of the number
> + * @fract: The fractional part of the number
> + *

Add a description with the examples, what can be the input and what is expected
output.

> + * Returns:
> + * 0 on success, or a negative error code if the string could not be parsed.
> + */
> +static int __iio_str_to_fixpoint_units(const char *str, const char *units,
> +				       int fract_mult, int *integer, int *fract)
> +{
> +	size_t units_len = strlen(units);
> +	size_t s_len = strlen(str);
> +	const char *dec_str = str;
> +	char buf[64];
> +
> +	if (s_len && str[s_len - 1] == '\n')
> +		s_len--;
> +
> +	if (s_len > units_len &&
> +	    !strncmp(str + s_len - units_len, units, units_len)) {
> +		s_len -= units_len;
> +		if (str[s_len - 1] == ' ')
> +			s_len--;
> +		if (s_len >= sizeof(buf))
> +			return -EINVAL;
> +		memcpy(buf, str, s_len);
> +		buf[s_len] = '\0';
> +		dec_str = buf;
> +	}
> +
> +	return iio_str_to_fixpoint(dec_str, fract_mult, integer, fract);
> +}

...

> +		if (dec_scale) {
>  			ret = kstrtodec64(buf, dec_scale, &integer64);
> +		} else {
> +			/* keep hex/octal support for integers */
>  			ret = kstrtoll(buf, 0, &integer64);
> +			if (ret == -EINVAL)
> +				ret = kstrtodec64(buf, dec_scale, &integer64);
> +		}
>  		if (ret)
>  			return ret;

This is a dup with the above, can we have a common helper?

-- 
With Best Regards,
Andy Shevchenko


