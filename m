Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569326ED33
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099126; cv=none; b=J22sV8FleE/5uUJL7dAZS7djPf5ULL4+zQg6r5wIJg3Bh1rUHW75rdyOtku2w4S4So0a5Iokn40nDP3zuTogZDpwBm9IiGvRKO5YCqKpTudRMGROTiyK6EDJUOZil8Afm6pkzwi4SRb3SLGe6XkscD6bJ1m6ORfxBj2vekdiauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099126; c=relaxed/simple;
	bh=eIggaG2N2f3wRCFefm0wikse4eo8hITiDcLQJmaNhXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXJCSh1fUxKYdLUjZIfj03Sk68nKD1xXo7QbjMpECMFBv4bVfa/03gMQHaSNKMwgBRHvz9YFHexDuuQRPrxAVKWtKZBBDEy4KutkIovXJZsjymQRkj9OiBTkcHBYd88whdg83vULd3G34kXzb3MXa4//WRM3BRa8MQNGv3HHsjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csp+zWXM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csp+zWXM"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caced6038eso8670125ad.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783099124; x=1783703924; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nN+A2NTh4/3eIcKa2Wt9oXaZKo3m4HxZR1ljIVJsVsI=;
        b=csp+zWXMQdlzZQSQ217bcJtRxTSGkym5oRGlVSV4wD/ldNEMskKT0/l4BYapm0ixBv
         q3ltsuCe/GQo/bQJmNuTttY9MhK8M3btIefdQr7LBu/JTi1Rc9pUKB1Mt2cCsuGIWH1H
         ZOVcc12AnCE+/cVbzoas/4yviHnLbA7VhjWnRsROr4/QD3lJBrYQehrDCpHIPEUBqZZA
         QWOQ51tEKmtm1UylSBeOAgPSUnj6tw3pI7/rTH/FOkDT6X97naGhLcUm3bFqycZ4a/Xk
         Z5bpyZ+m3fQ2A2HEDEsgPbk7VIV8KHLE90JJm2a7HbcYRMVleP09F6muPbsRM18fl2OM
         tlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783099124; x=1783703924;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nN+A2NTh4/3eIcKa2Wt9oXaZKo3m4HxZR1ljIVJsVsI=;
        b=nJjMvii3hukCm2wdc9+9rICTrMehhn6kZyWdbBsYTy0adIuePfozp2JAcvmgcF95vJ
         UKS2mDgJ5CyKmwdrNW7TaUDbbP+SbMMmpXFMcP6ljEDcKP8lFomXuEROqTI3XleOM/ev
         uHZYcCKjiqDxRUco/RT7nKZiYHpxijbpEeFhDWrbe36HcGTAC4i7WnolTxs+D+71mi/B
         +HrvPFnpmux0tlPdWCS0hYfCYsMQCti30CZzbgEnrvjTPMiLtCh8W5U+bbJ+RxzzXsRV
         4VhvTTrXQOw3b4e1pqxeOAIPurPg88cQfbEARc40bH3twfcBJi0td4n1Yg51y91Jix9z
         ek7w==
X-Forwarded-Encrypted: i=1; AHgh+RqDurP1G49bfsmDSbbxFNV/y2F09lt1GwlBL7bKIT6Zsjbw88uLJ0n4sr32zwvYEW/b3l1SzAgFQyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xNuY/p+lZsSBVAqh/W+q0MpKStBVNPSdbTmWw81dq/cSPlZ/
	0cw5KkOcQJkgf0wZT8NAw+25WFGdDuOhBSwCUvZviFnfaugAWzVZqMTE
X-Gm-Gg: AfdE7cmp2cd8oYRGlAZjWBDH6j5iatxydukrV+7kLIZgodsCLknpGdqp7IwvGbz34Bl
	mY5MxrPNo1vdfzXMw4t4luJ3gkfYdOEsJlKrBElPv40YyKWLED5fPeJN5idz0b5Jmhl/6ltgcTf
	xEEZWWPmquG449ZudJ9iH7nQ28cuM7LWQhAP5x6HgyQ352GK2IAFhpRk4PCBJ0hmtpDYd3nzL8g
	OY1pFfH6dOSXO57ZvMl+3HY1iZQc6cAuX6RpwDQEzLWU4FN9pLocCE54oDTfBU2Kw4xksMzuVzv
	H2DDSZFcS4w/9VrQguMj5o2Qdz7d8dehlJlSTu7TVJy8qru0jB3jHI89twPa3fBmBVYDF4U65F8
	TW87Wk4Tr61elVPHKoWqIeaPqpL38O2tk6fzA8X3hnlPAM9hf7m7zyBDQ9jTR4GPpG+EDu3r7x4
	OZqPDMJMXANysoXLPxuxjg7XlEj8A1d0HK
