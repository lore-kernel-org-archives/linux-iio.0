Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73CB315785;
	Wed,  3 Jun 2026 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494103; cv=none; b=JeNUFBmD5b+8M3yQaUqkhFfJgo542x4muXPOju28QaageH6an7eEw6V2izoShYa8yIv6ne9o0XcUy3GBqLAQIZ4f9ic4BmFL97kPf7b7ArX0NmBOW0EG5HGfj7Le7ap6kwRcn1QE7PL2pig6fG+qXScyNZUXOFPTs1FeGq9gFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494103; c=relaxed/simple;
	bh=+8C41rRncxMIOZPBtKBLqFtE+5PaSmWw3yiragR7HYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ik5NyITJE+E0m9IGSn0DP5f4Lx80KhBDMj6do6NOprTi+QRgYSSBMQpnG3BWlNbxao9HUCjUKo3Uf+bJlKsQgMDMAJeG71IbFpc93p0VZZIr8jj+Knhnjoqm+j0ieAF479eXSA4MsE3pnsMZHMPIzeua/S/bj2b4HJ5S6D2HvcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htLHZ/bT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htLHZ/bT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B031F00893;
	Wed,  3 Jun 2026 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780494102;
	bh=TnE/uLXPZCe1VSHvqcoTHEVGQ4O32FN0ovU1bXUARic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=htLHZ/bTWSKQDDbVwToSkF9CW2OiNYBuNJbe0DIOLVX+ZxwXUsnsF3UCwj/ZtIzqN
	 BUdw77jFIFUAzQoRyVjTh1+D9VM7iPcjAUnXIARcF7260zeSu77KhHGOqVadj3/c0C
	 HcP5bYU4o8Wi0hMehvV6hmXh0UCOmbp2hgb75tN75R/Ezmx8VDAtm0kaCb5NT4m3uz
	 +VKnl383MUD+5N6uUbB/Fhf8MXlGEunJ4W9Uty3CQlkQsvumqw02nKqL6ViLBikH4+
	 Gu0XHyy0/Q04qL5n56eqB+eytb/QLzrgo5JTi2V6a664eN4d5cm34dMz3msWh6WWBA
	 vgb6tNNGe7f+Q==
Date: Wed, 3 Jun 2026 14:41:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH 2/4] iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC
 driver
Message-ID: <20260603144132.6c5daea8@jic23-huawei>
In-Reply-To: <20260602-mt6323-adc-v1-2-68ec737508ee@protonmail.com>
References: <20260602-mt6323-adc-v1-0-68ec737508ee@protonmail.com>
	<20260602-mt6323-adc-v1-2-68ec737508ee@protonmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Jun 2026 15:46:55 +0300
Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

> From: Roman Vivchar <rva333@protonmail.com>
> 
> The mt6323 AUXADC is a 15-bit ADC used for system monitoring. This driver
> provides support for reading various channels including battery and
> charger voltages, battery and chip temperature, current sensing and
> accessory detection.
> 
> Add a driver for the AUXADC found in the MediaTek mt6323 PMIC.
> 
> Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
Trivial stuff inline + a question from the sashiko bot you may have
missed.

Jonathan

> diff --git a/drivers/iio/adc/mt6323-auxadc.c b/drivers/iio/adc/mt6323-auxadc.c
> new file mode 100644
> index 000000000000..da6c11a5079c
> --- /dev/null
> +++ b/drivers/iio/adc/mt6323-auxadc.c
> @@ -0,0 +1,299 @@


> +static int mt6323_auxadc_request(struct mt6323_auxadc *auxadc,
> +				 unsigned long channel)
> +{
> +	struct regmap *map = auxadc->regmap;
> +	int ret;
> +
> +	ret = regmap_set_bits(map, MT6323_AUXADC_CON11, AUXADC_CON11_VBUF_EN);

See below. Sashiko asked if lack of turning this off again when done
with a read is wasting power or similar.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_clear_bits(map, MT6323_AUXADC_CON22, BIT(channel));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_set_bits(map, MT6323_AUXADC_CON22, BIT(channel));
> +}
> +
> +static int mt6323_auxadc_read(struct mt6323_auxadc *auxadc,
> +			      const struct iio_chan_spec *chan, int *out)
> +{
> +	struct regmap *map = auxadc->regmap;
> +	u32 reg = chan->address;
It's only used one. I'd probably put it inline and skip the local variable.
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read_poll_timeout(map, reg, val, (val & AUXADC_READY_MASK),
> +				       1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
> +	if (ret)
> +		return ret;
> +
> +	*out = FIELD_GET(AUXADC_DATA_MASK, val);
> +
> +	return 0;
> +}
> +
> +static int mt6323_auxadc_read_raw(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  int *val, int *val2, long mask)
> +{
> +	struct mt6323_auxadc *auxadc = iio_priv(indio_dev);
> +	int ret, mult;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->channel == MT6323_AUXADC_ISENSE ||
> +		    chan->channel == MT6323_AUXADC_BATSNS)
> +			mult = 4;
> +		else
> +			mult = 1;
> +
> +		/* 1800mV full range with 15-bit resolution. */
> +		*val = mult * 1800;
> +		*val2 = 15;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &auxadc->lock) {
> +			ret = mt6323_auxadc_prepare_channel(auxadc);
> +			if (ret)
> +				return ret;
> +
> +			ret = mt6323_auxadc_request(auxadc, chan->channel);
Sashiko asks:
"Does this leak power by leaving AUXADC_CON11_VBUF_EN enabled after the
reading finishes?
It appears the voltage buffer is enabled in mt6323_auxadc_request() but never
disabled once the conversion completes and exits here. Also, the active
channel is never cleared."
https://sashiko.dev/#/patchset/20260602-mt6323-adc-v1-0-68ec737508ee%40protonmail.com

Seems like a reasonable point.


> +			if (ret)
> +				return ret;
> +
> +			/* Hardware limitation: the AUXADC needs a delay to become ready. */
> +			fsleep(300);
> +
> +			ret = mt6323_auxadc_read(auxadc, chan, val);
> +			if (ret)
> +				return ret;
> +		}
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int mt6323_auxadc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mt6323_auxadc *auxadc;
> +	struct iio_dev *iio;
> +	struct regmap *regmap;

When no other particular ordering preference in IIO is for reverse xmas
tree. 

> +	int ret;
> +
> +	regmap = dev_get_regmap(dev->parent->parent, NULL);
> +	if (!regmap)
> +		return dev_err_probe(dev, -ENODEV, "failed to get regmap\n");
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*auxadc));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	auxadc = iio_priv(iio);
> +	auxadc->regmap = regmap;
> +
> +	ret = devm_mutex_init(dev, &auxadc->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = mt6323_auxadc_init(auxadc);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize auxadc\n");
> +
> +	iio->name = "mt6323-auxadc";
> +	iio->info = &mt6323_auxadc_iio_info;
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->channels = mt6323_auxadc_channels;
> +	iio->num_channels = ARRAY_SIZE(mt6323_auxadc_channels);
> +
> +	return devm_iio_device_register(dev, iio);
> +}
