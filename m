Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACEF2E7386
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794432; cv=none; b=D+IXv8GAZhYE4aSW3pFVPd1GuX6LALnmjGKRHltxkgak9/PU8IW07EIqP5wkPJJEtZsANm4duDNbs8SCJUPwFV3HX4kBy57rFicriw8cuYVgV4zTJXbqCb+AwkwdGOeWAHC4xST+VhdH+TxiW5xzH+2EHgi61AGY5heiU9lnxcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794432; c=relaxed/simple;
	bh=x6WErO05GloTcY3drBZGxcVJL7VcsdKdrB/cSRzyU0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZ92piDnOtyy1P7n2kqgpjqjBxklDSQg2YGqsXBrZ09FKWIKmk381CzSWEU24ICzIFiFCans8+YGA3oB5uV6HzpuwvFhz2fxIfuhGkysh9MwQa500yzFJFTT5U1HHIQJfoavz5idZfo8/sc1Dd1v3+KjSG0utMFlXjpEJACVUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He3bqDzy; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He3bqDzy"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-982db8d3b79so1562398241.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790794430; x=1791399230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r5lP6B15UeibEwnmcWBmYogILctd0FL89sC0OmMFnzw=;
        b=He3bqDzyIaliNcTSU+o8FaH4opG7xOIZpgV3qFIPCRgqM4IRU3aPSLaPxzjn+E2lVS
         WQCKcUd827U2fCCReISkR/C0IFcK0zxVyL2TS6TJBZG4voKZSNnibQLpTyOYurLJ8/0n
         rGqz7u8/cmbYz2l9znuIbCns1E9DtPxkVRY3/6dJqWm9qqjFscEvfszUV3iUgkL/rYBj
         bXAtwzX9ZpJQLZmom6SrYNtYxXBbPZOpnfTOhsyLeQWoycM4eAjKpMon5OljgTonquMe
         ENmOUP+NPPj0/PSnLLKJl1lwE4k22kZV1PDL5ehrv632S5zaLlWMCuQM9wPStO9PXuon
         QUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790794430; x=1791399230;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r5lP6B15UeibEwnmcWBmYogILctd0FL89sC0OmMFnzw=;
        b=szVIzizEC+jjKnGwsG8AerjsHNSn2uTSxxvK54JFjjS5CCoJwJGZ9puzFki91YXmyF
         KGPHlONkLuXWNr3ynexXv+I2/3rpVSnoe+8rd+I70THqTq4//CLa/FGyn/bmJk8YJFqh
         rHifRHDeKFSXsftAtdnQFVa3CJV5Z9tplvkbMcViLpPY0wip+pRdzeYjHvoV/UGkb8Xq
         tA1sBXx/bplNNNTKNtpeN5lD0HSGhJ6U/5ATeheSsN0joPfFtsBjcOYj42zP/sm568zP
         BRib7nF/ong+vQ9RwQ4i/WtGA+OsAVpgVZY6MmA/Nkpwp/rTd4JzEThuSm49tjyX3rsY
         /sLA==
X-Gm-Message-State: AFq9FYJ6ccd/pbF2Xo6GNDNNn/omdS70WGvWUASp3QW4RwCvxlOLegbx
	kT9ZlhDFwCwGWw/pRwJ4h86G/pAbVwVTJHE+EHoXPUIieupLdS8x13kvj+86gg==
X-Gm-Gg: AYBFou03ViAz4/xKKYqZT356VCEYZY00ik/mXlnt/l3sLGF6wfoMSSSPKtEVnj+Trn/
	r5bF7kD4JoCYp2cGwS9LHbQZW2GZoLm7Dz4tjn0E0uxe4qw4CYsros7VjireGJGZ41YAtN3v2cW
	VEB1HC4IblLoVt8qBJGj192UYpOdV1uWSL/uP4M691xsa6RnWMzAjPumD9KgJRkZcKyauwLuDt9
	0okSwdaW2s3xA+UQNg3q/DrLlBzExGfl3ZG7ZJMq8VHyaEGrbRYWuYmgKQKJUhDRa+BNL9k6yd9
	Amok/+URqdU1EsYmgCqhzTDfBywEU85QnKArVo55BfdqKW5u7WOImiEsWXBfXvS7Lif0JBWC/+K
	CbHGtjbmIiswqJgsH/xM8iHdh4GmqIUc3iD7udl59rzKY8Pd0yEmAqbV+OAeipAOxeu2BGEtgjV
	L3xk1HiSdJxnKaEVMj4YzuBeMiLGHcV+f9FG3V2ZCXTDUDzULL7Tpqjfd/ood1zPZDA1RIFgSeR
	fQq
