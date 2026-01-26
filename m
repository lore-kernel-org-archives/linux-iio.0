Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542525771;
	Mon, 26 Jan 2026 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443561; cv=none; b=h3tw6Xx3RL+PZSC8Abs/It64CzRzYq+T/1iszMQuPmV0YzrogVa5RsjysbIvafkWaWl9idh8saCt/ir7UVK/PqlNXm9SJGCccjZ99wJrLDec0SR5ucZ4CnhUUi1Csv/tab4nxeoNwAgiM+GKtdkYm0m3MHbnFC4nLDbz5pBnL/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443561; c=relaxed/simple;
	bh=j9Ow1cCCPEzCclIAsCuLpt7K+tD2MrNfDfh+tucsqm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSE+//031da0EBRpQFSkmy0tAaFbn3NsgbyeErtyoLMIh2npp82e4eciBfUPtUjH3Xle3/If8cW6fX2c7xDBQAWptuOddjSVGb7ilirkljhpvdBBv0qWL3Z5F8z/FgYSVqQlIEvWXhoZG8tYTYXQAjbPFhK5+2aiIE2pDA6vD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcTs2ZpL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcTs2ZpL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769443560; x=1800979560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j9Ow1cCCPEzCclIAsCuLpt7K+tD2MrNfDfh+tucsqm4=;
  b=gcTs2ZpLgL0spRQTKNgVwPTlvWLgNnCJ6XohDG1ryqJ6iV0Up82Hw3v3
   qk1YEM/5WWm3j8bq9RK4Wtgucj5RdNN589uu3Qc58EKC4Izqaqf3lfERC
   SKy+IJGtN8T+495eCOsAlKEKWXS8Ot2kDXXCGxdQNM2199AKV1u8s0YfM
   o689qBGNzMl9QGHpDvzC7Faf4HFgC3/9YPdDgYI88Q5KTOklfBjMt9NwS
   kWCnUdMF+ChUMzYcBQlu820vJNeT+5iMs7KA9jZ1s9ocmz4FQ/ZYPlH5o
   Jh1Si2lBv6ThP8hEjS8xhjKBdTUQhzzJeG7Kg94tZgoiMH4qlEhiQNz2A
   Q==;
X-CSE-ConnectionGUID: 8HkvLIM0QxySIObrJh2yAw==
X-CSE-MsgGUID: 5TUuPOrkRRO3GbO7WVQtEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="81341499"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="81341499"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 08:05:59 -0800
X-CSE-ConnectionGUID: 1NSz6S9gR9C158O6rmMjLQ==
X-CSE-MsgGUID: xQoc8Xx2S2iueyXkwU93Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="212253781"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 08:05:55 -0800
Date: Mon, 26 Jan 2026 18:05:52 +0200
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
Message-ID: <aXeQ4LHQOdy3K1tA@smile.fi.intel.com>
References: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
 <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>
 <aXdUvRZ9NmP5Nh95@smile.fi.intel.com>
 <byitgzjli5gsq5v66topve7ip3inkk2udwhuihjdp6bknnkmos@tv226l7tek7s>
 <aXdtpkL5QUhhB_hh@smile.fi.intel.com>
 <ty6hptfh65k2rkqo6c6mg5z6vismuvyqsu3emvqarr2rbhpvcz@kn6tzjk5xi2o>
 <aXd_0uNVm8c_Fhwd@smile.fi.intel.com>
 <n2ms3esyxlegqibu4nluut3x4c4bkjxt5xrcd4gw35xxb2tipb@a2v73y25kroc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2ms3esyxlegqibu4nluut3x4c4bkjxt5xrcd4gw35xxb2tipb@a2v73y25kroc>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 03:20:03PM +0000, Rodrigo Alencar wrote:
> On 26/01/26 04:53PM, Andy Shevchenko wrote:
> > On Mon, Jan 26, 2026 at 02:26:20PM +0000, Rodrigo Alencar wrote:
> > > On 26/01/26 03:35PM, Andy Shevchenko wrote:
> > > > On Mon, Jan 26, 2026 at 12:42:53PM +0000, Rodrigo Alencar wrote:
> > > > > On 26/01/26 01:49PM, Andy Shevchenko wrote:
> > > > > > On Fri, Jan 23, 2026 at 03:53:07PM +0000, Rodrigo Alencar via B4 Relay wrote:

...

