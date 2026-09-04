Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF73AA4F2;
	Fri,  4 Sep 2026 03:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491504; cv=none; b=Kh6o97GpLPjS6l6PnIIETodL2OZ2zm1bWVrwoNXQSTslrrravqVYxOi18On5KQnb8lR/yk9srVduOHq6wONo/NzjXhX8lliMsqd6LbglKQAFyn70WjvoyRDvjN8l5uJQ1LjOfYme9GTUiQ36b1sebP19flClsleoAv49iDvVXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491504; c=relaxed/simple;
	bh=uI2HN50P2gwLvtst8jnYDBGu7J6atvzxrce3IcsLdGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSYboWiSgozqligIQbr3SfyjAbiKX2qW6GBtdxbPHxAkpRcNlmbcSXMlauOkFNpGHb4q5A2Pe9QHKW+Wuau0Tm/8wivGcXXPoouFHrnB3rpx9Ba1vLh36HINAEFRzENeXXW+ESVXgug9V1vvZ0VF2mf2nFXUYFHSaGybwVQBUx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2IN/k7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2IN/k7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754B81F00A3D;
	Fri,  4 Sep 2026 03:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788491502;
	bh=vXiAqzsuOBHpQpc13OvIWy9Ysj65FxIE++L7D7toTGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b2IN/k7sZl6KXEPA8MkUVnfW2ZWo6yZO3SY8GdxXLyz65/OoYPzqFPVffrIqGeev8
	 2egJNdaBvyqn0JlKG4MQebp7H78Ey7YZlIZOcTuekh3EJIdHOGQpknkIBx4QqikOx0
	 RBn6QpopZ/oEiN2aBv6vAgVaoEqtk7zF3CINc9wNZ4uPpFCQjR7vJuJmd/fxE/31Gq
	 yd3HETf4JGt7R6/JIpzwJekfjtHRU5ez+AiaSS3Mk3U0ndkI4Ig6GMtgQzIPWS0z2F
	 EStBWpvVxlI/CRqSAicd2UOWHhSzvzAS5Bnf1sR92U2Ldr97cKukpoJti5/Vh1ZKo7
	 ul4wSgmpCCT5A==
Date: Fri, 4 Sep 2026 04:11:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] iio: adc: rzt2h: implement DMA buffer support
Message-ID: <20260904041138.77b6f76f@jic23-huawei>
In-Reply-To: <TYRPR01MB15619584AE0D8737B439D317185B62@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
	<20260828145943.2077589-6-cosmin-gabriel.tanislav.xa@renesas.com>
	<178796644341.2599003.10846523729399514118.b4-review@b4>
	<TYRPR01MB15619584AE0D8737B439D317185B62@TYRPR01MB15619.jpnprd01.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 07:49:29 +0000
Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com> wrote:

> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, August 29, 2026 4:21 AM
> >   
> > > Implement buffered capture using a cyclic DMA transfer into a kfifo
> > > buffer to support continuous high-rate sampling.
> > >
> > > On buffer enable, switch the ADC to continuous conversion mode and start
> > > a cyclic DMA transfer over the active channels.
> > >
> > > Because the DMA controller does not support native scatter-gather, and
> > > because of the cyclic DMA setup, transfers must be done in widths
> > > covering all the enabled channels.
> > >
> > > Since DMA transfer width must be a power of two and aligned to its size,
> > > cover the smallest power-of-two-aligned group of channel registers
> > > spanning the enabled channels.
> > >
> > > Split the cyclic buffer into fixed-size periods. On each period
> > > completion, bump a pending counter and wake a consumer kthread from the
> > > DMA callback.
> > >
> > > For every completed period, gather the enabled channels out of the DMA
> > > layout into the scan layout the IIO core expects and push each scan
> > > with iio_push_to_buffers().  
> > 
> > Could you instead use the available_scan_masks infrastructure.  bit annoying
> > to specify the full list but isn't that long I think with 16 channels
> > 
> > 16 x single
> > 8 x double,
> > 4 x quads
> > 2 x octect
> > 1 x all of them.
> > 
> > The the IIO demux in (sits behind the push_to_buffers path if
> > we have available_scan_masks set) will then deal with repacking
> > the data if necessary.
> >   
> 
> Hi Jonathan.
> 
> There are a couple reasons why I haven't used available_scan_masks.
> 
> Our limitation is on the DMA side. It cannot do scatter-gather in a
> single descriptor, and we need to copy all the channels for each
> completion IRQ. This is why we have to copy all the enabled channels
> in a single block, and the base address needs to have the same
> alignment as the block size.
> 
> My initial naive implementation copied all 16 channels (32 bytes) all
> the time, but at that size the DMAC quickly hits a wall where it doesn't
> service the ADC's completion signals anymore, at ~220k requests per
> second.
> 
> Optimizing the DMA window allows us to avoid losing samples when the
> enabled channels are densely packed. Enabling only channel 0 and 15
> still hits the DMAC performance wall though, for example.
> 
> If we were to use available_scan_masks, the ADC would have to enable the
> extra channels too, since it would have no knowledge of whether a
> channel is enabled legitimately or for alignment purposes. The ADC scans
> each channel iteratively, not in parallel, so sampling rate would be
> affected because of the extra enabled channels. Besides that, this would
> be transparent to the user, but it would reuse the last set sampling
> frequency values, which affect the sampling rate without the user even
> knowing.

Ok.  So if this was a common thing I'd suggest we might expose an extra
mask that presents what the various consumers have requested, but I'd
not go to that effort for the first driver that could use it.

> 
> If there are any extra enabled channels, iio_demux() would have to copy
> all the data again. We need to keep our own copy inside the driver to
> unswap the ADC's 16-bit data registers out of each 32-bit word.

Ah. Yes, with a copy already happening might as well make it just one.

> 
> The available_scan_masks table would have to be computed at runtime
> since not all instances of the ADC have 16 channels.

Given these are fairly small, that might just be selection from a set
of options.

> Also the use of
> devm_iio_adc_device_alloc_chaninfo_se() means that we allow gaps in the
> channels themselves. scan_index is set incrementally anyway, so it can
> get out of sync with the channel index, and that would need extra
> handling when building the table.

Ah. That would make life trickier.

> 
> Let me know what you think and what the direction should be.

This info is more than enough to convince me that it isn't worth
using the core demux stuff. Thanks for all the details!

Jonathan