X-Received: by 2002:a17:902:ce87:b0:2ca:9a9f:bb10 with SMTP id d9443c01a7336-2cacb196b1emr45488715ad.22.1783099124211;
        Fri, 03 Jul 2026 10:18:44 -0700 (PDT)
Received: from localhost ([2804:30c:1618:8400:e838:86ad:21d4:de00])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7ef188sm21275916c88.2.2026.07.03.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 10:18:43 -0700 (PDT)
Date: Fri, 3 Jul 2026 14:19:32 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, robh@kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v5 3/4] iio: adc: ltc2378: Enable high-speed data capture
Message-ID: <akfvJOikt3ukJJWN@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1783028033.git.marcelo.schmitt@analog.com>
 <e285c16edf2e5483effad96a852a2ae110a27899.1783028033.git.marcelo.schmitt@analog.com>
 <20260702220726.718A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702220726.718A21F000E9@smtp.kernel.org>

On 07/02, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential issue(s) to consider:
> - [Critical] Access to non-existent `offset_ns` field in `struct spi_offload_trigger_periodic` causes a build failure.
> - [Critical] The macro `HZ_PER_GHZ` is used but never defined anywhere in the kernel, causing a build failure.
> - [High] Mismatch between SPI offload transfer length and IIO channel storage bits for 16-bit devices causes buffer data corruption.
> - [High] Unassigned `length` pointer in `ltc2378_read_avail` API callback leaves caller variable uninitialized.
> - [High] Unpredictable phase shift between two independent PWM channels risks hardware data corruption.
> - [High] Forcing unsupported `bits_per_word` breaks single-shot reads on standard SPI controllers.
> - [Medium] `st->offload_trigger_config` is updated in-place and not rolled back on validation failure, corrupting driver state.
> --
> 
> commit 7c29c089819a4620f86fae01e267747bb7a266ff
> Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> iio: adc: ltc2378: Enable high-speed data capture
> 
> Make use of SPI transfer offloading to speed up data capture, enabling data
> acquisition at faster sample rates (up to 2 MSPS).
> 
> > diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> > index b5cf2e974daca..b25602d91bbe1 100644
> > --- a/drivers/iio/adc/ltc2378.c
> > +++ b/drivers/iio/adc/ltc2378.c
> [ ... ]
> > @@ -46,10 +58,19 @@
> >  #define LTC2378_UNIPOLAR_DIFF_CHANNEL(_real_bits)				\
> >  	LTC2378_DIFF_CHANNEL(0, _real_bits, (((_real_bits) > 16) ? 32 : 16), 0)
> >  
> > +#define LTC2378_OFFLOAD_BIPOLAR_DIFF_CHANNEL(_real_bits)			\
> > +	LTC2378_DIFF_CHANNEL(1, (_real_bits), 32, 1)
> > +
> > +#define LTC2378_OFFLOAD_UNIPOLAR_DIFF_CHANNEL(_real_bits)			\
> > +	LTC2378_DIFF_CHANNEL(0, (_real_bits), 32, 1)
> > +
> 
> [Severity: High]
> Does hardcoding the storagebits to 32 here mismatch with the SPI transfer
> length for 16-bit devices?
> 
> When ltc2378_prepare_offload_message() configures the transfer, it sets the
> length to spi_bpw_to_bytes(16), which is 2 bytes. Since the IIO subsystem
> expects 4 bytes per sample based on these channel definitions, could this
> cause buffer reads to be misaligned and return garbage data to userspace?
The available HDL only supports pushing 32-bit data elements to DMA buffers in
CPU endianness. For 16-bit precision parts, 32-bit elements (in CPU endianness)
containing the 16-bit data are pushed to DMA. For the offload use case, the IIO
buffer is configured for 32 storage bits in CPU endianness so data is correctly
aligned in user space (despite 2 out of the 4 bytes being always zeroed). I'll
add a comment with the above explanation.

