Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0B934AB00;
	Wed,  1 Jul 2026 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782932168; cv=none; b=kBHB0yadXEYQkDvojMoDCH9asnluCLuiQnXumvD9aYqJ3xdCZMDLK39rgxGuCFmLLkxVFF17jIZdiOefkeFr2MAV/gOzitl+O2p/w2/bBsvJ4A5Es+Xyn11EHesv2XtD/p8aQpKV01cZuibiGmVDN0unxYefOmRwPA1jB2uIRqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782932168; c=relaxed/simple;
	bh=+LPMl91hB17oNPptObbvHvkUvcU9wk/5F7tgcR+QDCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiyFvuagx3+MVfCEBbaFq3msJbDyWBC7KohjHoZRmxL5GPY2r3Cf3XvSaWbd3x1gYl9Nallkpk4bcRbHEwrmN0PieJOcytKsIBCnOfrROQD3mgHA8c3nEx4V6DhGa+FncXU05gOCvy8PbofY9mCkL/2laJvy5AF12cvDBQboNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBdQj6qU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBdQj6qU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3248E1F000E9;
	Wed,  1 Jul 2026 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782932164;
	bh=UVsLUCoJK2OfphtdYWBXzYdg+FD1B0j4kSx8XHwgveU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dBdQj6qU/anVOvzew2FVrEeLzOqZqwyjI4pw5nmA3XjION12+HQhT43SjpLH3cjIS
	 4ZSYB4vHbhfJsk+qejeWIQB20ezTKPeBr/vLJttZmT6AxthBXET6efPQyoq4PNuiis
	 ENE6wgW32fDvxudm3bOFlmM5y6BxaJFoEBrlFFKI4O3n+5TYSQ0tPKc0q5oGZl9IFX
	 5HI/hsVR5WXLIMru621VKXUTUF7UQSPgDU+brXEclYC28d8e2WwRhtonDC8CqsK0g1
	 gGKTDE4MkNUleFhOjFC2sSYlDttQfXgCmeUEpUZQSTcAaoTj6uOFFBBqNe0tGYxFAy
	 /JpWvBFgVDt4w==
Date: Wed, 1 Jul 2026 19:55:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Janani Sunil <jan.sun97@gmail.com>,
 <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <20260701195558.18da4bfd@jic23-huawei>
In-Reply-To: <20260701-ad5529r-driver-v5-3-ed087900e642@analog.com>
References: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
	<20260701-ad5529r-driver-v5-3-ed087900e642@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Jul 2026 08:40:41 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> from Analog Devices.
> 
> The device communicates over SPI and supports per-channel output range
> configuration. An optional external 4.096V reference can be used in
> place of the internal reference.

This needs to respect the device address stuff in the dt binding.
It is fine to initially support just one device, but if it's address is 2 then
the driver should work.

> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/iio/dac/Kconfig   |  17 ++
>  drivers/iio/dac/Makefile  |   1 +
>  drivers/iio/dac/ad5529r.c | 531 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 550 insertions(+)
A few other things inline.

Thanks,

> diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
> new file mode 100644
> index 000000000000..4841bd608482
> --- /dev/null
> +++ b/drivers/iio/dac/ad5529r.c

> +#define AD5529R_DAC_CHANNEL(chan, bits) {			\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.output = 1,						\
> +	.channel = (chan),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE) |	\
> +			      BIT(IIO_CHAN_INFO_OFFSET),	\
> +	.scan_type = {						\
> +		.format = 'u',					\
> +		.realbits = (bits),				\
> +		.storagebits = 16,				\

None of .scan_type is yet used.  I'd suggest removing that for now.
It can be brought back when it is needed for buffered output support.

> +	},							\
> +}

> +static const struct ad5529r_model_data ad5529r_16bit_model_data = {
> +	.model_name = "ad5529r-16",
> +	.resolution = 16,
> +	.channels = ad5529r_channels_16bit,
> +	.num_channels = ARRAY_SIZE(ad5529r_channels_16bit),
Sashiko picked up on this:
https://sashiko.dev/#/patchset/20260701-ad5529r-driver-v5-0-ed087900e642%40analog.com

When we have channel specific nodes in DT we have always taken the absence
of a given node to mean that it is not wired up and so the driver should not provide it.

I don't mind if for now we insist on all channels being present but we should
then check they are all there in DT or that there are dt-binding specified defaults.

The decision on whether to present all channels or just those in DT is a driver
one but really hard to change in future so much better to just present the
channels that have dt subnodes rather than all of them.


> +};

> +
> +static int ad5529r_probe(struct spi_device *spi)
> +{
> +	ret = devm_regulator_get_enable_optional(dev, "hvss");
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable hvss regulator\n");
> +
> +	/*
> +	 * The datasheet mentions a 4.096V external reference for correct
> +	 * operation.

I don't see the comment as adding much value given the person who needs
to see that is the board designer and they don't tend to read drivers :)
So probably drop this comment as noise to us.

> +	 */
> +	ret = devm_regulator_get_enable_optional(dev, "vref");
> +	if (ret == -ENODEV) {
> +		external_vref = false;
> +	} else if (ret) {
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable vref regulator\n");
I'd just put that on one slightly long line.

> +	} else {
> +		external_vref = true;
> +	}

Those are all single statements so arguably don't need the {}  It is a bit
fuzzy when you have a line break like in the second one here though.

> +
> +	st->regmap_8bit = devm_regmap_init_spi(spi, &ad5529r_regmap_8bit_config);
> +	if (IS_ERR(st->regmap_8bit))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap_8bit),
> +				     "Failed to initialize 8-bit regmap\n");
> +
> +	st->regmap_16bit = devm_regmap_init_spi(spi, &ad5529r_regmap_16bit_config);
> +	if (IS_ERR(st->regmap_16bit))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap_16bit),
> +				     "Failed to initialize 16-bit regmap\n");
> +
> +	ret = ad5529r_reset(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to reset device\n");
> +
> +	ret = regmap_assign_bits(st->regmap_16bit, AD5529R_REG_REF_SEL,
> +				 AD5529R_REF_SEL_INTERNAL_REF,
> +				 external_vref ? 0 : AD5529R_REF_SEL_INTERNAL_REF);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to configure reference\n");
> +
> +	ret = ad5529r_parse_channel_ranges(dev, st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->model_data->model_name;
> +	indio_dev->info = &ad5529r_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = st->model_data->channels;
> +	indio_dev->num_channels = st->model_data->num_channels;

See above.  Sadly I think you need to generate these dynamically as we
have per channel dt sub nodes.

> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

> 