> > > > > > > +static int __iio_str_to_fixpoint64(const char *str, u64 fract_mult,
> > > > > > > +				   s64 *integer, s64 *fract, bool scale_db)
> > > > > > > +{
> > > > > > > +	u64 i = 0, f = 0;
> > > > > > > +	char *end;
> > > > > > > +	int digit_count, precision = ffs(fract_mult);
> > > > > > > +	bool negative = false;
> > > > > > > +
> > > > > > > +	if (str[0] == '-') {
> > > > > > > +		negative = true;
> > > > > > > +		str++;
> > > > > > > +	} else if (str[0] == '+') {
> > > > > > > +		str++;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	i = simple_strtoull(str, &end, 10);
> > > > > > > +	digit_count = end - str;
> > > > > > > +	if (digit_count > 20)
> > > > > > > +		return -EINVAL;
> > > > > > 
> > > > > > Not really. If we are talking about decimal (only) cases we need to also count
> > > > > > leading 0:s.
> > > > > > 
> > > > > > 0000000000000000000000000000000025 is still 25, no overflow.
> > > > > > 
> > > > > > That's why I recommend to have a helper, maybe for now locally here, like
> > > > > > 
> > > > > > int safe_strtoull(..., unsigned long long *res)
> > > > > > {
> > > > > > 	...
> > > > > > }
> > > > > 
> > > > > Are you suggesting to not use simple_strtoull then?
> > > > 
> > > > Nope, I suggest to do an additional step before checking for the range.
> > > 
> > > You mean, conditionally skip leading 0's when parsing the integer part?
> > > e.g.
> > > 
> > > /*function entry and arg check */
> > > while(*str == '\0')
> > > 	str++;
> > > /* then call simple_strtoull() */
> > 
> > Not skipping, but counting them.
> > 
> > > simple_strtoull() is not overflow-safe,
> > 
> > Yes, I know. That's why all these additional checks are required,
> > 
> > > as it does not use
> > > check_mul_overflow() or check_add_overflow(), only checking the
> > > amount of digits is not enough.
> > 
> > Why? Can you elaborate how checking amount of digits is different to
> > check_mul_overflow()?
> 
> consider U64_MAX = 18_446_744_073_709_551_615 as the limit:
> - 19_000_000_000_000_000_000 contains the same amount of digits but overflows.
> - 18_446_744_073_710_000_000 contains the same amount of digits but overflows.

Yes, the first digits give up to 3 additional bits on top of 64-bit.

> to catch those cases, we need to check for the overflow, everytime we read a
> character and accumulate:
> 
> u64 acc;
> 
> while(isdigit(*str))
> 	if (check_mul_overflow(acc, 10, &acc) ||
> 	    check_add_overflow(acc, *str - '0', &acc))
> 		return -EOVERFLOW;
> 
> *res = acc;
> 
> acc can get weird results if not checked. 
> 
> > 
> > > Previous implementation of fixpoint parsing didn't care about that.
> > 
> > Do we have test cases for the current implementation?
> 
> No, I am adding a kunit test in this patch.
> 
> > > > > Understood, leading zeros can be ignored only when parsing the integer 
> > > > > part. Also, would be nice to have truncation of the fractional part
> > > > > while doing the parsing. How about:
> > > > > 
> > > > > static int iio_safe_strtoull(const char *str, const char **end,
> > > > > 			     size_t max_chars, u64 *res)
> > > > 
> > > > > - max_chars = 0: ignores leading 0's and process all digits
> > > > > - max_chars > 0: process only initial max_chars digits and ignores the rest
> > > > 
> > > > I'm not sure why we would need that. It should parse the whole line until the
> > > > first invalid character or overflow.
> > > 
> > > "process all digits" and "ignores the rest" would be for digits only, so it
> > > would stop until the first invalid character is found. I suppose proper
> > > overflow check is implemented with check_mul_overflow() and check_add_overflow(),
> > 
> > I don't see the need. Amount of digits defines the order of the number (in
> > power-of-ten).
> > 
> > > while iterating over the characters and accumulating the value.
> > 
> > The problem that you can refer to is the corner case when the first
> > (most significant digit(s)) are already give an overflow while being
> > inside the allowed length. But it also can be checked.
> > 
> 
> Yes. Not sure how to do that without checking every digit again.
> 
> > 
> > The benefit of simple_strto*() over kstrto*() that they do not require
> > a temporary buffer and work over constant data (always).
> 
> Agreed.
>  
> > If you see a way how to refactor lib/kstrtox.c and lib/vsprintf.c to have
> > an implementation there directly that may operate over constant buffers,
> > I will be glad to help with it. That would be good for existing cases,
> > such as Intel QAT driver, and any newcomers. I actually don't know why
> > the heck kstrto*() were made against non-constant buffers. Perhaps to
> > avoid this 'end' parameter...
> 
> That would be out of the scope of this patch.

Hmm... But if not doing that we will end up with a code duplication in one or
another form. The whole purpose of the patch is to avoid duplication.

-- 
With Best Regards,
Andy Shevchenko


