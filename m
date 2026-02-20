Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A933D6FD;
	Fri, 20 Feb 2026 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584318; cv=none; b=OXFBIJe+qamZJ2ZrMPhUkzP/KDoz4qHrt8mL8YMAaCbDa9aGxOC+2xpOqj+Q6ZB7/OcCDKgw9Am5w+apPn6dMc7dlcz9AbCqqCBoTXzOe/Z2+gQkkPnQy5q2lGF+63g7+tAJl94Iy4q3PzmrwOCKk+NLhst7HupvPxxahPChGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584318; c=relaxed/simple;
	bh=QZkT8ScrA199o1IIilaCEXHWoRsbZ25lr/JvvJWHqrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSaIhC3U3PpX0aAJ5EdcsJFabtqm/D7oX1ZpxZ3aqdaJLP2RkUGmlqNqwkzuVe1wOyTEVl/kVcw5e9IqFIe4d//AxDErWEloEpZZ/kcRy26QYo/tNQk1UmgobvKP8GYbTRgRm4+scCLKsqSN84rNgBqb7419B3WhX3wjPFDM9jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qxr6wche; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qxr6wche"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771584317; x=1803120317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QZkT8ScrA199o1IIilaCEXHWoRsbZ25lr/JvvJWHqrs=;
  b=Qxr6wche2RsHY90DctNwdPzD49ftp3ZOt9G1Qu58dqpDb0ODlV92TzsY
   L+7xmMOwqfYwXzCeV/SWFr2orW5eZNdtgsnBXN3CSVo8R1WjBKYTGnJ/H
   AXfL4/qiBTzRfqnrIzPZSQrP6gy2TQuy1tDOufVea3H21evEkW7hhYiOH
   X7XYfHqOdUTQBI2M2R8NLOVE/IbHsUDKymGzhMP9qJe61e/1M1LEQUnie
   JD48EmDVTU4gKimOLSbpHbaLNfAyjrDQdSx+ONmEYsR1qeswLMA0pI/nk
   Ix2sDNMRfaD2bnmuXWaCtmbonRYFz4NEgiGhz0v3WL9/zvg0hIRbntA+P
   w==;
X-CSE-ConnectionGUID: hyIF8V4kSKeY+ipX+oWU/A==
X-CSE-MsgGUID: fqtATK0fSYeAs4aIzsC9QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="90259648"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="90259648"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 02:45:16 -0800
X-CSE-ConnectionGUID: XxMsNIndSs2MpMoP0xq24w==
X-CSE-MsgGUID: vesYNkFtRaKkd3olEAkpXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="214047400"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 02:45:12 -0800
Date: Fri, 20 Feb 2026 12:45:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
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
Message-ID: <aZg7NmyVoFE4_UKt@smile.fi.intel.com>
References: <20260214160852.6862b58d@jic23-huawei>
 <aZC6wIWDdS8J_1eJ@smile.fi.intel.com>
 <897bd4d4-bbdf-4cbf-84f6-05c110d75d03@baylibre.com>
 <aZF9zoWHL9iHSK3q@smile.fi.intel.com>
 <dce24f01-2a8e-4b36-9685-6ff4293e2d5a@baylibre.com>
 <aZLDyWICGB_j0Z1Y@smile.fi.intel.com>
 <2f9fc7fa-dd55-44f2-9b78-c9902b8b1bbf@baylibre.com>
 <aZQmkm9Xt3PivqmX@smile.fi.intel.com>
 <d22c8fa8-1e8b-4f0a-80a1-3f13d75cd52c@baylibre.com>
 <20260218190834.642caae0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218190834.642caae0@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 18, 2026 at 07:08:34PM +0000, Jonathan Cameron wrote:
