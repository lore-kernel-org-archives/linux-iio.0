Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795825203;
	b=Xyre4dszukPW83rABLZdkdbbPfxjYDyzSbzBqAs67CIWr7SajSfBckdPYqj0iVTFVwda
	 zpmtTVPwR7b0ou3HnxipgJpcJCNaDCGVVKcuD0+kFbnyc2sdlkwMz4Scb9LFgdgzCRaCl
	 F8CtIzx5LGqaqdo+rBjSUg8pNzo/jEDO9pN8SDJIR2cqlxZ9iFd1dx6W/1fLhFjGKNZEJ
	 JtPjpbv2WCXz8FGdXNeU9MVzW2/VbwXIIupIqY+tQEJB9S8wqrmCoc3zQ/6S1dVYYl/UH
	 WU5043pMYhIjXLL0lfPL5iJgD0WPISkPtS8YCHoBYUxFM1k3VXwMQz9f6QKZ87qlaGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795825203;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YKHaoQgjNKvnRgOD6Ki23tH+hbjn0TD1FsJYf0UncXg=;
	b=mjlErOmLJbcEh27hOHfe5sorb4yusjqFGMAfea1VbmopRWlqp9DpqJFHZmHj66VlAe/v
	 OrBWxoqZYxeTzftA62m23r1wLM7u+61kF2SSjHAZyWoSrB0uOubuNmpySFIMO/TPo+FLI
	 DEruW0E6aDfWpRAQLY1QOxOzClDHqm82Mp6pRkHES1VTLwGizigfR1sOizg8NIwyG3pEv
	 FO7HlXfVcGqu31eW2E9FvdPXVzEJuguGpQRU1mde8eNYx9hogauEuqudJ3Wnk7sjT0XUG
	 62A+CvOYo9F7Y6qhCAJgg3jorpT37JoznJE2/isiRm1iuUqh9VerHgu6MggIf6Et9nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ib6rHmuf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A28606A31F;
	Sat, 28 Nov 2026 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ib6rHmuf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CE91F00897;
	Sat, 28 Nov 2026 00:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795825202;
	bh=YKHaoQgjNKvnRgOD6Ki23tH+hbjn0TD1FsJYf0UncXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ib6rHmuf1etG22G+mmoOg0l6rwEspUqKNukIOk2Yh9Bf2aSCj1yLVoUsoDoqpK2/T
	 28Hs7/ibEo0fF4szzXmOQpWg8192N4JW+w313wlMxcqyZoUNcknGBvSpgr1ta+GUPT
	 PE2czr67e3qWiROwFtyHTN8x5m/pPR4kJWExqWFGuBgMN9vlkBNnbYxjuK/NNHfJTZ
	 M8SoQiwFUAnyLvZyHBLNpgD6abyl+VIiTYpnuYRaFKSEft6nzNaUxwqwY4J9zitNtt
	 FiSswuYOPSYDqpCDy6MGHdkW7ewM8/vb20ODwV8lsezgO67T1shMzDTbPotUaeH01Y
	 R1po18gilMoXg==
Date: Sat, 28 Nov 2026 00:19:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux@analog.com>,
 <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
 <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 5/5] iio: adc: Add support for ADA4355 and similar
 ADCs
Message-ID: <20261128001957.39e44c59@jic23-hlaptop>
In-Reply-To: <e82c0e4ce3968c6e26e05223510e8b51972a6e44.1795816065.git.marcelo.schmitt@analog.com>
References: <cover.1795816065.git.marcelo.schmitt@analog.com>
	<e82c0e4ce3968c6e26e05223510e8b51972a6e44.1795816065.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Nov 2026 18:53:17 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The ADA4355 and AD4356 are 14-bit, 125 MSPS, analog-to-digital converters
> with integrated analog front-end. These chips are configured over SPI while
> conversion data is streamed over a serial LVDS interface handled by an IIO
> backend.

I'd be tempted to put a little more in here for what this is intended for.
Anyone trying to align this with the datasheet talking about a
Programmable Transimpedance Current to Bits Receiver uModule.

> 
> Add an IIO device driver for ADA4355 and similar designs, providing device
> configuration, debugfs register access and buffered captures through the
> IIO backend framework.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

A few minor things inline.

> diff --git a/drivers/iio/adc/ada4355.c b/drivers/iio/adc/ada4355.c
> new file mode 100644
> index 000000000000..5a3f48036253
> --- /dev/null
> +++ b/drivers/iio/adc/ada4355.c

