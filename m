Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E838F248;
	Tue,  1 Sep 2026 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232066; cv=none; b=YMyrHzI8CVSezpqJSBKgBg1+e8iUOn4e/6RsiisWEaK1u0DzK25omUtiVKsIXrMIPM4qxT8WthHRfoY8uNEVSL3nhmbeZn1F3dN+o/QYSP7Nbyy48PyuYl7mIVQ3LeVNgam7WcidJABmGFpCbroRbqbJrBmbPRmZyK+BbWHNfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232066; c=relaxed/simple;
	bh=Mq73nCEb/lXDrCcSxx8IA/cMyh1PNrIMwP8FU/Oy1dU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEf3Qxki9J7QQUjkJDVc2YMPrwiOI5SlP3jzmI/klr/Rwu8zbA85iWXh6nDWAx3VZRoMMBtEhdIbAngrenFeG8YUtdAwQzBkxFc3o/XK6odrfbpx5WKYwLAMcuIshhQQO4qCcahoBuKUCXYc0GpyaM6lN7Qvqf/mWjUc3VLtz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoV7p+no; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoV7p+no"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752C11F000E9;
	Tue,  1 Sep 2026 03:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788232065;
	bh=Rm3rexZv/rqn+JjZRgRNeAhDymbMcB+5L6QoB5OwkYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MoV7p+noUSbkZ04p8/XYInmqPg0P3k7/8KkxFGtesZb1HOOLUZj21mpSkFR3EdqiA
	 LgBZ3yp3bRgJuTZ/e+ekK3QfnEI4ENYhX9o6dy2h/A3x4geAmX+HmVTm7Ln9kjMSfE
	 giY1W46Oq9SYjArjaLOalZDN1/fyEczNjcgAIIsywy/+JsD1e/cf+O1rXkLMqx59p+
	 mvpczO5iY2ou6sP0X8oTm5+rNlvkZnOaSbuaSg09NpEH6fHi9aKU+YZIX2XrvB/KH2
	 6AGb3h3F/shr0UrLp/uVTUpAwnoHUNe/FhAsH9iD4Sjh6NmZkS8y0aNQcftMzsPWyg
	 wTKvmLMQbSWeQ==
Date: Tue, 1 Sep 2026 04:07:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/10] iio: adc: add the ti-ads1262 driver
Message-ID: <20260901040740.19588bf4@jic23-huawei>
In-Reply-To: <bc00d888-9944-4a22-88e3-8f4d7384d037@baylibre.com>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
	<20260828-ads126x-v4-3-1dc27e9c0260@gmail.com>
	<bc00d888-9944-4a22-88e3-8f4d7384d037@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


A couple of comments on comments.

Thanks,

J
> > +	},
> > +	{
> > +		.type = IIO_VOLTAGE,
> > +		.channel = ADS1262_INPMUX_AVDD,
> > +		.channel2 = ADS1262_INPMUX_AVDD,
> > +		.indexed = 1,
> > +		.address = ADS1262_MONITOR_ADDR_OFFSET + 1,
> > +		.scan_type = {
> > +			.format = IIO_SCAN_FORMAT_SIGNED_INT,
> > +			.realbits = ADS1262_ADC1_RESOLUTION,
> > +			.storagebits = 32,
> > +			.endianness = IIO_BE,
> > +		},
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +	},
> > +	{
> > +		.type = IIO_VOLTAGE,
> > +		.channel = ADS1262_INPMUX_DVDD,
> > +		.channel2 = ADS1262_INPMUX_DVDD,
> > +		.indexed = 1,
> > +		.address = ADS1262_MONITOR_ADDR_OFFSET + 2,
> > +		.scan_type = {
> > +			.format = IIO_SCAN_FORMAT_SIGNED_INT,
> > +			.realbits = ADS1262_ADC1_RESOLUTION,
> > +			.storagebits = 32,
> > +			.endianness = IIO_BE,
> > +		},
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +	},
> > +	{
> > +		.type = IIO_VOLTAGE,
> > +		.channel = ADS1262_INPMUX_TDAC,
> > +		.channel2 = ADS1262_INPMUX_TDAC,  
> 
> Hmm... a differential where channel == channel2 usually means a shorted
> input. TDACP and TDACN can be controlled indepedantly, so really are two
> separate channels.

This came up recently.  We do have a history of doing this for
fixed purpose pairs as well.  The ambiguity vs shorted inputs
was one of the negatives, but I decided it was nicer that making
numbers up for IN1+ IN1- type setups.

If they are separately controllable then indeed makes no sense
to do this. Given them separate numbers unless intent is a shorted
channel.

> 
> > +		.indexed = 1,
> > +		.differential = 1,
> > +		.address = ADS1262_MONITOR_ADDR_OFFSET + 3,
> > +		.scan_type = {
> > +			.format = IIO_SCAN_FORMAT_SIGNED_INT,
> > +			.realbits = ADS1262_ADC1_RESOLUTION,
> > +			.storagebits = 32,
> > +			.endianness = IIO_BE,
> > +		},
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +	},
> > +};
> > +  
> > +
> > +	rate = clk_get_rate(clk);
> > +	if (clk && !rate)
> > +		return dev_err_probe(dev, -EINVAL, "failed to get clock rate\n");
> > +	st->clk_rate = rate ? rate : ADS1262_NOMINAL_CLK_RATE;
> > +
> > +	st->start_gpiod = devm_gpiod_get_optional(dev, "start", GPIOD_OUT_LOW);
> > +	if (IS_ERR(st->start_gpiod))
> > +		return dev_err_probe(dev, PTR_ERR(st->start_gpiod),
> > +				     "failed to get start GPIO\n");
> > +
> > +	st->regmap = devm_regmap_init(dev, &ads1262_regmap_bus, st,
> > +				      &ads1262_regmap_config);
> > +	if (IS_ERR(st->regmap))
> > +		return PTR_ERR(st->regmap);
> > +
> > +	ret = ads1262_dev_configure(st);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to configure device\n");
> > +
> > +	indio_dev->name = ads1262_device_id_to_name[st->dev_id];  
> 
> Not so sure about this. Almost always, this is coming from the compatible
> match data. So unless we plan on trusting the device ID returned by the
> chip over the devicetree when we add more to the device id tables and looking
> up per-chip behavior from there instead of the compatible, I would go with
> the traditional approach. That way the name userpace sees match the driver
> behavior that goes with the other chip-specific match data that is likely
> to be added in the future.

We have done this detection path in the past (with fallback to the
dt compat where we don't know better). Normally we do this because
we know there are boards in the wild with the wrong description and
want to be nice.  Here it indeed seems perhaps too complex.

Jonathan