> On Tue, 17 Feb 2026 16:55:56 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> > On 2/17/26 2:28 AM, Andy Shevchenko wrote:
> > > On Mon, Feb 16, 2026 at 12:53:10PM -0600, David Lechner wrote:  
> > >> On 2/16/26 1:14 AM, Andy Shevchenko wrote:  
> > >>> On Sun, Feb 15, 2026 at 05:16:47PM -0600, David Lechner wrote:  
> > >>>> On 2/15/26 2:03 AM, Andy Shevchenko wrote:  
> > >>>>> On Sat, Feb 14, 2026 at 12:31:12PM -0600, David Lechner wrote:  
> > >>>>>> On 2/14/26 12:11 PM, Andy Shevchenko wrote:  
> > >>>>>>> On Sat, Feb 14, 2026 at 04:08:52PM +0000, Jonathan Cameron wrote:  
> > >>>>>>>> On Sun, 8 Feb 2026 14:50:23 +0200
> > >>>>>>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > >>>>>>>>> On Fri, Feb 06, 2026 at 06:07:12PM +0200, Antoniu Miclaus wrote:  

...

> > >>>>>>>>> I believe there is a better approach, what you need is rather a flag
> > >>>>>>>>> to SPI core to tell that this is the device with shared CS.  
> > >>>>>>>>
> > >>>>>>>> Antoniu, this comment from Andy needs addressing before we move
> > >>>>>>>> on. It seems fairly fundamental and I'm not seeing a reply to it on list.
> > >>>>>>>>
> > >>>>>>>> I'm not entirely sure what Andy is suggesting will work but this
> > >>>>>>>> is perhaps a mismatch in really understanding what is going on here.
> > >>>>>>>> Andy, how would a flag work given they seem to be separately addressable
> > >>>>>>>> SPI buses. I think this isn't a shared SPI CS, but rather a device
> > >>>>>>>> with two entirely separate SPI buses. I think the only reason
> > >>>>>>>> we are bothering to implement it as a single device at all is the
> > >>>>>>>> shared backend.  
> > >>>>>>>
> > >>>>>>> My understanding that there are two devices that for whatever reason share  
> > >>>>>>
> > >>>>>> It is the opposite. It is a _single_ device with _two_ CS lines.  
> > >>>>>
> > >>>>> Don't we have already support for that? This changes the picture even more towards
> > >>>>> NAKing this. See below why.  
> > >>>>
> > >>>> Yes, spi_new_ancillary_device() was introduced exactly for this sort
> > >>>> of thing, which is why I think it makes sense to use it.
> > >>>>  
> > >>>>>> adc@0 {
> > >>>>>> 	reg = <0>, <1>;
> > >>>>>> 	...
> > >>>>>> };
> > >>>>>>  
> > >>>>>>> the same CS line. Yes, I probably misread the idea behind, but I meant
> > >>>>>>> some flag for SPI device that tells SPI core that the CS it wants is shared
> > >>>>>>> (maybe a high bit in the cs field or so), then CS core won't complain on
> > >>>>>>> validation about using the same cs number which is "already in use".  
> > >>>>>>
> > >>>>>> There was one existing user in the kernel of spi_new_ancillary_device()
> > >>>>>> that looked like this, so it seemed the right way to approach it. However,
> > >>>>>> code was added later that caused the primary SPI device to "claim" both
> > >>>>>> CS lines for itself and probably broke the one existing user of
> > >>>>>> spi_new_ancillary_device() (hard to tell without hardware to test).
> > >>>>>>
> > >>>>>> The idea here was to unbreak that so we could use spi_new_ancillary_device()
> > >>>>>> just as in the existing use case.
> > >>>>>>
> > >>>>>> The patch for that could have been a bit more strict to only allow the
> > >>>>>> spi_new_ancillary_device() to take CS 1 and fail otherwise, but users
> > >>>>>> are going to notice if it isn't working right anyway, so I didn't ask
> > >>>>>> for more checking.  
> > >>>>>  
> > >>>>>>>> There is an argument that maybe we should be looking at how
> > >>>>>>>> to do data muxing backends to support the more general case of two
> > >>>>>>>> separate chips feeding into a single buffer, but that's a complex
> > >>>>>>>> beast and I'm not sure if it is something we actually need.  
> > >>>>>>
> > >>>>>> I think it would actually be quite similar to what is done in this
> > >>>>>> series.  
> > >>>>>
> > >>>>> TBH, the change sounds to me like a hack. It doesn't cover other potential ways
> > >>>>> of the multi-cs devices come into play. Given that SPI core supports multi-cs
> > >>>>> I don't see a good justification for this patch.
> > >>>>>
> > >>>>> What did I miss?  
> > >>>>
> > >>>> As far as I can tell, other than the one existing user of
> > >>>> spi_new_ancillary_device(), other SPI multi-CS stuff is only used
> > >>>> by SPI flash memory devices, not general SPI devices. There code
> > >>>> that is being modified here was introduced to support the SPI
> > >>>> flash memory devices, so that use case is already covered by
> > >>>> existing code.  
> > >>>
> > >>> Right. And obvious question why can't we apply the same approach
> > >>> to any SPI device? Like extending existing code to cover generic
> > >>> cases.  
> > >>
> > >> spi_new_ancillary_device() was already accepted in the kernel as the
> > >> solution for this sort of use case, so isn't it already the generic
> > >> approach?  
> > > 
> > > I don't think the single user functionality is considered generic.
> > >   
> > >> I can see that it could possibly be nice if the SPI core saw that
> > >> there was more than one CS and called spi_new_ancillary_device()
> > >> automatically and somehow passed that along with the main SPI device
> > >> to the driver probe function. But since this is only the second user
> > >> of spi_new_ancillary_device(), I don't think we have enough data
> > >> points to be able to say if this is really what all peripheral drivers
> > >> would want.  
> > > 
> > > Also, if that one designed for the case, why is needed patching?  
> > 
> > Because the multi-CS stuff for SPI flash memory was added later
> > and broke it. There is only one obscure user, so it is not entirely
> > surprising if no one noticed yet.

