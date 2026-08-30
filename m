Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA463587A2;
	Sun, 30 Aug 2026 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788132645; cv=none; b=TazJ0EM0igd/JdXy/Aa12PMRaqPWLXTJG7Fii69o+4BzCYZ2sQnn4o6njuGIBqT+k4WwQgYft+8/4znRPjklAYw2wgJOP3MBi8mA5HrXeFEC9jd6JhPxru00g0LJKZEFkkRxUe0eSz7sTDBlcaBeIGrT7qgGzfF7DwRzuvuXbWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788132645; c=relaxed/simple;
	bh=+eWRK4DKEuAOB/1OOJxNhj5wbJgAiUsevVPnZsvXhVI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=JHYYaG++4+hSnnRASIcvdHZJkwst4Wy1ALHMbsH68qnayuDqfFv7TujZc7ul5/9auyd0hCqDiYI5Y1TW3gNR97y1hZsmTYmc7ijXWjnQBykgxeUlAMoXXXrGBcPkLQMUr/BsekygSGWedfyn3uce8DqQ+YFavIRlOIIVCNaFVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHg346/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHg346/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41001F000E9;
	Sun, 30 Aug 2026 23:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788132638;
	bh=uESAZduD6L1AWeDLH/YSvI2Yj667GSnbkMen2HQZefU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=jHg346/rnB5IxzrcAEnH37qMZ60XYT957cDCBE3I9pNRsOwD4qrJvWWazShFGLw+k
	 aP8M6GzbA/tJeKfBA1ZA+UWF627SsmJZd1XfzroVIkNZYJamW4Ya82CsaGEOKzS7Ce
	 vCqEqSYrdofAJUw4sXi1RhQ24Mb/T+/LLH1cP3G4kFpb3PZ0SKsIWGM8zAd8PxBQu7
	 YmbpS3BJ2wCkuAYZeK9Dgal+Q90HmXLUqLKP4gh720K3fik7K9h5b9158Pc+l7t5Ny
	 3UbZOiPwQ0+l6qWiq3mc5j9GP1XCwcg6web05Uyz4ONbAdzrJfbXOgF0hA03o7Vxmg
	 UiqP+UvAcscAA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 3/3] iio: dac: Add AD5529R DAC driver support
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Mark Brown <broonie@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Kent Gustavsson <kent@minoris.se>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Janani Sunil <jan.sun97@gmail.com>, linux-spi@vger.kernel.org, 
 Kent Gustavsson <nedo80@gmail.com>, linux-riscv@lists.infradead.org
In-Reply-To: <20260827-ad5529r-driver-v10-3-38f2be07b824@analog.com>
References: <20260827-ad5529r-driver-v10-0-38f2be07b824@analog.com>
 <20260827-ad5529r-driver-v10-3-38f2be07b824@analog.com>
Date: Mon, 31 Aug 2026 00:30:19 +0100
Message-Id: <178813261957.2788519.4929586195765891569.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4775;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=+eWRK4DKEuAOB/1OOJxNhj5wbJgAiUsevVPnZsvXhVI=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqlL0NsdVCM/ppaynb9fDnagUPMjHk4qAPJLsQ4
 9JL0kopEiyJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapS9DREcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiJnJD/96MkuP0q8sHM1l1J43Vsxq2iowWkA2AZdoxojx2F49ceQ
 SuwSo1pHPbruu/E1oLfSxNU0gTsdIyq8iERHjQ1m3qLpLauOVPRIVGJJ5UPJxupnX7zkwzb80sz
 w7acbgf7+GcMyJiVlgsY6xAwdtsAkmw/ZEFQCOsRqAa0kGRbIMyvC7L3CwA/Wl/AKZiRfn8kojf
 vkxqFGCmZPUR0KsS//LB186BfluoB0fG5YCPCDKzL4HmKCiFb6P9KMxxcGy81EkV6j/GfTSWoEk
 Of/49GwCqGLQPSV2suOhmlo5Efz9frJgh+fL27HrzUHq3zJXzgODphfnIYOXU/tV83DB9KYQWZ2
 8+mHe+a4Y7/VfjeDAmJDakM5csdnSI2hoNuhtO9M5C4zjT8l6cdMV0yDAiiWCpmHTYUJLI1VGMc
 PAFTCvZLVvOlSWkP/+knuxc5o9FFaJH+OquVcwa+FPtdvm1i8kNQcoqa8rhXt6PzcHrTvALeLlq
 IB+KyCUV/eNPhmAmPoQpmqByMN+rnjBX4DIe3q2592cRaVq79uNsPJ+ueyXJC+EynVMGNYGlEwY
 mulRxcV3rq0VCWbY2UUKqVX0Xw+OooACX37ufyLcselrSqi84YxEtHmzHg7n6N0Sms6yhT1RdnP
 IHJOtxQpL7dwS1VLV8VBhubGq/hxRmuD3poG7Qw==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> from Analog Devices.