> +enum ada4355_tz_options {
I'd spell out what tz is somewhere here. Perhaps as a comment.
Transimpedance Amplifier Gain isn't obvious to me!

> +	ADA4355_TZ0,
> +	ADA4355_TZ1,
> +	ADA4355_TZ2,
> +};
> +
> +static const unsigned int ada4355_tz_options_ohms[] = {
> +	[ADA4355_TZ1] = 2000, /* -80 to +800 uA input range */
> +	[ADA4355_TZ2] = 20000, /* -8.0 to +80 uA input range */
> +	[ADA4355_TZ0] = 200000, /* -0.8 to +8.0 uA input range */
> +};
> +
> +static const unsigned int ada4356_tz_options_ohms[] = {
> +	[ADA4355_TZ1] = 4540, /* 3 to 300 uA input range */
> +	[ADA4355_TZ2] = 11000, /* 1 to 100 uA input range */
> +	[ADA4355_TZ0] = 133000, /* 0.1 to 10 uA input range */

> +
> +static int ada4355_set_scale(struct ada4355_state *st, int val, int val2)
> +{
> +	unsigned long gsel;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	for (unsigned int i = 0; i < st->scale_tb_size; i++) {
> +		if (st->scale_tb[i][0] != val || st->scale_tb[i][1] != val2)
> +			continue;
> +
> +		gsel = i;
> +
> +		ret = gpiod_multi_set_value_cansleep(st->gsel, &gsel);

Why not iterate over gsel?  An unsigned long is fine for the index as well.

> +		if (ret)
> +			return ret;
> +
> +		st->scale_idx = i;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}

> +/*
> + * Find the maximum number of successful points in a row and get the one in the
> + * middle.
> + */
> +static unsigned int ada4355_find_optimal_point(const unsigned long *calib_map,
> +					       unsigned int start,
> +					       unsigned int nbits,
> +					       unsigned int *val)
> +{
> +	unsigned int bit = start, end, start_cnt, cnt = 0;

Don't mix declarations that assign with ones that don't. It makes for
less readable code to save a few lines.

> +
> +	for_each_clear_bitrange_from(bit, end, calib_map, nbits + start) {
> +		if (end - bit > cnt) {
> +			cnt = end - bit;
> +			start_cnt = bit;
> +		}
> +	}
> +
> +	if (cnt)
> +		*val = start_cnt + cnt / 2;
> +
> +	return cnt;
> +}
> +
> +static int ada4355_calibrate_prepare(struct ada4355_state *st)
> +{
> +	struct iio_backend_data_fmt data = {
> +		.enable = false,
> +	};
> +	int ret;
> +
> +	/*
> +	 * The channel spec already accounts for the 14-bit sample being left
> +	 * aligned in a 16-bit word, so the backend format conversion stays off
> +	 * both during and after the calibration.
> +	 */
> +	ret = iio_backend_data_format_set(st->back, 0, &data);
> +	if (ret)
> +		return ret;
> +
> +	ret = ada4355_testmode_set(st, ADA4355_TEST_MODE_USER);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_USER_PATT1_MSB_REG,
> +			   ADA4355_CALIB_PATTERN >> 8);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_USER_PATT1_LSB_REG,
> +			   ADA4355_CALIB_PATTERN & 0xFF);
> +	if (ret)

Why not a bulk write after appropriate endian conversion.

> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_USER_PATT2_MSB_REG,
> +			   ADA4355_CALIB_PATTERN >> 8);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_USER_PATT2_LSB_REG,
> +			   ADA4355_CALIB_PATTERN & 0xFF);
> +	if (ret)
> +		return ret;
> +
> +	return iio_backend_chan_enable(st->back, 0);
> +}


> +static int ada4355_setup(struct ada4355_state *st,
> +			 struct ada4355_chip_info const *chip_info)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct gpio_desc *gpio_vld_en;
> +	struct gpio_desc *gpio_lfp;
> +	unsigned int id;
> +	int ret;
> +
> +	gpio_vld_en = devm_gpiod_get(dev, "adi,vld-en", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpio_vld_en))
> +		return dev_err_probe(dev, PTR_ERR(gpio_vld_en),
> +				     "Failed to find adi,vld-en-gpios\n");
> +
> +	if (gpio_vld_en) {
> +		gpiod_set_value_cansleep(gpio_vld_en, 1);
> +		fsleep(1000);
> +	}
> +
> +	gpio_lfp = devm_gpiod_get(dev, "adi,lfp", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpio_lfp))
> +		return dev_err_probe(dev, PTR_ERR(gpio_lfp),
> +				     "Failed to find adi,lfp-gpios\n");
> +
> +	ret = ada4355_digital_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_CHIP_CONFIG_REG, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_DEVICE_INDEX_REG, 0x02);

I started writing a comment about making those magic values meaningful.
Then discovered that bit isn't defined except for a note to see the
ADC SPI Startup Sequence   Add a comment to say that starting at the
CONFIG_REG write above these 4 writes are 'special' and the really
are magic value.

Might be better to do this as

	/* See ADC SPI START-UP SEQUENCE */
	const struct regmap_sequence spi_startup[] = {
		REG_SEQ0(ADA4355_CHIP_CONFIG_REG, 0x00),
		REG_SEQ0(ADA4355_DEVICE_INDEX_REG, 0x02),
		REG_SEQ0(ADA4355_SERIAL_CHANNEL_STATUS_REG, 0x03),
		REG_SEQ0(ADA4355_DEVICE_INDEX_REG, 0x31),
	};

	ret = regmap_multireg_write(st->regmap, spi_startup, ARRAY_SIZE(spi_startup));
	if (ret)
		return ret;

It isn't much more compact (which is why I don't normally encourage use of that
approach) but it does make it clear they are considered a sequence that must
be fully executed.


> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_SERIAL_CHANNEL_STATUS_REG, 0x03);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_DEVICE_INDEX_REG, 0x31);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, ADA4355_CHIP_ID_REG, &id);
> +	if (ret)
> +		return ret;
> +
> +	if (id != chip_info->id)
> +		dev_info(dev, "unknown chip ID, got 0x%X, expected 0x%X\n",
> +			 id, chip_info->id);
> +
> +	ret = regmap_update_bits(st->regmap, ADA4355_SERIAL_OUT_DATA_CNTRL_REG,
> +				 ADA4355_SERIAL_OUT_LANE_MODE_MASK,
> +				 FIELD_PREP(ADA4355_SERIAL_OUT_LANE_MODE_MASK,
> +					    ADA4355_DDR_TWO_LANE_BITWISE));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(st->regmap, ADA4355_TRANSFER_REG,
> +			      ADA4355_TRANSFER_OVERRIDE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_OUTPUT_MODE_REG,
> +			   ADA4355_OUTPUT_MODE_TWOSCOMP);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, ADA4355_RESOLUTION_SAMPLE_RATE_REG,
> +			    ADA4355_125_RATE);
> +}


