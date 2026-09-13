Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2A537FF6D;
	Sun, 13 Sep 2026 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789332732; cv=none; b=ucPtY5xIk4ZoKfMRtfbfsb6Vg7mZ02zaW3fOcBoVSrFMAx1tRtGKXwuTZTPOebsB4qvbYrfUH8cw2RsS0vf8R7ZoEyx+h12gLo9vhN37CAFtc/XoGjlsNn1zRlvPnW+LPTYpptgF7kJJBDCpmEYsHpl6OQKIQFw4V8mnnMT4yAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789332732; c=relaxed/simple;
	bh=uRZdaKyHxtzDfkOBpybSXenqALhEyUEYvRoSz/59b+o=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=T+h0DkSlGNjR4HbA/qt86khQ3qtXQwNjgqVqisdtZ6GWhWhJXn33VwfJy6M03YiFCoh8Cm9CbHsYlFPS1pvHSjJn5e6XxzJZdvJXDZ8BJHgoN08BP76fCIFTGiVv2ZzAsMmO7s1+mWwZLglOW7r6D8PZRKXA9zVfsGTD+T6plP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy9Qy1sN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy9Qy1sN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D8D1F0089F;
	Sun, 13 Sep 2026 20:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789332730;
	bh=ATBWQ67dfM8MnIXkPBlJd7jRMYnXXba7tkhicvL9gMI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Yy9Qy1sN1mLNhohKo2f60kIbkQOxRGbOTU2psJJzmKQnC15zA5ELLeFZxkYqAQKhJ
	 vdJoVsk8Tk8CxzyShZHCDSmh+RrQ/1wcJ2IqPqqMtlLTlPtaXmJSqzOSmxkE8JyB4q
	 Dg4aomcG4EyQZtQ20cUmht4Y4TEkeXu2xixDgVNTKBR89MfrR7ZDK8lVgDVlK9tCgP
	 sUe3mLYL3vW9BWuMWE8KtycolCGaTQliORS3aP1ZnKGAGRiI22zetMw2KcF6JCqQLj
	 62wcRQJGuNTS6uEutvsd/cWky1DasrL8opwZs/m9Qf1TYOAzKrUUCOyxAKtyr8mJwl
	 1ORy4GCvRrDDw==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 05/17] iio: adc: Add AD7768 and AD7768-4 core
 support
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
In-Reply-To: <20260910-ad7768-driver-v7-5-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
 <20260910-ad7768-driver-v7-5-7f70b07627e1@analog.com>
Date: Sun, 13 Sep 2026 21:51:54 +0100
Message-Id: <178933271415.413489.14289891647621156962.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5491;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=uRZdaKyHxtzDfkOBpybSXenqALhEyUEYvRoSz/59b+o=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqpwz4XQo2ZJhuiLo8LPfoULe61a3ya5yQtHnnF
 752Gr3duIeJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCaqcM+BEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiBX1EACiYLa2bIVhCKIUk9vRHj3zOALopbI0Gd2c7MlSiCL0Eic
 lJuy6EShflemfjbcj0AOk+ft10P9vf/lIr/6ncvFGqTeOtvd+3Yz2Y9Z03dYbKFA1M2v0sCz4r1
 NQs0HBZvHLpdonB9N0x93WtcKFQ3MlyWe/MPabKKo6BgMFBRcHMEjrFJh3FW8qMS24Bt31yT7z2
 em/Iwztq+sumpDwkEr9v5q1+2ZFbD56OJosS4P3/ds7d3Ew5ofp624k3Zs/NDHogtCNgpg5b4nT
 WSf2oAi9V2/pdpTE85YetbFLEmh0Vpn2WJGRbDV2TO3KdFrxuKkOCm83rteX2bOM48zuycSNXGu
 GUa7nQ5PJ+TjblrjG7VqCUPTVqa4j5u7RKLmu2Gl28DIAM4ltz9iyqYMObN1R9Kilo/tGt2ymWU
 rFqEHlFIM6J3zz6O+tt0Wz+N/kqzLyX62Q9hSivGHeY6ukGCqG6YdDYjjVxy7nyaJ1HNkKbgytm
 kLivhEZ47X6MLNc/81ZDvGx0PW+AdH2x5axXsXk5YMeDv9hw6sojdImtJvM6eRgREeZXrpQyUDK
 PA7X2LfWvnVYFoZdWwIuUWr1WKzAFXaqh+Uppf4svCUHCl0R8jlL8YNKeQGHHhEJwlku4cZlqnn
 DdmBXVWlJsfUHR/7NBmCVOsFoASarbImeszsFYg==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
> Configure supplies, clock and reset, use a custom regmap bus for the SPI
> protocol, and parse the enabled channels and input buffer settings from
> devicetree.
> 
> Connect the converter to an IIO backend for buffered capture with CRC,
> provide a fixed safe wideband sampling configuration and add runtime
> power management.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>
Hi Janani,

