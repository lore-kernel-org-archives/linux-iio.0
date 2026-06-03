Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8954219EE;
	Wed,  3 Jun 2026 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475431; cv=none; b=r2py/jPId7ep02ZEfz3SX+PU5n4ZqjDTx15uGEG1j2V6rc1/c0UyRBVF1bQu3C/QbymSSEfJjzHrk0fEjGd6OMJnhwkZRqDSU1EvdJ2Q5MtCTZubZ4GyXt0TiL2k9aU0np1UOm0VfV1+1zZpgbPcKokhbGYI2QvepdTeEeVEnOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475431; c=relaxed/simple;
	bh=GB89Y8MUH6tSku1C9M0gHxJRmpls8P2xLSXw0JEWHSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4Rz7VcvVJTSLFGfbdOzSSgNYelB9nN1UtmRuiA94JiON2UfTP1ZBTOYG6WXHLgG3VIv0QcpBRou0X1ghAyh0BQhjJ3mzlSk1I44mXj0HWWF5U5Qx8ETiMDSfF5WM1iJA8Id2A3iKoOVaEbeYbfIMhDCf9u6zzEHa5oMrKCZm9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URnIkHac; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URnIkHac"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780475430; x=1812011430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GB89Y8MUH6tSku1C9M0gHxJRmpls8P2xLSXw0JEWHSw=;
  b=URnIkHacivOEjAg/0Nt61+3FEBLRA0Suy0zVT1+VoaB2kwv8q67f/z9w
   Tpy8ZRHa6ohJEJcb894MoZlJucYQlDD8aQplV7mBjeBSX9i5lj5+eQ0Fi
   DCvrRO7xrbGO+iXc/rb1rowUWmnF1eBe8QQwP2/yeahxW9xI/RVjZCF6U
   KUWaZv7bfNL4GjSUrzzdyDaKpYjEDOM3Ba48HxA2UwMr/o9fq80AMIY03
   ukGSOMAbhGlM56ARJYVY8MEzl7hUr5S14SQIE+UkOHh985S51JY9rtmc3
   QgX6U/iMHsSope4PjHXhTdss5s6Q/Rdfot1mdO9YXr4mIQ6+bzp8QetU4
   g==;
X-CSE-ConnectionGUID: mEvPUz1DSiOg8jMWtoKNyw==
X-CSE-MsgGUID: 3Hx8ZyVbStms9Frs/vwizw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81334805"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81334805"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 01:30:29 -0700
X-CSE-ConnectionGUID: gEPMMCICRaWxS+ZoM8eblw==
X-CSE-MsgGUID: YAWq7yJ2RBqIbyhXr3gn0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="237801576"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 01:30:25 -0700
Date: Wed, 3 Jun 2026 11:30:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v15 03/12] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <ah_mHskAN1zljpL5@ashevche-desk.local>
References: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
 <20260531-adf41513-iio-driver-v15-3-da09adf1c0dd@analog.com>
 <ah9EXNnutqk1FoV2@ashevche-desk.local>
 <etbgk2eap5w2db36kqoze7qehp2jmydc5a7stfymqowsqukf45@g2w4zew2zhic>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <etbgk2eap5w2db36kqoze7qehp2jmydc5a7stfymqowsqukf45@g2w4zew2zhic>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 09:13:40AM +0100, Rodrigo Alencar wrote:
> On 26/06/03 12:00AM, Andy Shevchenko wrote:
> > On Sun, May 31, 2026 at 09:30:46AM +0100, Rodrigo Alencar via B4 Relay wrote:

...

> > > +static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
> > > +{
> > > +	u64 _res = 0;
> > > +	unsigned int rv_int, rv_frac;
> > > +
> > > +	rv_int = _parse_integer(s, 10, &_res);
> > > +	if (rv_int & KSTRTOX_OVERFLOW)
> > > +		return -ERANGE;
> > > +	s += rv_int;
> > > +
> > > +	if (*s == '.')
> > > +		s++; /* skip decimal point */
> > > +
> > > +	rv_frac = _parse_integer_limit_init(s, 10, _res, &_res, scale);
> > > +	if (rv_frac & KSTRTOX_OVERFLOW)
> > > +		return -ERANGE;
> > > +	s += rv_frac;
> > 
> > > +	if (!rv_int && !rv_frac && !isdigit(*s))
> > 
> > Do we care about isdigit() here? Why?
> 
> The check here validates the presence of digits, and
> this is to cover a corner case with scale = 0 and s = ".5",
> which is considered a valid input and leads to rv_int = 0 and
> rv_frac = 0, outputing res = 0

Please, add a comment on top of this check.

-- 
With Best Regards,
Andy Shevchenko


