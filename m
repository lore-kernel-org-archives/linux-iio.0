Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00E2D8382;
	Tue, 17 Feb 2026 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316889; cv=none; b=qAvPVsuUYy7Y0oahzdjDy0N2H7wIaDGo2ES4DD+OeI3Iv4vVvXiHInL33+yRBJEX62kxxNccZ23VL49JfWwoBtMbyljsepPlfJKXs3ebwEhFDz2IkKsO5kJs9ePuN64YjfKdULmNqmLb0egDGGQl50zG4sGE+e5KLqQXF0HZHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316889; c=relaxed/simple;
	bh=ROsJTjNjc83GVtb1CflYWe4hRofwHVL07l0ewBebOHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4+MCXUHzTlhwtwcV2PGyOJchVS+TtUavgqosGlH1Aa/fkO9iT6ve2FJ8ho+jA8H1koOYG3iK9XGBhPCZw0ioylq6zkWDt+vd2QasZbn0GKePvuETn5iHkVgQg+/w1zcvAXMaS7Fu0s4QnGSWBXyrOFGnrQBGT7j+mqRJTld/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/MGU5kL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/MGU5kL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771316889; x=1802852889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ROsJTjNjc83GVtb1CflYWe4hRofwHVL07l0ewBebOHU=;
  b=E/MGU5kLGg5ceJHec7ElRAL1k2ACh5CuqVvxxCSrMaK+EpgK8yE15u/h
   0PrLZDwp6KgzVz0D0ncJOql0a76UtemyDUBDH7GAAOq3XNVxntnwctKWX
   eJOEEO/CVD+LiC4EJTsOntXVejdFgzzQ9cEFxK9ayxJRRgEoEZ2TKNfex
   0fwE8Py35M2NmYXhZjkZ5v4lbSpnTkEl+RUBla13n+1TFhvuflFgcqz5l
   lp97bkY96n4PJlRaB55w3OXjfn/zA1Y91SsLUfMv+Il2DLnt9gs7O6Az5
   GLSpiU5ORJLlnxjJLSEfjXPrvwh6H3NwWIvcCbO+kRI44DWpbdDCvkB/S
   A==;
X-CSE-ConnectionGUID: fySaL6rIQoSiott9+jKaVw==
X-CSE-MsgGUID: hZ8bId+EQReXSMf95L3P6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72425443"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="72425443"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 00:28:09 -0800
X-CSE-ConnectionGUID: 73nYr1xIQqOAosuivAbZ3Q==
X-CSE-MsgGUID: JL+9hg/mTg2tfMgoRSEfhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="212309259"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO localhost) ([10.124.220.245])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 00:28:04 -0800
Date: Tue, 17 Feb 2026 10:28:02 +0200
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
Message-ID: <aZQmkm9Xt3PivqmX@smile.fi.intel.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
 <aYiGj_TYelvJdVaR@smile.fi.intel.com>
 <20260214160852.6862b58d@jic23-huawei>
 <aZC6wIWDdS8J_1eJ@smile.fi.intel.com>
 <897bd4d4-bbdf-4cbf-84f6-05c110d75d03@baylibre.com>
 <aZF9zoWHL9iHSK3q@smile.fi.intel.com>
 <dce24f01-2a8e-4b36-9685-6ff4293e2d5a@baylibre.com>
 <aZLDyWICGB_j0Z1Y@smile.fi.intel.com>
 <2f9fc7fa-dd55-44f2-9b78-c9902b8b1bbf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f9fc7fa-dd55-44f2-9b78-c9902b8b1bbf@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 16, 2026 at 12:53:10PM -0600, David Lechner wrote:
> On 2/16/26 1:14 AM, Andy Shevchenko wrote:
> > On Sun, Feb 15, 2026 at 05:16:47PM -0600, David Lechner wrote:
> >> On 2/15/26 2:03 AM, Andy Shevchenko wrote:
> >>> On Sat, Feb 14, 2026 at 12:31:12PM -0600, David Lechner wrote:
> >>>> On 2/14/26 12:11 PM, Andy Shevchenko wrote:
> >>>>> On Sat, Feb 14, 2026 at 04:08:52PM +0000, Jonathan Cameron wrote:
> >>>>>> On Sun, 8 Feb 2026 14:50:23 +0200
> >>>>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >>>>>>> On Fri, Feb 06, 2026 at 06:07:12PM +0200, Antoniu Miclaus wrote:

