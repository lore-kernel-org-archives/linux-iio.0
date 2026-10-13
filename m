Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7B453C3B3;
	Tue, 13 Oct 2026 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918498; cv=none; b=fF/Xr0YFm1rS4h0cjUnVE6DBn3+1doA3JmsSN9kr2aEVnxXfgIUCntFBzdSKwd3TZjqZCrmjuUl/3w8Al7/rCEJvdUYW6Uw29zojc7aK/dKQZph6LriCshHsNJHuadk1hSPj4rZh8L/Lm8zfeacC+1YQD+g8qLgHsstbniDpEvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918498; c=relaxed/simple;
	bh=OSMBQzQWlv+w7HvYBgIi32dA3NwHbgaYc3kYTSOZHoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzM0+GzmRZAfAzwkyLj36YvdvbIqvvD+f8QpNzXwMdamMNl9M/9FCGUJSzcNEGzVDgBuwO0tawRRXdnamtvIS3XwDYETCGdBg0ec1XFKQjmH4R+kqrySuVr5pKcuYhEd10ayqaSKnrnuMs190E4jjIbTY1LLMoeTJkm+QxTvDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RqXsvRYq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RqXsvRYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791918496; x=1823454496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OSMBQzQWlv+w7HvYBgIi32dA3NwHbgaYc3kYTSOZHoQ=;
  b=RqXsvRYqoWGa1d2RuQhf3REYqVqIPab3/wslQAODj89fzfJM5R4+lAd/
   oR7KETM7945wN82FoTNsJOBkfGs+UIkdg9qOSO53iiU0fYczU3WSGQI1b
   MlB/b2KTwSJkhk4JzngQVd31mR6m4gYLwf8QB/rZQ5OEMztCQkOREyrcg
   6VgvGwkFYgKe2KZt2Xyj/phs5cQ9o5fWiiQ8Ay9CuZYNT8D5WjnS1yw9/
   h1WFS94h9zarH0wUFaHVlr7pgS+HYuGd+WK9O5Uw2sNq4Ditia9pmChQT
   6mSvBj1VD2bL7WkDlOKal/gPHOo0I4uHqcSt8ukxT2sf7KeP/IRYIfACt
   Q==;
X-CSE-ConnectionGUID: g2DF9SEYRrKQ0x8bqkjvvw==
X-CSE-MsgGUID: XmSLmdWLTiej6MnCHMlchw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="542680"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="542680"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 12:08:16 -0700
X-CSE-ConnectionGUID: DKx4OY7uQ+qAyb7Crls7bQ==
X-CSE-MsgGUID: 23cKmfM+RdmXw7PiDmPEog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1164052"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 12:08:14 -0700
Date: Tue, 13 Oct 2026 22:08:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC v2 3/4] iio: core: use kstrtodec64() to parse
 fixed-point values
Message-ID: <as6BmyTrFXggzg3S@ashevche-desk.local>
References: <20261013-e-notation-v2-0-d4adb5e193fc@analog.com>
 <20261013-e-notation-v2-3-d4adb5e193fc@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-e-notation-v2-3-d4adb5e193fc@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 10:36:46AM -0300, Rodrigo Alencar via B4 Relay wrote:

> Replace the open-coded __iio_str_to_fixpoint() parser with kstrtodec64(),
> so sysfs writes of fixed-point values also accept E notation.
> 
> The fractional part only keeps the sign when the integer part is zero,
> as before. The dB suffix for scale attributes is now handled by a separate
> iio_str_to_fixpoint_units() helper. It strips an optional trailing newline
> and the "dB" or " dB" suffix before parsing.
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

> -int iio_str_to_fixpoint(const char *str, int fract_mult,
> -			int *integer, int *fract)
> +int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
> +			int *fract)

Keep the logical split, id est don't touch these lines, there are no changes.

...

> +static int iio_str_to_fixpoint_units(const char *str, const char *units,
> +				     int fract_mult, int *integer, int *fract)
> +{
> +	size_t units_len = strlen(units);
> +	size_t num_len = strlen(str);
> +	const char *dec_str = str;
> +	char buf[64];

> +	if (num_len && str[num_len - 1] == '\n')
> +		num_len--;
> +	if (num_len > units_len &&
> +	    !strncmp(str + num_len - units_len, units, units_len)) {

Hmm... We have strends()... Do you expect string to have garbage at the end?
In such a case dB and dBm won't be distinguishable.

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

-- 
With Best Regards,
Andy Shevchenko


