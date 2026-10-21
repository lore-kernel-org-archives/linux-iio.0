Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573410;
	b=f3Ny++heqSTSvtYvZXhF8W8XnfnCxiX1eoj5M3Z/P+BMPG5QvxxP705ZRqsgpY48AXdJ
	 +egRaTtootrIeVIebpxkXino3Nnqtb2wVmsPL4LP+y+f7jFlgEZqT8Okhcb9yukZxFs0Z
	 ULkkh7l5LD8mHrxvvnrtDMEuOr+ocM0Y2Eiiy6zUo5SuvblBHW9TuEXlr6CuF3IFr4MH7
	 TkhkHepgnRnZnpNj6MVHZ0Z2nCM3j+dSnyTSNZ76rHBG//FRhj9B+KaTvwppeD9fB5+7u
	 aGihGIGT9fjJ5EOLu7ppXKiUu1yUnltw3OYA0DWxrc8TsSj+94yiejQ8Paix28hYdHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573410;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=/FDscUJe/+Zh4VcpAtpYxvKlqYB5zjjERCViypwicxs=;
	b=NcYA/mZ1eb14HVlCL60oH3toYuI7upCmd24CZKYFCv6HIWGG8VgYUl9NJ/FfDASbsEUc
	 KsUCBSjSwP9kXtsUyTUJ3N1e4V1Pb+h8OKf5O5EmH343hBZW5HTp0FbG0aHZHWDbO2WGZ
	 XkPoxBf+AqABafVAjE1pTEXEqRZUvrzOsTAcILz49D87SwPcJYd7bbGh2VjF942MK39jc
	 QKnVwO1VhNkocrPqeAMRTm4evxjQ9TTQ1tVSeYufLkiYZSdjnXHSLwnEbqrqXF/UV3eyA
	 1TOEHzZT1yz7q4FYfX6Fktl6VwSgV5VHZUaYTu7Ti7y4ok3rHB7tutEpDuJXBSI51KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=goyzI8PT;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE76C606A319;
	Wed, 21 Oct 2026 09:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE76C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=goyzI8PT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792573410; x=1824109410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wNd5l70aElZE17LPJbYzy8JqxayMF6uM86HCSVQ6tx4=;
  b=goyzI8PTWw/Cw3FQGT82PLRNx+JobrMD/lI8DeGqzvAPTg7QcRb7S/CD
   TT7xrN0JxihwdRVc7mIYZw9XqGHGKq2OPOc9Nkpztno/l3p6Bu9celIjo
   jYuIpJDZ+eX5q2EL9OXO5kw3wuieHkwAfAl/LyTcufAlmLI7hpcgya+py
   iWjdzKDEvTT50dIdjpC9V858WAOzZ1tuTESIFlwbKdwnIrBL2asvW6o6d
   G4tK0o4GrB3hCIV34MnrU7jPwbBNr2vRbLzPUk+yTboiWZWgZeYMR9MY+
   GeXPX5LzAGPrW/26iU+TMwVHZvM1LrPUVZ362LJ6xWeDIne0e3DCOnqya
   Q==;
X-CSE-ConnectionGUID: yyaEgYjIT4iy6IyCkRVBKg==
X-CSE-MsgGUID: BFbKVU2RT3q7quY7DxH3vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1180189"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1180189"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 02:03:30 -0700
X-CSE-ConnectionGUID: UqnKmGK3TTK65RfSM+xUog==
X-CSE-MsgGUID: cUWF/p5kTCO+/0rCEjBYoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="4837341"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 02:03:27 -0700
Date: Wed, 21 Oct 2026 12:03:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC v3 2/5] lib: kstrtox: round to nearest, ties to even
 in kstrto[u]dec64()
Message-ID: <ath_3QVy5DVV4fxw@ashevche-desk.local>
References: <20261020-e-notation-v3-0-fd385c0fbf65@analog.com>
 <20261020-e-notation-v3-2-fd385c0fbf65@analog.com>
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
In-Reply-To: <20261020-e-notation-v3-2-fd385c0fbf65@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 09:27:00AM -0300, Rodrigo Alencar via B4 Relay wrote:

> kstrtoudec64() and kstrtodec64() drop the digits beyond the requested
> scale, which truncates the result toward zero. The error is up to one
> unit in the last place and is always in the same direction.
> 
> This is easy to hit with values produced by userspace floating point
> formatting. Printing 0.3 with "%.17g" gives "0.29999999999999999",
> which is parsed as 299999 with a scale of 6 instead of 300000. With E
> notation a negative exponent can also drop integer digits, so "19e-1"
> with a scale of 0 gives 1 instead of 2.
> 
> Round the result to nearest instead, with ties to even. This is the
> IEEE 754 default rounding mode, as used by strtod() and printf(), and it
> does not bias results in either direction. The first discarded digit is
> known from where parsing stopped, so no extra pass over the string is
> needed: the remaining digits are only checked when the first discarded
> digit is a 5. Since round-half-even is symmetric, kstrtodec64() keeps
> rounding the magnitude and negates it.
> 
> Inputs that fit within the scale are parsed exactly as before. An input
> that rounds up past the type limit, such as "18446744073.7095516155"
> with a scale of 9, now returns -ERANGE.

> Update the existing truncation test cases and add cases for ties and
> for rounding at the type limits.

...

> +static bool _round_half_even(const char *p, const char *end, u64 res)
> +{
> +	if (p == end || *p < '5')
> +		return false;
> +	if (*p++ > '5')

This hidden ++ makes the whole if chain to be strict in order, gives less
readability and flexibility in my opinion.

> +		return true;

So, this can be split to

	// Does this need to be first?
	if (p == end)
		return false;

	if (*p < '5')
		return false;
	if (*p > '5')
		return true;

	while (++p < end) {
		...
	}

> +	/* tie: any nonzero digit after it breaks it, skipping the decimal point */
> +	for (; p < end; p++)
> +		if (*p != '0' && *p != '.')

This is a loop, so this also passes '.0.0.' case and some other similar to it.
Is this a problem?

> +			return true;
> +	return res & 1;

So, this res is used only once to get a parity. But this doesn't semantically
sound like boolean to me. What if we actually return 0 or 1 from this function
and use its output directly in the check_add_overflow()?

> +}

-- 
With Best Regards,
Andy Shevchenko


