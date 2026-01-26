Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B93321C1;
	Mon, 26 Jan 2026 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439195; cv=none; b=mF8GHW+5RJRqDrnD/0Vq4XFzXrBEauLINw8qBPHDDH9iErWMbd5YRrYeQTqJiPD5KwMTTuXyfpguXdRVNAKOCnJVycSFUjE6onC2WV6HPF6uCVZZJcseGysONPS3oCktArZDLbgtS/VtFLYcXOymHw+9UC/M550K0DNSojXi/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439195; c=relaxed/simple;
	bh=xYNS1b6/qQVayx+HHXbdiyIC2qzlSuCcAYd+6MDXbe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQXFD5iVUfGxKfMg1ziq2gNczPu+C6hfqzDfquN0z0FvwNDoQz/NpvKMEcO+JzcO1EH5pc53xFO0auoWAaiBbrk2UlJwbD6axbIf3Ell01tXrF3el3DzdGtrDNlwq3csaRXVQvg/sBQxtIkB1TdKHgPOB2xLb/MoV+L3Ezhhz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9t/cAin; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9t/cAin"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769439194; x=1800975194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xYNS1b6/qQVayx+HHXbdiyIC2qzlSuCcAYd+6MDXbe4=;
  b=c9t/cAin0BqxkQO6lLS2nF5gXML9v15ZzSbo5cqP1kkuU4w0wBm0g6jf
   jXEHnbujTGPOmp9Q0GKAXc8uEQ5sZvlVula9eSPvAbc1ouKuhwLmhUM53
   hX7evm3eLfW8R9nz69NjJ0aLzXDIDeVkJ1nZ3QhRmx++1NdyeANtUAQ9O
   fzpQsXJWF2FwJeaYxF4PT1PTToZpy4TW9YREkW4oedJ7JeU7kqNNSbMxd
   PnAPirJdx9krgg/hQNgtpBqWhTaqNu+Ofe1wKFPJpVYUs/+At9LwFnpbG
   VGRifGe4GHbh1Gom23iot8cREZnWoQBFS/i1pQvF0Sm86q5MNcsUY5RPx
   w==;
X-CSE-ConnectionGUID: 9zAs2weMSH+8b2/TUTO8Ew==
X-CSE-MsgGUID: VUkLhwZuQY2c8P6y0+HX0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70514835"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="70514835"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:53:13 -0800
X-CSE-ConnectionGUID: uIA/s4lPScS4w6HSdXJrZQ==
X-CSE-MsgGUID: Ca5rcMmMQbmkQGM318Bq2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="207494921"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:53:09 -0800
Date: Mon, 26 Jan 2026 16:53:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
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
Message-ID: <aXd_0uNVm8c_Fhwd@smile.fi.intel.com>
References: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
 <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>
 <aXdUvRZ9NmP5Nh95@smile.fi.intel.com>
 <byitgzjli5gsq5v66topve7ip3inkk2udwhuihjdp6bknnkmos@tv226l7tek7s>
 <aXdtpkL5QUhhB_hh@smile.fi.intel.com>
 <ty6hptfh65k2rkqo6c6mg5z6vismuvyqsu3emvqarr2rbhpvcz@kn6tzjk5xi2o>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ty6hptfh65k2rkqo6c6mg5z6vismuvyqsu3emvqarr2rbhpvcz@kn6tzjk5xi2o>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 02:26:20PM +0000, Rodrigo Alencar wrote:
> On 26/01/26 03:35PM, Andy Shevchenko wrote:
> > On Mon, Jan 26, 2026 at 12:42:53PM +0000, Rodrigo Alencar wrote:
> > > On 26/01/26 01:49PM, Andy Shevchenko wrote:
> > > > On Fri, Jan 23, 2026 at 03:53:07PM +0000, Rodrigo Alencar via B4 Relay wrote:

...

> > > > > +static int __iio_str_to_fixpoint64(const char *str, u64 fract_mult,
> > > > > +				   s64 *integer, s64 *fract, bool scale_db)
> > > > > +{
> > > > > +	u64 i = 0, f = 0;
> > > > > +	char *end;
> > > > > +	int digit_count, precision = ffs(fract_mult);
> > > > > +	bool negative = false;
> > > > > +
> > > > > +	if (str[0] == '-') {
> > > > > +		negative = true;
> > > > > +		str++;
> > > > > +	} else if (str[0] == '+') {
> > > > > +		str++;
> > > > > +	}
> > > > > +
> > > > > +	i = simple_strtoull(str, &end, 10);
> > > > > +	digit_count = end - str;
> > > > > +	if (digit_count > 20)
> > > > > +		return -EINVAL;
> > > > 
> > > > Not really. If we are talking about decimal (only) cases we need to also count
> > > > leading 0:s.
> > > > 
> > > > 0000000000000000000000000000000025 is still 25, no overflow.
> > > > 
> > > > That's why I recommend to have a helper, maybe for now locally here, like
> > > > 
> > > > int safe_strtoull(..., unsigned long long *res)
> > > > {
> > > > 	...
> > > > }
> > > 
> > > Are you suggesting to not use simple_strtoull then?
> > 
> > Nope, I suggest to do an additional step before checking for the range.
> 
> You mean, conditionally skip leading 0's when parsing the integer part?
> e.g.
> 
> /*function entry and arg check */
> while(*str == '\0')
> 	str++;
> /* then call simple_strtoull() */

Not skipping, but counting them.

> simple_strtoull() is not overflow-safe,

Yes, I know. That's why all these additional checks are required,

> as it does not use
> check_mul_overflow() or check_add_overflow(), only checking the
> amount of digits is not enough.

Why? Can you elaborate how checking amount of digits is different to
check_mul_overflow()?

> Previous implementation of fixpoint parsing didn't care about that.

Do we have test cases for the current implementation?

> > > Understood, leading zeros can be ignored only when parsing the integer 
> > > part. Also, would be nice to have truncation of the fractional part
> > > while doing the parsing. How about:
> > > 
> > > static int iio_safe_strtoull(const char *str, const char **end,
> > > 			     size_t max_chars, u64 *res)
> > 
> > > - max_chars = 0: ignores leading 0's and process all digits
> > > - max_chars > 0: process only initial max_chars digits and ignores the rest
> > 
> > I'm not sure why we would need that. It should parse the whole line until the
> > first invalid character or overflow.
> 
> "process all digits" and "ignores the rest" would be for digits only, so it
> would stop until the first invalid character is found. I suppose proper
> overflow check is implemented with check_mul_overflow() and check_add_overflow(),

I don't see the need. Amount of digits defines the order of the number (in
power-of-ten).

> while iterating over the characters and accumulating the value.

The problem that you can refer to is the corner case when the first
(most significant digit(s)) are already give an overflow while being
inside the allowed length. But it also can be checked.

...

The benefit of simple_strto*() over kstrto*() that they do not require
a temporary buffer and work over constant data (always).

If you see a way how to refactor lib/kstrtox.c and lib/vsprintf.c to have
an implementation there directly that may operate over constant buffers,
I will be glad to help with it. That would be good for existing cases,
such as Intel QAT driver, and any newcomers. I actually don't know why
the heck kstrto*() were made against non-constant buffers. Perhaps to
avoid this 'end' parameter...

-- 
With Best Regards,
Andy Shevchenko


