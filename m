Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195F51FC7C5;
	Sun, 15 Feb 2026 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771142614; cv=none; b=IU4UJMBXLRC9HTTdg1/plmmi4bciwAQnVE5IozJ8ZHujDGfzRmLGN+c36yr+w2Eki7H8dPHgsBYfWY/4cA+o6AsCyGyGckd0Clz3wUlpwXo31l1v+mKstcAFrRqxWGf/OJpfo3H41LRYh/1SUkdm+KErZjqbKd/zlWL+KGaUZHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771142614; c=relaxed/simple;
	bh=eM4rQYhZZLvvDldIUzDPHDXYwzeYHd8jF5H7MNZ8kmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTApP98pjdbfqmfD/wHwmgzFTzl1XyhUeQ0f45GkXttvVtoH9mPxL0CtLFDuqbQPBHYPON8ywe+BYtbTE3Vx8k7m/9suFH347FsK2ThzQ5QCE2vl6vFxEs1f+oE4kDt7xuR/Y7pMQQEkaJplVMFv/l1ubkUm6I7+nAqWCJZpVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cF4wANW7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cF4wANW7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771142613; x=1802678613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eM4rQYhZZLvvDldIUzDPHDXYwzeYHd8jF5H7MNZ8kmE=;
  b=cF4wANW7RtcEP4eq8mrtsOEcI6UtIXJ2/RvGLOrV9D+CtrrUOWf4/oUx
   3TYH7wyopeYrXrpjN6s6LIv6/00d6PDIxP6741vipOkHwhEZH3Au0rZoH
   cYdg1RU/WxMfjaie4g//3MeoXfbpQZMLOxg2kBlcQm97RYD4+kSzlw/oV
   CfDCou5JirAEThnAMYAY5o3qRZMHvFnngOibEKKOx/YWW3b29WuzRD9xc
   +Cn+RiuUsNGZHF3b9DWCvyD72KewcYrvtbE92zCk2HBbOhgxccil7e7wK
   hNa06juij/RQDdpviYX0dnqVsSnCvw2YCkSh318M4C8lYrHi3a6j9jOMp
   Q==;
X-CSE-ConnectionGUID: rJkEvmlLSxqLkFQ3j5IPew==
X-CSE-MsgGUID: KU02drmhRIOKyDhJLyYS0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="83627893"
X-IronPort-AV: E=Sophos;i="6.21,292,1763452800"; 
   d="scan'208";a="83627893"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 00:03:32 -0800
X-CSE-ConnectionGUID: cl1r0fUaRNOCzh9VYMZWqA==
X-CSE-MsgGUID: 3hEt8fSQT4e/53JsMv0frA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,292,1763452800"; 
   d="scan'208";a="218283076"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.136])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 00:03:29 -0800
Date: Sun, 15 Feb 2026 10:03:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <aZF9zoWHL9iHSK3q@smile.fi.intel.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
 <aYiGj_TYelvJdVaR@smile.fi.intel.com>
 <20260214160852.6862b58d@jic23-huawei>
 <aZC6wIWDdS8J_1eJ@smile.fi.intel.com>
 <897bd4d4-bbdf-4cbf-84f6-05c110d75d03@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <897bd4d4-bbdf-4cbf-84f6-05c110d75d03@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 14, 2026 at 12:31:12PM -0600, David Lechner wrote:
> On 2/14/26 12:11 PM, Andy Shevchenko wrote:
> > On Sat, Feb 14, 2026 at 04:08:52PM +0000, Jonathan Cameron wrote:
> >> On Sun, 8 Feb 2026 14:50:23 +0200
> >> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >>> On Fri, Feb 06, 2026 at 06:07:12PM +0200, Antoniu Miclaus wrote:

...

> >>> I believe there is a better approach, what you need is rather a flag
> >>> to SPI core to tell that this is the device with shared CS.
> >>
> >> Antoniu, this comment from Andy needs addressing before we move
> >> on. It seems fairly fundamental and I'm not seeing a reply to it on list.
> >>
> >> I'm not entirely sure what Andy is suggesting will work but this
> >> is perhaps a mismatch in really understanding what is going on here.
> >> Andy, how would a flag work given they seem to be separately addressable
> >> SPI buses. I think this isn't a shared SPI CS, but rather a device
> >> with two entirely separate SPI buses. I think the only reason
> >> we are bothering to implement it as a single device at all is the
> >> shared backend.
> > 
> > My understanding that there are two devices that for whatever reason share
> 
> It is the opposite. It is a _single_ device with _two_ CS lines.

Don't we have already support for that? This changes the picture even more towards
NAKing this. See below why.

> adc@0 {
> 	reg = <0>, <1>;
> 	...
> };
> 
> > the same CS line. Yes, I probably misread the idea behind, but I meant
> > some flag for SPI device that tells SPI core that the CS it wants is shared
> > (maybe a high bit in the cs field or so), then CS core won't complain on
> > validation about using the same cs number which is "already in use".
> 
> There was one existing user in the kernel of spi_new_ancillary_device()
> that looked like this, so it seemed the right way to approach it. However,
> code was added later that caused the primary SPI device to "claim" both
> CS lines for itself and probably broke the one existing user of
> spi_new_ancillary_device() (hard to tell without hardware to test).
> 
> The idea here was to unbreak that so we could use spi_new_ancillary_device()
> just as in the existing use case.
> 
> The patch for that could have been a bit more strict to only allow the
> spi_new_ancillary_device() to take CS 1 and fail otherwise, but users
> are going to notice if it isn't working right anyway, so I didn't ask
> for more checking.

> >> There is an argument that maybe we should be looking at how
> >> to do data muxing backends to support the more general case of two
> >> separate chips feeding into a single buffer, but that's a complex
> >> beast and I'm not sure if it is something we actually need.
> 
> I think it would actually be quite similar to what is done in this
> series.

TBH, the change sounds to me like a hack. It doesn't cover other potential ways
of the multi-cs devices come into play. Given that SPI core supports multi-cs
I don't see a good justification for this patch.

What did I miss?

> > Yeah, if possible I prefer to look at the (ASCII art) schematics
> > on how the HW looks like (connections with busses and CS lines).

-- 
With Best Regards,
Andy Shevchenko