Given you are going to be doing a v8 anyway, here are a few comments
from that hopefully don't overlap too much with ones Andy gave.

Thanks

Jonathan

> diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
> new file mode 100644
> index 000000000000..3cb58c2554a3
> --- /dev/null
> +++ b/drivers/iio/adc/ad7768.c


> +
> +struct ad7768_state {
> +	struct regmap *regmap;
> +	struct clk *mclk;
> +	unsigned int datalines;
> +	enum ad7768_clock_source clock_source;
> +	const struct ad7768_chip_info *chip_info;
> +	struct iio_backend *back;
> +	unsigned int vref_uV[2];
> +
> +	__be16 d16 __aligned(IIO_DMA_MINALIGN);

I think it would be good to have a comment that this buffer
is used in the regmap write callback and hence access is controlled
by the regmap locks. Something like.
   /* Used only in regmap_write() callback, hence guarded by regmap lock */

> +};

...

> +
> +static int ad7768_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	pm_runtime_put_autosuspend(regmap_get_device(st->regmap));

Trivial but nice to have a blank line before a simple returnstatement
like this one. Helps it stand out to those reading.

> +	return 0;
> +}


...

> +
> +static int ad7768_parse_config(struct iio_dev *indio_dev,
> +			       struct device *dev)
> +{
> +	struct ad7768_precharge_config precharge_cfg[AD7768_MAX_CHANNEL] = { };
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	const unsigned int *available_datalines;
> +	bool datalines_valid = false;
> +	struct iio_chan_spec *chan;
> +	unsigned int num_channels;
> +	unsigned long standby_mask;
> +	unsigned int len;
> +	int chan_idx = 0;
> +	int ret;
> +
> +	num_channels = device_get_named_child_node_count(dev, "channel");
> +
Trivial but as you are rolling again, drop the blank line here.
> +	if (num_channels == 0)
> +		return dev_err_probe(dev, -ENOENT, "No channel specified\n");
> +
and here.
> +	if (num_channels > st->chip_info->num_channels)
> +		return dev_err_probe(dev, -ENOSPC, "Invalid number of channels\n");

That will keey the 'get' and the pair of error checks tightly
visually associated with each other.

> +
> +	chan = devm_kcalloc(dev, num_channels, sizeof(*chan), GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = chan;
> +	indio_dev->num_channels = num_channels;
> +
> +	standby_mask = ad7768_all_standby_mask(st);
> +
> +	/*
> +	 * Crystal excitation requires channel 4 on AD7768 or channel 2 on
> +	 * AD7768-4 to remain active.
> +	 */
> +	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
> +		__clear_bit(st->chip_info->num_channels / 2, &standby_mask);
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_CH_STANDBY, standby_mask);
> +	if (ret)
> +		return ret;
> +
> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> +		u32 channel;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &channel);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to parse reg of %pfwP\n",
> +					     child);
> +
> +		if (channel >= st->chip_info->num_channels)
> +			return dev_err_probe(dev, -ECHRNG,
> +					     "Invalid channel %u in firmware\n",
> +					     channel);
> +
> +		ret = regmap_clear_bits(st->regmap, AD7768_REG_CH_STANDBY,
> +					BIT(channel));
> +		if (ret)
> +			return ret;
> +

> +		precharge_cfg[channel].prebufp_en =
> +			fwnode_property_read_bool(child,
> +						  "adi,prechargebuf-pos-enable");
I'd go long on these probably for readability.

		precharge_cfg[channel].prebufp_en =
			fwnode_property_read_bool(child, "adi,prechargebuf-pos-enable");
		precharge_cfg[channel].prebufn_en =
			fwnode_property_read_bool(child, "adi,prechargebuf-neg-enable");
		precharge_cfg[channel].refbufp =
			fwnode_property_read_bool(child, "adi,refbuf-pos-enable");
		precharge_cfg[channel].refbufn =
			fwnode_property_read_bool(child, "adi,refbuf-neg-enable");


> +		precharge_cfg[channel].prebufn_en =
> +			fwnode_property_read_bool(child,
> +						  "adi,prechargebuf-neg-enable");
> +		precharge_cfg[channel].refbufp =
> +			fwnode_property_read_bool(child,
> +						  "adi,refbuf-pos-enable");
> +		precharge_cfg[channel].refbufn =
> +			fwnode_property_read_bool(child,
> +						  "adi,refbuf-neg-enable");
> +
> +		chan[chan_idx] = (struct iio_chan_spec) {

  		chan[chan_idx++] = (struct iio_chan_spec) {
Doesn't seem to lose anything for readability to me and makes it lcear
we are only writing each chan entry in one place.

> +			.type = IIO_VOLTAGE,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),
> +			.indexed = 1,
> +			.channel = channel,
> +			.scan_index = channel,
> +			.scan_type = {
> +				.sign = 's',
> +				.realbits = 24,
> +				.storagebits = 32,
> +			},
> +		};
> +		chan_idx++;
> +	}
> +
.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