> 
> The device communicates over SPI and supports per-channel output range
> configuration. An optional external 4.096V reference can be used in
> place of the internal reference.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Just a couple of minor additions from me.



>  
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 992f8930f95c..8dc644522b1e 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_AD5446) += ad5446.o
>  obj-$(CONFIG_AD5446_SPI) += ad5446-spi.o
>  obj-$(CONFIG_AD5446_I2C) += ad5446-i2c.o
>  obj-$(CONFIG_AD5449) += ad5449.o
> +obj-$(CONFIG_AD5529R) += ad5529r.o
>  obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
>  obj-$(CONFIG_AD5592R) += ad5592r.o
>  obj-$(CONFIG_AD5593R) += ad5593r.o
> diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
> new file mode 100644
> index 000000000000..52601cbf28d5
> --- /dev/null
> +++ b/drivers/iio/dac/ad5529r.c
> @@ -0,0 +1,536 @@

Why do we need those outer () ?

...

> +static int ad5529r_parse_channel_ranges(struct device *dev,
> +					struct ad5529r_state *st)
> +{
> +	unsigned long channel_mask = 0;
> +	s32 vals[2];

Where possible, I'd move these into narrower scope.
That tends to make the code a little easier to reason about.

> +	int ret, range_idx;
> +	u32 ch;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		if (st->num_channels == ARRAY_SIZE(st->channels))
> +			return dev_err_probe(dev, -ECHRNG, "Too many channels\n");
> +
> +		ret = fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing reg property in channel node\n");
> +
> +		if (ch >= AD5529R_MAX_CHANNELS)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Channel %u exceeds maximum 15\n",
> +					     ch);
> +
> +		if (channel_mask & BIT(ch))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Duplicate channel %u\n", ch);
> +
> +		channel_mask |= BIT(ch);
> +
> +		if (fwnode_property_present(child, "output-range-microvolt")) {
> +			/*
> +			 * DT stores cells as raw 32-bit values; signed endpoints are
> +			 * encoded by dtc in two's-complement and then interpreted
> +			 * here as s32.
> +			 */
> +			ret = fwnode_property_read_u32_array(child,
> +							     "output-range-microvolt",
> +							     (u32 *)vals, ARRAY_SIZE(vals));
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to read range for ch %u\n",
> +						     ch);
> +
> +			range_idx = ad5529r_find_output_range(vals);
> +			if (range_idx < 0)
> +				return dev_err_probe(dev, range_idx,
> +						     "Invalid range [%d %d] for ch %u\n",
> +						     vals[0], vals[1], ch);
> +		} else {
> +			range_idx = AD5529R_RANGE_0V_5V;
> +		}
> +
> +		st->output_range_idx[ch] = range_idx;
> +		ret = regmap_write(st->regmap_16bit,
> +				   AD5529R_REG_OUT_RANGE(ch), range_idx);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to configure range for ch %u\n",
> +					     ch);
> +
> +		st->channels[st->num_channels++] = AD5529R_DAC_CHANNEL(ch);
> +	}
> +
> +	return 0;
> +}
> +

> +static int ad5529r_probe(struct spi_device *spi)
> +{
> +	struct regmap_config regmap_16bit_cfg;
> +	struct regmap_config regmap_8bit_cfg;
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad5529r_state *st;
> +	bool external_vref;
> +	u32 dev_addr = 0;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->model_data = spi_get_device_match_data(spi);
> +	if (!st->model_data)
> +		return dev_err_probe(dev, -ENODATA,
> +				     "Failed to identify device variant\n");
> +

Move the default value setting of dev_addr() down here.
	dev_addr = 0;

or better yet, check for presence of property
	if (device_property_present(dev, "spi-device-addr")) {
		ret = device_property_read_u32(dev, "spi-dev-addr", &dev_addr);
		if (ret < 0)
			return ret;

		if (dev_addr > 3)
			return dev_err_probe();
	} else {
		dev_addr = 0;
	}
as that gives us clean checking for corrupted properties and setting
of a default if no attempt was made ot set it to anything else.

> +	device_property_read_u32(dev, "spi-device-addr", &dev_addr);
> +	if (dev_addr > 3)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "spi-device-addr %u out of range [0, 3]\n",
> +				     dev_addr);

Thanks

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