> 
> [ ... ]
> > @@ -254,7 +344,136 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
> >  			*val2 = chan->scan_type.realbits;
> >  
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		*val = st->cnv_Hz;
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int ltc2378_read_avail(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      const int **vals, int *type, int *length, long mask)
> > +{
> > +	struct ltc2378_state *st = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		*vals = st->sample_freq_range;
> > +		*type = IIO_VAL_INT;
> > +		return IIO_AVAIL_RANGE;
> 
> [Severity: High]
> Should this callback also initialize the length pointer?
No.

> 
> Since this returns IIO_AVAIL_RANGE successfully but doesn't assign *length,
> callers like iio_read_channel_info_avail() in the core might use an
> uninitialized stack variable for the array size. Could this lead to
> out-of-bounds array reads?
> 
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> [ ... ]
> > +static int ltc2378_update_conversion_rate(struct ltc2378_state *st, int freq_Hz)
> > +{
> [ ... ]
> > +	/*
> > +	 * Configure SPI offload PWM trigger.
> > +	 * The trigger should fire after tBUSYLH + tCONV + tDSDOBUSYL.
> > +	 * Minimum time needed: TBUSYLH (13ns) + TCONV (part-specific) + TDSDOBUSYL (5ns)
> > +	 *
> > +	 * Use the same period as CNV PWM to avoid timing issues.
> > +	 * Convert back from period to frequency for the SPI offload API.
> > +	 */
> > +	offload_period_ns = cnv_wf.period_length_ns;
> > +	config->periodic.frequency_hz = DIV_ROUND_UP(HZ_PER_GHZ, offload_period_ns);
> 
> [Severity: Critical]
> Is HZ_PER_GHZ defined anywhere in the kernel?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/units.h?h=v7.2-rc1#n50

> 
> Looking through the tree and include/linux/units.h, this macro doesn't appear
> to exist. Won't this cause an unconditional build failure?
> 
> > +	min_read_offset = LTC2378_TBUSYLH_NS + st->info->tconv_ns + LTC2378_TDSDOBUSYL_NS;
> > +	offload_offset_ns = min_read_offset;
> > +	count = 100;
> > +	do {
> > +		config->periodic.offset_ns = offload_offset_ns;
> 
> [Severity: Critical]
> Does struct spi_offload_trigger_periodic actually have an offset_ns field?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/spi/offload/types.h?h=v7.2-rc1#n70

> 
> According to include/linux/spi/offload/types.h, struct
> spi_offload_trigger_periodic only contains the frequency_hz field. This seems
> like it will cause a build error.
> 
> > +		ret = spi_offload_trigger_validate(st->offload_trigger, config);
> > +		if (ret)
> > +			return ret;
> 
> [Severity: Medium]
> If validation fails here, does the in-place modification of the shared config
> struct get rolled back?
> 
> Since config points directly to st->offload_trigger_config, returning early
> leaves the device state with rejected values. If the IIO buffer is later
> enabled, could the driver use these invalid config values to start the
> offload trigger?
Makes no difference. The PWM configurations are recalculated and re-validated
every time the buffer is enabled. There's very little to no benefit in rolling
back PWM configurations.

> 
> > +		offload_offset_ns += 10;
> > +	} while (count-- && config->periodic.offset_ns < min_read_offset);
> [ ... ]
> > +static int ltc2378_offload_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ltc2378_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = pwm_set_waveform_might_sleep(st->cnv_trigger, &st->cnv_wf, true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> > +					 &st->offload_trigger_config);
> 
> [Severity: High]
> Does starting these two clock sources sequentially result in an unpredictable
> phase shift?
> 
> Since st->cnv_trigger and st->offload_trigger are independent and enabled one
> after the other in software, CPU execution delays might cause an uncontrolled
> phase alignment. The LTC2378 datasheet forbids SCLK toggling during the
> conversion phase. Could this random phase shift cause SPI transactions to
> overlap with the conversion window and corrupt the sampled data?
That's what the offset_ns field is for.

> 
> > +	if (ret)
> > +		goto out_pwm_disable;
> > +
> > +	return 0;
> [ ... ]
> > @@ -330,8 +653,53 @@ static int ltc2378_probe(struct spi_device *spi)
> [ ... ]
> > +		/*
> > +		 * Set single-read transfer bits_per_word so the SPI subsystem
> > +		 * rearanges data to CPU endianness, enabling us to reuse
> > +		 * offload_chan specifications for single-shot reads.
> > +		 */
> > +		st->xfer.bits_per_word = st->info->offload_chan.scan_type.realbits;
> 
> [Severity: High]
> Is it safe to force this bits_per_word on the shared transfer struct used for
> regular single-shot reads?
> 
> Most generic SPI host controllers only natively support standard word widths
> (like 8, 16, 32). If bits_per_word is set to an arbitrary resolution like 18,
> won't the SPI core's __spi_validate reject the transfer with -EINVAL and break
> sysfs single-shot reads?
Correct, offload support assumes a controller capable of supporting fine grained
number of bits_per_word.

> 
> > +	}
> >  
> >  	st->xfer.rx_buf = &st->scan.data;
> >  	st->xfer.len = spi_bpw_to_bytes(indio_dev->channels[0].scan_type.realbits);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1783028033.git.marcelo.schmitt@analog.com?part=3
