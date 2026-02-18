Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34603090C2;
	Wed, 18 Feb 2026 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441725; cv=none; b=DyRJP34As3C9OdGufC7qD7mK2MgiDsvK5iDMLvV2DKdOFYLQ3KXuXEGRCU/2UjKPe1qYH0w4uThhp5VVNB38q+ql5hh69Jjqk8Bg8AXiJvElZG/zRfXj/uP/RPDRJXA6eRp6fNkA9sjWruR7eyV2JPfLd+G8GqBidE/TeMLOzJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441725; c=relaxed/simple;
	bh=CMQGqura8+TThVVZW/aOy3BN90vZ9BDqk3A9fZh8KNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDKXFxJt9VfC3d5x1f7NTRDgUUOcVztTiBT9X+dL6cOUsc7rwU9SqIGV05fnChFIQ0q3xyb37SoCR+9gza6tlacG8tahCknjqg9t/IgczhusYJeOFZw5LszvhTXtPTJtb5/ZEpkZY1dXwgj7jA1OvEjSA5bMALUTJTIAb7yA2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy5DC0DV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy5DC0DV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8F3C116D0;
	Wed, 18 Feb 2026 19:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771441725;
	bh=CMQGqura8+TThVVZW/aOy3BN90vZ9BDqk3A9fZh8KNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jy5DC0DVGO7Wb9v3jQtRmlgGIeeId0tg5Y3JyCa4J99Ar5mLGmNokFIYgKswGqLQa
	 d2bsqlM4jpN+6rUiey1EnFE0/vmgGtO/YC+mLFBleYitodOhEP8QbYvXeeisXePGrr
	 P6J3TW7uirLGkR/U0BVHWe90//1Sn3XTP9RbYyxB9Ij6rG9mUdiUynZB6BZMGZGU1Y
	 sMLd1jVcIRIwinOptFNdxBDhTaVneQOlkL7oDAE2u/n4U7i3gXM/uj6KHn2Y04fegX
	 GrsDDY9jQ4aILX4oeXBl3nTewwaVo5l/sDt8Klrv0d5qVXS94Ecbt3haPKiXnvo4I3
	 E2mXwkXyNXDoA==
Date: Wed, 18 Feb 2026 19:08:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Mark
 Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260218190834.642caae0@jic23-huawei>
In-Reply-To: <d22c8fa8-1e8b-4f0a-80a1-3f13d75cd52c@baylibre.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
	<aYiGj_TYelvJdVaR@smile.fi.intel.com>
	<20260214160852.6862b58d@jic23-huawei>
	<aZC6wIWDdS8J_1eJ@smile.fi.intel.com>
	<897bd4d4-bbdf-4cbf-84f6-05c110d75d03@baylibre.com>
	<aZF9zoWHL9iHSK3q@smile.fi.intel.com>
	<dce24f01-2a8e-4b36-9685-6ff4293e2d5a@baylibre.com>
	<aZLDyWICGB_j0Z1Y@smile.fi.intel.com>
	<2f9fc7fa-dd55-44f2-9b78-c9902b8b1bbf@baylibre.com>
	<aZQmkm9Xt3PivqmX@smile.fi.intel.com>
	<d22c8fa8-1e8b-4f0a-80a1-3f13d75cd52c@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 16:55:56 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/17/26 2:28 AM, Andy Shevchenko wrote:
> > On Mon, Feb 16, 2026 at 12:53:10PM -0600, David Lechner wrote:  
> >> On 2/16/26 1:14 AM, Andy Shevchenko wrote:  
> >>> On Sun, Feb 15, 2026 at 05:16:47PM -0600, David Lechner wrote:  
> >>>> On 2/15/26 2:03 AM, Andy Shevchenko wrote:  
> >>>>> On Sat, Feb 14, 2026 at 12:31:12PM -0600, David Lechner wrote:  
> >>>>>> On 2/14/26 12:11 PM, Andy Shevchenko wrote:  
> >>>>>>> On Sat, Feb 14, 2026 at 04:08:52PM +0000, Jonathan Cameron wrote:  
> >>>>>>>> On Sun, 8 Feb 2026 14:50:23 +0200
> >>>>>>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> >>>>>>>>> On Fri, Feb 06, 2026 at 06:07:12PM +0200, Antoniu Miclaus wrote:  
> > 
> > ...
> >   
> >>>>>>>>> I believe there is a better approach, what you need is rather a flag
> >>>>>>>>> to SPI core to tell that this is the device with shared CS.  
> >>>>>>>>
> >>>>>>>> Antoniu, this comment from Andy needs addressing before we move
> >>>>>>>> on. It seems fairly fundamental and I'm not seeing a reply to it on list.
> >>>>>>>>
> >>>>>>>> I'm not entirely sure what Andy is suggesting will work but this
> >>>>>>>> is perhaps a mismatch in really understanding what is going on here.
> >>>>>>>> Andy, how would a flag work given they seem to be separately addressable
> >>>>>>>> SPI buses. I think this isn't a shared SPI CS, but rather a device
> >>>>>>>> with two entirely separate SPI buses. I think the only reason
> >>>>>>>> we are bothering to implement it as a single device at all is the
> >>>>>>>> shared backend.  
> >>>>>>>
> >>>>>>> My understanding that there are two devices that for whatever reason share  
> >>>>>>
> >>>>>> It is the opposite. It is a _single_ device with _two_ CS lines.  
> >>>>>
> >>>>> Don't we have already support for that? This changes the picture even more towards
> >>>>> NAKing this. See below why.  
> >>>>
> >>>> Yes, spi_new_ancillary_device() was introduced exactly for this sort
> >>>> of thing, which is why I think it makes sense to use it.
> >>>>  
> >>>>>> adc@0 {
> >>>>>> 	reg = <0>, <1>;
> >>>>>> 	...
> >>>>>> };
> >>>>>>  
> >>>>>>> the same CS line. Yes, I probably misread the idea behind, but I meant
> >>>>>>> some flag for SPI device that tells SPI core that the CS it wants is shared
> >>>>>>> (maybe a high bit in the cs field or so), then CS core won't complain on
> >>>>>>> validation about using the same cs number which is "already in use".  
> >>>>>>
> >>>>>> There was one existing user in the kernel of spi_new_ancillary_device()
> >>>>>> that looked like this, so it seemed the right way to approach it. However,
> >>>>>> code was added later that caused the primary SPI device to "claim" both
> >>>>>> CS lines for itself and probably broke the one existing user of
> >>>>>> spi_new_ancillary_device() (hard to tell without hardware to test).
> >>>>>>
> >>>>>> The idea here was to unbreak that so we could use spi_new_ancillary_device()
> >>>>>> just as in the existing use case.
> >>>>>>
> >>>>>> The patch for that could have been a bit more strict to only allow the
> >>>>>> spi_new_ancillary_device() to take CS 1 and fail otherwise, but users
> >>>>>> are going to notice if it isn't working right anyway, so I didn't ask
> >>>>>> for more checking.  
> >>>>>  
> >>>>>>>> There is an argument that maybe we should be looking at how
> >>>>>>>> to do data muxing backends to support the more general case of two
> >>>>>>>> separate chips feeding into a single buffer, but that's a complex
> >>>>>>>> beast and I'm not sure if it is something we actually need.  
> >>>>>>
> >>>>>> I think it would actually be quite similar to what is done in this
> >>>>>> series.  
> >>>>>
> >>>>> TBH, the change sounds to me like a hack. It doesn't cover other potential ways
> >>>>> of the multi-cs devices come into play. Given that SPI core supports multi-cs
> >>>>> I don't see a good justification for this patch.
> >>>>>
> >>>>> What did I miss?  
> >>>>
> >>>> As far as I can tell, other than the one existing user of
> >>>> spi_new_ancillary_device(), other SPI multi-CS stuff is only used
> >>>> by SPI flash memory devices, not general SPI devices. There code
> >>>> that is being modified here was introduced to support the SPI
> >>>> flash memory devices, so that use case is already covered by
> >>>> existing code.  
> >>>
> >>> Right. And obvious question why can't we apply the same approach
> >>> to any SPI device? Like extending existing code to cover generic
> >>> cases.  
> >>
> >> spi_new_ancillary_device() was already accepted in the kernel as the
> >> solution for this sort of use case, so isn't it already the generic
> >> approach?  
> > 
> > I don't think the single user functionality is considered generic.
> >   
> >> I can see that it could possibly be nice if the SPI core saw that
> >> there was more than one CS and called spi_new_ancillary_device()
> >> automatically and somehow passed that along with the main SPI device
> >> to the driver probe function. But since this is only the second user
> >> of spi_new_ancillary_device(), I don't think we have enough data
> >> points to be able to say if this is really what all peripheral drivers
> >> would want.  
> > 
> > Also, if that one designed for the case, why is needed patching?  
> 
> Because the multi-CS stuff for SPI flash memory was added later
> and broke it. There is only one obscure user, so it is not entirely
> surprising if no one noticed yet.
> 
> > 
> > ...
> > 
> > The  mentioned approach predates the SPI memory chip support being
> > integrated into SPI core. I think we should consider to kill
> > spi_new_ancillary_device() in favour of using the same mechanism
> > as being used for SPI mem chips.
> >   
> 
> I'm not sure the SPI mem work ever actually got finished. In the code, see:
> 
> 	if ((of_property_present(nc, "parallel-memories")) &&
> 	    (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
> 		dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");
> 		return -EINVAL;
> 	}
> 
> But there is no SPI controller that has that flag. So I'm not sure if
> anyone is actually using this yet. And anyway I think the aim there was
> to be able to assert two CS at the same time, which is not what we are
> aiming to do here.
> 
> And the other potential user of multi-cs is stacked-memories, but this
> is only mentioned in dt-bindings docs and nowhere else.
> 
> There doesn't seem to be any other code besides the validation that is
> done when the SPI device is added that makes use of more than one CS line.
> 
> I would like to agree with you that there should be a better way, but I
> still don't see an obvious way to do it if there is one (other than the
> suggestion I already gave that probe should somehow give you two spi
> devices instead of one).
> 

I wonder a bit if a single SPI device but with explicit control of which
CS index in the spi_messages or similar would work?  The disadvantage is you'd
probably want a lot of helpers to have variants with a selection parameter.

Would end up smelling like paged registers, just with a chip select to pick
the page rather than a page register.

If this isn't common, may not be worth the effort.

Jonathan

> 
> 