X-Received: by 2002:a05:6102:6a91:b0:7a1:f7d2:e846 with SMTP id ada2fe7eead31-7be7319bd53mr571907137.22.1790794430193;
        Wed, 30 Sep 2026 11:53:50 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7bfa6ece80bsm176847137.9.2026.09.30.11.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:53:48 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:54:00 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, conor+dt@kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v3 07/13] iio: adc: ad4134: Support buffered data read
Message-ID: <ar1ayHk6n06hskyR@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
 <095cea21f1a9fc39aa0a81b990e87c1046bb3dc9.1790719424.git.marcelo.schmitt@analog.com>
 <20260929230528.8861C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929230528.8861C1F000FF@smtp.kernel.org>

On 09/29, sashiko-bot@kernel.org wrote:
...
> > +static irqreturn_t ad4134_trigger_handler(int irq, void *p)
> > +{
> > +	IIO_DECLARE_BUFFER_WITH_TS(u32, channels, AD4134_NUM_CHANNELS) = { };
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct ad4134_state *st = iio_priv(indio_dev);
> > +	struct spi_transfer xfer = {
> > +		.rx_buf = st->rx_buf,
> 
> [Severity: High]
> If userspace reads or writes ADC registers via debugfs while the triggered
> buffer is running in minimum I/O mode (NO_CS), ad4134_debugfs_reg_access()
> can run concurrently with ad4134_trigger_handler().
> 
Yeah, debugfs is not safe to use like that. I believe claiming direct mode
would solve the issue, although, the conclusion a while ago was that enforcing
that for debug interface was not the way to go, IIRC. 

I'll ignore complaints about issues related to debugfs unless asked otherwise.

> [Severity: High]
> When the driver is configured in 4-wire mode (adi,spi-mode = "4-wire") and
> falls back to the software trigger handler, this flag explicitly instructs
> the SPI controller to leave the chip select line inactive (high) for the
> duration of the transfer.
> 
> Since the AD4134 requires an active (low) chip select to frame the data in
> 4-wire mode, does this setting break 4-wire mode communication and prevent
> the device from outputting valid sample data?

Doesn't apply to this specific device in 4-wire operation mode since the AD4134
data interface is read with CS off.

> 
> > +		.len = BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS),
> > +	};
> > +	int ret;
> > +
> > +	gpiod_set_value_cansleep(st->odr_gpio, 1);
> > +	fsleep(1);
> > +	gpiod_set_value_cansleep(st->odr_gpio, 0);
> > +
> > +	/* Execute transfers for all channels so the entire data frame is read. */
> > +	for (int ch = 0, i = 0; ch < AD4134_NUM_CHANNELS; ch++) {
> > +		ret = spi_sync_transfer(st->spi, &xfer, 1);
> 
> [Severity: High]
> In 4-wire mode, the AD4134 resets its data output frame if the chip select
> goes high or if the DCLK is idle for more than 250ns.

I have no idea where it supposedly found such information.

> 
> Does calling spi_sync_transfer() in a loop for each channel introduce
> software delays far exceeding 250ns and toggle the CS line between calls?
> 
> Could this violate the device's continuous clocking and CS timing
> requirements, causing the frame to reset on every iteration and reading
> Channel 0 repeatedly instead of streaming consecutive channels?
> 
> Should a single bulk SPI transfer be used here instead of a loop?

Anyways, running a longer transfer to get data all at once can indeed be done
to minimize delays. So, I may do that on a v4.