Sounds to me like fixing multi-CS for SPI (flash mem) to make sure it
works for that case as well is a good idea. Another approach can be to
reconsider both existing ones (pros & cons) and come up with the better
idea and replace them with that.

But fixing an one hack by another hack seems to me not the best strategy.

...

> > > The  mentioned approach predates the SPI memory chip support being
> > > integrated into SPI core. I think we should consider to kill
> > > spi_new_ancillary_device() in favour of using the same mechanism
> > > as being used for SPI mem chips.
> > 
> > I'm not sure the SPI mem work ever actually got finished. In the code, see:
> > 
> > 	if ((of_property_present(nc, "parallel-memories")) &&
> > 	    (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
> > 		dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");
> > 		return -EINVAL;
> > 	}
> > 
> > But there is no SPI controller that has that flag. So I'm not sure if
> > anyone is actually using this yet. And anyway I think the aim there was
> > to be able to assert two CS at the same time, which is not what we are
> > aiming to do here.

Good catch!

Taking what I wrote in the above section, maybe it's the best to remove it
and we go to understand what to do with the spi_new_ancillary_device?

> > And the other potential user of multi-cs is stacked-memories, but this
> > is only mentioned in dt-bindings docs and nowhere else.
> > 
> > There doesn't seem to be any other code besides the validation that is
> > done when the SPI device is added that makes use of more than one CS line.
> > 
> > I would like to agree with you that there should be a better way, but I
> > still don't see an obvious way to do it if there is one (other than the
> > suggestion I already gave that probe should somehow give you two spi
> > devices instead of one).
> 
> I wonder a bit if a single SPI device but with explicit control of which
> CS index in the spi_messages or similar would work?  The disadvantage is you'd
> probably want a lot of helpers to have variants with a selection parameter.
> 
> Would end up smelling like paged registers, just with a chip select to pick
> the page rather than a page register.
> 
> If this isn't common, may not be worth the effort.

At least that's common for I²C EEPROMs.

-- 
With Best Regards,
Andy Shevchenko


