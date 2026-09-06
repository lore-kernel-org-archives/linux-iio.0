Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DEC265621;
	Sun,  6 Sep 2026 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788663924; cv=none; b=Fu3sGMFt8wfS+o8TftRPyqADV5r2dtCK01s3FqJmxs7a/5+wcBjT9A3BOuAQWf9WG07fd47KHE9cT1whETjQkyflORytL5ACBmXHKl2jyJDOZEnIsnNyrM9XTGLJL8VnRY3cOsaXeWE278oEZ2/kktiPc0zsmQ2ox6GMuGKfPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788663924; c=relaxed/simple;
	bh=7LKsv/yJ6FNyRTgzSs+fQaPMN/6WjEc+W+5gzGYoG4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TipPxCQ4VEw9xDKpmbkXOlQ308LL7yRWpMzQAlGFcS0j9rhDCvawmlfxm3YVu8WroZErHZozUduFS6JjpaC9d7ZPnuewz1hdLC72KE700uCpgR7GXozQC/tgSMOByqsu5NnEaVJMKuy9lLGTuauJ6bdpUbHNdQMV5VENsGqqEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZeGr2x6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZeGr2x6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D4D1F00A3A;
	Sun,  6 Sep 2026 03:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788663922;
	bh=Pq/QmHwYpyCK9tLpA/lDOF7sWaJPzFEZI88MnDXvqQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aZeGr2x60kpLYJU0Us5p2Ou/lNAAbMsDecmXc3mdFNvWp7PgaEECBHNLWstTFMolJ
	 d0Jp9EZpPiuNt03KUnydkvUisWlDKlG8Yz9kzt5eeRjASOjWOoIinxkHg6sI9nwg3m
	 I5C3kN4lz58uHjnsadz6I7hIZqhxQT9jAH/4uN/RMrVNbyVommumppC+z0osx/CakE
	 FbW5GnvX+QjwwsokexDtMYvR3qVvJtMm8Cjjr3xVIYmIsy44ZlK4pMDFFvVUMFsgUK
	 ZoUcR6tXmBMnouJ3IvpNGYHU/hFfaX7Eku2vrmc9v41RP8+j1Sspf0ZrArvAWsm7kb
	 kJPKjRnZwVINQ==
Date: Sun, 6 Sep 2026 04:05:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Janani Sunil <janani.sunil@analog.com>, conor+dt@kernel.org,
 robh@kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 05/17] iio: adc: Add AD7768 and AD7768-4 core support
Message-ID: <20260906040517.480347b2@jic23-huawei>
In-Reply-To: <178866149408.3402141.12120124355772738970.b4-reply@b4>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
	<20260904-ad7768-driver-v6-5-e4378f946bfb@analog.com>
	<20260904143153.9AF1A1F00A3E@smtp.kernel.org>
	<178866149408.3402141.12120124355772738970.b4-reply@b4>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 06 Sep 2026 03:24:54 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> > 
> > commit cad3d6d13491f167da3c31d541a31ac850d8d3b5
> > Author: Janani Sunil <janani.sunil@analog.com>
> > 
> > iio: adc: Add AD7768 and AD7768-4 core support
> >     
> > Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
> > Configure supplies, clock and reset, use a custom regmap bus for the SPI
> > protocol, and parse the enabled channels and input buffer settings from
> > devicetree.  
> 
> There was quite a bit of sashiko feedback on this one. I took a look
> as getting close to merging the series. Please check my logic.

oops. I replied to this but the sashiko email only ever went to the
device tree list not all the other places the original thread went.