...

> >>>>>>> I believe there is a better approach, what you need is rather a flag
> >>>>>>> to SPI core to tell that this is the device with shared CS.
> >>>>>>
> >>>>>> Antoniu, this comment from Andy needs addressing before we move
> >>>>>> on. It seems fairly fundamental and I'm not seeing a reply to it on list.
> >>>>>>
> >>>>>> I'm not entirely sure what Andy is suggesting will work but this
> >>>>>> is perhaps a mismatch in really understanding what is going on here.
> >>>>>> Andy, how would a flag work given they seem to be separately addressable
> >>>>>> SPI buses. I think this isn't a shared SPI CS, but rather a device
> >>>>>> with two entirely separate SPI buses. I think the only reason
> >>>>>> we are bothering to implement it as a single device at all is the
> >>>>>> shared backend.
> >>>>>
> >>>>> My understanding that there are two devices that for whatever reason share
> >>>>
> >>>> It is the opposite. It is a _single_ device with _two_ CS lines.
> >>>
> >>> Don't we have already support for that? This changes the picture even more towards
> >>> NAKing this. See below why.
> >>
> >> Yes, spi_new_ancillary_device() was introduced exactly for this sort
> >> of thing, which is why I think it makes sense to use it.
> >>
> >>>> adc@0 {
> >>>> 	reg = <0>, <1>;
> >>>> 	...
> >>>> };
> >>>>
> >>>>> the same CS line. Yes, I probably misread the idea behind, but I meant
> >>>>> some flag for SPI device that tells SPI core that the CS it wants is shared
> >>>>> (maybe a high bit in the cs field or so), then CS core won't complain on
> >>>>> validation about using the same cs number which is "already in use".
> >>>>
> >>>> There was one existing user in the kernel of spi_new_ancillary_device()
> >>>> that looked like this, so it seemed the right way to approach it. However,
> >>>> code was added later that caused the primary SPI device to "claim" both
> >>>> CS lines for itself and probably broke the one existing user of
> >>>> spi_new_ancillary_device() (hard to tell without hardware to test).
> >>>>
> >>>> The idea here was to unbreak that so we could use spi_new_ancillary_device()
> >>>> just as in the existing use case.
> >>>>
> >>>> The patch for that could have been a bit more strict to only allow the
> >>>> spi_new_ancillary_device() to take CS 1 and fail otherwise, but users
> >>>> are going to notice if it isn't working right anyway, so I didn't ask
> >>>> for more checking.
> >>>
> >>>>>> There is an argument that maybe we should be looking at how
> >>>>>> to do data muxing backends to support the more general case of two
> >>>>>> separate chips feeding into a single buffer, but that's a complex
> >>>>>> beast and I'm not sure if it is something we actually need.
> >>>>
> >>>> I think it would actually be quite similar to what is done in this
> >>>> series.
> >>>
> >>> TBH, the change sounds to me like a hack. It doesn't cover other potential ways
> >>> of the multi-cs devices come into play. Given that SPI core supports multi-cs
> >>> I don't see a good justification for this patch.
> >>>
> >>> What did I miss?
> >>
> >> As far as I can tell, other than the one existing user of
> >> spi_new_ancillary_device(), other SPI multi-CS stuff is only used
> >> by SPI flash memory devices, not general SPI devices. There code
> >> that is being modified here was introduced to support the SPI
> >> flash memory devices, so that use case is already covered by
> >> existing code.
> > 
> > Right. And obvious question why can't we apply the same approach
> > to any SPI device? Like extending existing code to cover generic
> > cases.
> 
> spi_new_ancillary_device() was already accepted in the kernel as the
> solution for this sort of use case, so isn't it already the generic
> approach?

I don't think the single user functionality is considered generic.

> I can see that it could possibly be nice if the SPI core saw that
> there was more than one CS and called spi_new_ancillary_device()
> automatically and somehow passed that along with the main SPI device
> to the driver probe function. But since this is only the second user
> of spi_new_ancillary_device(), I don't think we have enough data
> points to be able to say if this is really what all peripheral drivers
> would want.

Also, if that one designed for the case, why is needed patching?

...

The  mentioned approach predates the SPI memory chip support being
integrated into SPI core. I think we should consider to kill
spi_new_ancillary_device() in favour of using the same mechanism
as being used for SPI mem chips.

-- 
With Best Regards,
Andy Shevchenko


