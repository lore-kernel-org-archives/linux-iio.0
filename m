Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF1332EBE;
	Mon, 26 Jan 2026 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769428166; cv=none; b=mdZzReMk1GYNgDd6eXi1KXYXlmxxY4AsjSVyiknyBAU6mg09LIFd8aAV7ml5Ge2v+It0kvkfM9SP+AOS4y8AKOAFqKvpGds0ZtQFY3HzO92lfSSWAeqSTaYnm8yNELk+WroAZjtVQo8EOmM1Jpo+WIDR5mQb0Unn+NDIp/r6ADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769428166; c=relaxed/simple;
	bh=mLTI/Rc3fTn+15bs93dGEvkWnkXy18wYQevpv7dqnx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaZg5Fv1a7MzPL1mfva8pSHJy+tCdnm29XPK4joFCSvCLiapMt04lmwIv+O6kfcKU6N/ZSho8yNNlTLNjuPeuPDEcI0LVUhBgqNvnmfkT77s/e9+DBWpaDFN8xFrxfWg5UpOdbmsPwIC/BiDvuFHhjxKDFaIYmgXcQPpysMRBfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8Gl4TIe; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8Gl4TIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769428164; x=1800964164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mLTI/Rc3fTn+15bs93dGEvkWnkXy18wYQevpv7dqnx8=;
  b=P8Gl4TIehD8ee83orsU3AnFOA/fkohZiku6MYZpyLQbiBrZKWCdNi0Od
   om2K3NsZip6Avl+QDSwlf7K3e/wjFavZpDCWKLTZmkYmUb9au/GGY5roR
   rhcPQszMbSHJtyRK5JJkqIHWEr3/rtwVZudjfIxrAdULzpr1WwYGx7Rf3
   5zbYdgrNZJrFcpPxooB7s7PVpi5kAS9sPU/HiVngbFPvPpSTRQatJw7Le
   9/uE6FjGiUUbPefFFCU9hIZeOYgp+ow9bwWXq3DpH85wtLlfDs99jaTUM
   XjjyjU8CVHexaE2QRuK4VxVGgDDRpGFFVJoFP9zId7W/MjY8g/p2FbDIv
   g==;
X-CSE-ConnectionGUID: Y24mluxiTSiHzeMEa+CLCg==
X-CSE-MsgGUID: 3ga85jO6QNOSaxwAOe/gmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="88184516"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="88184516"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 03:49:23 -0800
X-CSE-ConnectionGUID: BGUXQ0V0SBqFn4BsujWiVg==
X-CSE-MsgGUID: AS7QmB7JRNujCrc86lQodw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="206783265"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 03:49:20 -0800
Date: Mon, 26 Jan 2026 13:49:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
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
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <aXdUvRZ9NmP5Nh95@smile.fi.intel.com>
References: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
 <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 03:53:07PM +0000, Rodrigo Alencar via B4 Relay wrote:

> Add iio_str_to_fixpoint64() function that leverages simple_strtoull()
> to parse numbers from a string.
> A helper function __iio_str_to_fixpoint64() replaces
> __iio_str_to_fixpoint() implementation, extending its usage for
> 64-bit fixed-point parsing.

...

> +/**
> + * __iio_str_to_fixpoint64() - Parse a fixed-point number from a string
> + * @str: The string to parse
> + * @fract_mult: Multiplier for the first decimal place, should be a power of 10

> + * @integer: The integer part of the number
> + * @fract: The fractional part of the number

Can we use struct s64_fract? (Yes, you would need to add a couple of lines into
math.h for that, but don't worry, I will Ack such a change immediately.)

> + * @scale_db: True if this should parse as dB
> + *
> + * This variant uses 64-bit integers for both integer and fractional parts.
> + *
> + * Returns:
> + * 0 on success, or a negative error code if the string could not be parsed.
> + */
> +static int __iio_str_to_fixpoint64(const char *str, u64 fract_mult,
> +				   s64 *integer, s64 *fract, bool scale_db)
> +{
> +	u64 i = 0, f = 0;
> +	char *end;
> +	int digit_count, precision = ffs(fract_mult);
> +	bool negative = false;
> +
> +	if (str[0] == '-') {
> +		negative = true;
> +		str++;
> +	} else if (str[0] == '+') {
> +		str++;
> +	}
> +
> +	i = simple_strtoull(str, &end, 10);
> +	digit_count = end - str;
> +	if (digit_count > 20)
> +		return -EINVAL;

Not really. If we are talking about decimal (only) cases we need to also count
leading 0:s.

0000000000000000000000000000000025 is still 25, no overflow.

That's why I recommend to have a helper, maybe for now locally here, like

int safe_strtoull(..., unsigned long long *res)
{
	...
}

that will do all necessary checks and returns -EINVAL, -ERANGE, et cetera.
In the below we would need check for the error codes respectively.

> +	if (precision && *end == '.') {
> +		str = end + 1;
> +		f = simple_strtoull(str, &end, 10);
> +		digit_count = end - str;
> +		if (!digit_count || digit_count > 20)
> +			return -EINVAL;
> +
> +		if (digit_count > precision) {
> +			digit_count -= precision;
> +			f = div64_u64(f, int_pow(10, digit_count));
> +		} else {
> +			digit_count = precision - digit_count;
> +			f *= int_pow(10, digit_count);
> +		}
> +	} else if (!digit_count) {
> +		return -EINVAL;
> +	}
> +
> +	if (scale_db) {

> +		/* Ignore the dB suffix */
> +		if (!strncmp(end, " dB", sizeof(" dB") - 1))
> +			end += sizeof(" dB") - 1;
> +		else if (!strncmp(end, "dB", sizeof("dB") - 1))
> +			end += sizeof("dB") - 1;

Now we have strends()

> +	}

And I'm not sure we need to go too deep with dB (I don't expect 64-bit values
for it ever), but for the sake of consistency and interoperability let's have
it be.

> +	if (*end == '\n')
> +		end++;
> +
> +	if (*end != '\0')
> +		return -EINVAL;

> +	*integer = (negative && i) ? -i : i;
> +	*fract = (negative && !i) ? -f : f;

> +	return 0;
> +}

...

> +	if (integer64 < INT_MIN || integer64 > INT_MAX ||
> +	    fract64 < INT_MIN || fract64 > INT_MAX)
> +		return -ERANGE;

This needs to account the sign, right?
It's fine to be UINT_MAX I believe. But I haven't checked the current
implementation.

-- 
With Best Regards,
Andy Shevchenko