Added linux-iio and a few others.
> 
> >   
> > > diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
> > > new file mode 100644
> > > index 0000000000000..c80056a9edd8c
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/ad7768.c
> > > @@ -0,0 +1,1000 @@
> > > +// SPDX-License-Identifier: GPL-2.0  
> > 
> > [ ... ]
> >   
> > > +#define AD7768_REG_PRECHARGE_BUF1			0x11
> > > +#define AD7768_REG_PRECHARGE_BUF2			0x12
> > > +#define   AD7768_PREBUF_POS_EN(ch)			BIT((ch) * 2)
> > > +#define   AD7768_PREBUF_NEG_EN(ch)			BIT(((ch) * 2) + 1)  
> > 
> > [Severity: Medium]
> > Are these bit assignments for the precharge buffers swapped? According to the
> > AD7768 datasheet, the positive (POS) precharge buffers are assigned to odd bits,
> > and the negative (NEG) precharge buffers are assigned to even bits.  
> 
> No they aren't. I think sashiko didn't realize table starts at bit 7
> and works down to bit 0.
> 
> >   
> > > +
> > > +#define AD7768_REG_REFP_BUF				0x13
> > > +#define AD7768_REG_REFN_BUF				0x14  
> > 
> > [ ... ]
> >   
> > > +static u8 ad7768_all_standby_mask(const struct ad7768_state *st)
> > > +{
> > > +	return GENMASK(st->chip_info->num_channels - 1, 0);
> > > +}  
> > 
> > [Severity: High]
> > Does this generate the correct physical mask for the AD7768-4? The AD7768-4
> > maps its 4 logical channels to physical channels 0, 1, 4, and 5. This returns
> > GENMASK(3, 0) which is 0x0F, writing 0 to physical bits 4, 5, 6, and 7,
> > leaving them fully active.
> > 
> > [ ... ]  
> 
> This one looks plausible.  There is handling of the bits written to
> deal with the mapping but not the mask I think. Please take a look.
> 
> >   
> > > +static int ad7768_regmap_read(void *context, const void *reg_buf,
> > > +			      size_t reg_size, void *val_buf, size_t val_size)
> > > +{
> > > +	struct ad7768_state *st = spi_get_drvdata(context);
> > > +	struct spi_device *spi = context;
> > > +	struct spi_transfer t[] = {
> > > +		{
> > > +			.tx_buf = &st->d16,
> > > +			.len = sizeof(st->d16),
> > > +			.cs_change = 1,
> > > +		}, {
> > > +			/*
> > > +			 * Register responses are delayed by one CS frame. While
> > > +			 * receiving the response to this read, the device also
> > > +			 * decodes another command on SDI. Repeat the read
> > > +			 * command to avoid sending an unspecified dummy
> > > +			 * command.
> > > +			 */
> > > +			.tx_buf = &st->d16,
> > > +			.rx_buf = &st->d16,
> > > +			.len = sizeof(st->d16),
> > > +		},
> > > +	};  
> > 
> > [Severity: High]
> > Can this violate the DMA API? Both transfers use the same memory address
> > (&st->d16) for their buffers. When the SPI subsystem maps all transfers for
> > DMA concurrently, attempting to map the same memory region twice concurrently
> > (DMA_TO_DEVICE and DMA_BIDIRECTIONAL) can cause cache coherency issues on
> > non-coherent architectures.  
> 
> So this one I'm fairly sure on, but feel free to check.
> 
> There is nothing stopping SPI using one buffer for both directions. If it's a
> problem for a particular setup I think they have to bounce it.
> 
> > 
> > [ ... ]
> >   
> > > +static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
> > > +				   const unsigned long *scan_mask)
> > > +{
> > > +	struct ad7768_state *st = iio_priv(indio_dev);
> > > +	unsigned long channel_mask;
> > > +	unsigned long standby_mask;
> > > +	int ret;
> > > +
> > > +	channel_mask = ad7768_all_standby_mask(st);
> > > +	standby_mask = channel_mask & ~*scan_mask;
> > > +
> > > +	/*
> > > +	 * Crystal excitation requires channel 4 on AD7768 or channel 2 on
> > > +	 * AD7768-4 to remain active.
> > > +	 */
> > > +	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
> > > +		__clear_bit(st->chip_info->num_channels / 2, &standby_mask);
> > > +
> > > +	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
> > > +				 channel_mask, standby_mask);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	for (unsigned int c = 0; c < st->chip_info->num_channels; c++) {
> > > +		if (test_bit(c, scan_mask))
> > > +			ret = iio_backend_chan_enable(st->back, c);
> > > +		else
> > > +			ret = iio_backend_chan_disable(st->back, c);
> > > +		if (ret)
> > > +			return ret;
> > > +	}  
> > 
> > [Severity: Medium]
> > Will this leave the backend hardware out of sync if an error occurs? If one
> > operation fails, it returns the error immediately without unwinding the
> > previously modified channels.  
> 
> This is one of those error cases where unwinding may just be impractical.
> Real question is whether there is anything that means trying again won't
> end up in a sane state or that anything particularly bad will happen
> as a result of the bad state in the meantime. I think this is fine
> but please check.
> 
> >   
> > > +
> > > +	return 0;
> > > +}  
> > 
> > [ ... ]
> >   
> > > +static int ad7768_buffer_postdisable(struct iio_dev *indio_dev)
> > > +{
> > > +	struct ad7768_state *st = iio_priv(indio_dev);
> > > +
> > > +	pm_runtime_put_autosuspend(regmap_get_device(st->regmap));
> > > +	return 0;
> > > +}  
> > 
> > [Severity: Medium]
> > Could this leave the hardware powered on after device removal?
> > 
> > If the driver is unbound while the IIO buffer is active,
> > devm_iio_device_register unwinds first, calling iio_device_unregister(),
> > which disables the buffer and triggers ad7768_buffer_postdisable().
> > 
> > Immediately after, devm_pm_runtime_set_active_enabled unwinds, calling
> > pm_runtime_disable() which cancels the pending autosuspend work. The
> > driver should ensure synchronous suspend if the buffer is active during
> > removal.  
> 
> Ah.  Interesting corner case.  There are probably lots of other
> paths to the power happening to be on at shut down but I can see
> maybe we ultimately want a flag to say we are going down in that
> buffer disable path.  Anyhow, you should be careful to ensure it
> doesn't matter what state we are in wrt to runtime pm, after we've
> turned that off we should make sure we turn off the device by hand.
> Afterall maybe runtime pm was never enabled in the first place
> (or even built!)
> 
> > 
> > [ ... ]
> >   
> > > +static int ad7768_configure_precharge_buffers(struct iio_dev *indio_dev,
> > > +					      struct ad7768_precharge_config *precharge_cfg)
> > > +{
> > > +	struct ad7768_state *st = iio_priv(indio_dev);
> > > +	u8 prebuf1_val, prebuf2_val;
> > > +	u16 prebuf_mask = 0;
> > > +	u8 refbufp_val = 0;
> > > +	u8 refbufn_val = 0;
> > > +	int ret;
> > > +
> > > +	for (unsigned int ch = 0; ch < indio_dev->num_channels; ch++) {
> > > +		u8 channel = indio_dev->channels[ch].channel;
> > > +
> > > +		if (precharge_cfg[channel].prebufp_en)
> > > +			prebuf_mask |= AD7768_PREBUF_POS_EN(channel);
> > > +
> > > +		if (precharge_cfg[channel].prebufn_en)
> > > +			prebuf_mask |= AD7768_PREBUF_NEG_EN(channel);
> > > +
> > > +		if (precharge_cfg[channel].refbufp)
> > > +			refbufp_val |= ad7768_channel_mask(st, channel);
> > > +
> > > +		if (precharge_cfg[channel].refbufn)
> > > +			refbufn_val |= ad7768_channel_mask(st, channel);
> > > +	}  
> > 
> > [Severity: Medium]
> > Does this apply the incorrect polarity for the reference buffer configuration?
> > When adi,refbuf-pos-enable or adi,refbuf-neg-enable are provided in the device
> > tree, the driver sets the corresponding bit to 1. According to the AD7768
> > datasheet, setting a bit to 1 in the REFP_BUF and REFN_BUF registers powers down
> > the buffer.  
> 
> I'm not sure what datasheet sashiko has.  Mine says 1 is power up.
> I'm going to guess it's assuming layout of values that aren't true.
> 
> > 
> > [ ... ]
> >   
> > > +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> > > +		u32 channel;
> > > +
> > > +		ret = fwnode_property_read_u32(child, "reg", &channel);
> > > +		if (ret)
> > > +			return dev_err_probe(dev, ret,
> > > +					     "Failed to parse reg of %pfwP\n",
> > > +					     child);
> > > +
> > > +		if (channel >= st->chip_info->num_channels)
> > > +			return dev_err_probe(dev, -ECHRNG,
> > > +					     "Invalid channel %u in firmware\n",
> > > +					     channel);
> > > +
> > > +		ret = regmap_clear_bits(st->regmap, AD7768_REG_CH_STANDBY,
> > > +					BIT(channel));  
> > 
> > [Severity: High]
> > Does this use logical indices instead of physical bits for the AD7768-4? The
> > AD7768-4 uses physical channels 0, 1, 4, and 5. Using BIT(channel) will update
> > physical bits 0-3 instead of the mapped hardware bits.  
> 
> This seems plausible. Please check.
> 
> >   
> > > +		if (ret)
> > > +			return ret;
> > > +  
> > 
> > [ ... ]
> >   
> > > +	pm_runtime_set_autosuspend_delay(dev, 2000);
> > > +	pm_runtime_use_autosuspend(dev);
> > > +	ret = devm_pm_runtime_set_active_enabled(dev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return devm_iio_device_register(dev, indio_dev);
> > > +}  
> > 
> > [Severity: Medium]
> > Does this leave the device permanently active? This configures autosuspend and
> > enables runtime PM, which transitions the device to RPM_ACTIVE with a usage
> > count of 0, but fails to call pm_request_idle(dev). As a result, the autosuspend
> > timer is never triggered, leaving the device fully powered indefinitely until
> > a user explicitly accesses it.  
> Nope.  This is usual thing of sashiko failing to notice the stuff
> in base/dd.c that always checks if the reference count is 0 and hence
> it can put it to sleep. This happens just after probe.
> 
> So a definite mixed bag for sashiko on this one.
> 
> Jonathan
> 
> 

