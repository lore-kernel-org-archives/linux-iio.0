Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749467;
	b=Kd0Vw+FyVnovrNk4oMojnKwQTEleaurY/2FovTAnkgghd83vJOWaAaGCEmmwMmegClBZ
	 9OO4ugTQDyzI0dzY12thfA98wHWn/hSkt1GgP7eoluPB39nt3UX4ldHnFMJVG94zRH6pl
	 drrVpI/iYM/Y7FS5ne4kjEMiKVUfqnXpPMAz5fFgC20iHIhdkocLcNusc5iiHjnjiaXIj
	 KhSJx+oyObdeXGJsVDeNfuQV4W+Kn7ypCC83Crh5kpi8GW8TXX18Zq/uIf/eS0YR7LQHA
	 D6hPkAbIDNtRt9BaXJ/nv/5Y4Vahtan8RQE/fcCeagCLI1KnYjVNQqFFoYMn1VlRhWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749467;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=DbVHW1yrB4yoHqU1q7CQ3q5hu4mf3NTWesL2v+5GJVE=;
	b=neR5UjBoMtfsRzvKqL8EQYJpI2aLiyutVBvVUr/CCA0846dSVYb9ApFA1sCOgNhmXmzo
	 s++v+yNWx63l6eGqQrAeXhiG4aO/qkeiN7GDJ24aoI14dj8QAIAp1ujhy+7PrTAxdQZ78
	 b3sXXsIkue4fdls/dNWNZCX5EqNyrBMuvz89mpmnCvgEgWp4s2zEsO5/LK8wol5HL3BQ4
	 JEzHnYP3MCKGBR4Pm64+IF+JH3I5mK1kRX1ppoNPBc6dumtnaItYkkrQzPacUXIfbXXTO
	 sB3nXv6IEySk8y3fCbK/au7iKtWlqwTVp+V2pkdCe+6ezhKVS/KB0G1DV2H2cdp4VpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GAkszb+1;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE080606A31A;
	Fri, 23 Oct 2026 09:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE080606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GAkszb+1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792749466; x=1824285466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dbbIU+M7u+etB+K38xpzwtKJdfTEoOUMsbxe88Ciw8U=;
  b=GAkszb+1kHNlEmUX3qnu2Coz24EE0gt+I/Tvbx/wa81t9yHPv3bPCyV1
   Bnl5fevs3mzE1dSno927CW/CdD3KnbSbj9sql2aFLx7qK0aGu3BBA+2z6
   V+uv9t99SRe22p5Lhu9tzA5jnzj3KIGZE7YHfGSyLh4TDRpgwM9hNb9yy
   IU7eZtXCnHyVCBmBvsMqpZUtveQIGJUmVKyNkWZpGnnMs2XToxyfB6ZSD
   TUcHs+rRXb2eBxL2AjsTPqjXYFHOB74PQrghYTBtgdYM4AU1j/4Z17oAv
   QUpSvGQmrJ8+F92Z2/uwwcwykeZImrqM4afx2EL1JRmSe8v9wiKXosk8Y
   Q==;
X-CSE-ConnectionGUID: rV4cJwxlQt29Bs2yggn3FQ==
X-CSE-MsgGUID: KklpnB8LREesbNj+LTSgnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1397547"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1397547"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:57:45 -0700
X-CSE-ConnectionGUID: 2dUNhiiqQEmt+J0E3MzIMQ==
X-CSE-MsgGUID: Jj9ltOfeQrGjpzSvRefqog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3482835"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:57:42 -0700
Date: Fri, 23 Oct 2026 12:57:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com, andy@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, joshua.crofts1@gmail.com
Subject: Re: [PATCH v5 2/2] iio: temperature: add support for Analog Devices
 MAX30210
Message-ID: <atsvlJDkqkrtaxRl@ashevche-desk.local>
References: <20261023080623.1830-1-johnerasmusmari.geronimo@analog.com>
 <20261023080623.1830-3-johnerasmusmari.geronimo@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261023080623.1830-3-johnerasmusmari.geronimo@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 04:06:23PM +0800, John Erasmus Mari Geronimo wrote:
> Add support for the Analog Devices MAX30210 I2C temperature
> sensor.
> 
> The driver uses regmap for register access and integrates with
> the IIO framework. It supports:
> 
> - Direct mode temperature conversion
> - Configurable sampling frequency
> - Threshold events
> - FIFO operation with IIO kfifo buffer support
> - Optional interrupt-driven data ready signaling
> 
> The device provides 16-bit signed temperature data and a
> 64-sample FIFO.

...

> +static int max30210_read_event(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info, int *val, int *val2)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;

Seems in the same way you can test for IIO_EV_TYPE_THRESH.

> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		switch (type) {
> +		case IIO_EV_TYPE_THRESH:
> +			return max30210_read_temp(st->regmap, MAX30210_TEMP_ALM_HI_REG, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_EV_DIR_FALLING:
> +		switch (type) {
> +		case IIO_EV_TYPE_THRESH:
> +			return max30210_read_temp(st->regmap, MAX30210_TEMP_ALM_LO_REG, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max30210_write_event(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info, int val, int val2)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;

Ditto.

> +	if (val < S16_MIN || val > S16_MAX)
> +		return -EINVAL;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		switch (type) {
> +		case IIO_EV_TYPE_THRESH:
> +			return max30210_write_temp(st->regmap, MAX30210_TEMP_ALM_HI_REG, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_EV_DIR_FALLING:
> +		switch (type) {
> +		case IIO_EV_TYPE_THRESH:
> +			return max30210_write_temp(st->regmap, MAX30210_TEMP_ALM_LO_REG, val);

You can reduce the lines at least by 7 characters with

	struct regmap *map = st->regmap;

at the top of the function. Use same trick elsewhere.

> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max30210_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, MAX30210_INT_EN_REG, &val);
> +	if (ret)
> +		return ret;

Do you need to do this for other than IIO_EV_TYPE_THRESH?
Otherwise check for that first and bail out earlier.

> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		switch (type) {
> +		case IIO_EV_TYPE_THRESH:
> +			return FIELD_GET(MAX30210_STATUS_TEMP_HI_MASK, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_EV_DIR_FALLING:
> +		switch (type) {
> +		case IIO_EV_TYPE_THRESH:
> +			return FIELD_GET(MAX30210_STATUS_TEMP_LO_MASK, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +	guard(mutex)(&st->lock);
> +
> +	/* The core does not dedupe; only take/drop a reference on a real change. */
> +	ret = regmap_read(st->regmap, MAX30210_INT_EN_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (!!(val & mask) == state)
> +		return 0;

regmap_test_bits() ?

> +	/*
> +	 * Threshold events need the device sampling autonomously, independent
> +	 * of whether the FIFO buffer is also enabled.
> +	 */
> +	if (state) {
> +		ret = max30210_autoconv_get(st);
> +		if (ret)
> +			return ret;
> +	}

> +	ret = regmap_assign_bits(st->regmap, MAX30210_INT_EN_REG, mask, state);
> +	if (ret) {
> +		if (state)
> +			max30210_autoconv_put(st);
> +		return ret;
> +	}
> +
> +	return state ? 0 : max30210_autoconv_put(st);

Why not simply

	if (state) {
		ret = regmap_set_bits(map, MAX30210_INT_EN_REG, mask);
		if (ret)
			max30210_autoconv_put(st);

		return ret;
	} else {
		ret = regmap_clear_bits(map, MAX30210_INT_EN_REG, mask);
		if (ret)
			return ret;

		return max30210_autoconv_put(st);
	}

(Yeah, if I suggested _assign_bits() earlier, I was clearly wrong, this
 is more complex logic here.)

> +}

...

> +static int max30210_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	unsigned int uval;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 5;
> +		*val2 = MILLI;
> +
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		unsigned int period;

Units? period_Hz?

> +		ret = regmap_read(st->regmap, MAX30210_TEMP_CONF_2_REG, &uval);
> +		if (ret)
> +			return ret;
> +
> +		period = FIELD_GET(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, uval);
> +
> +		/*
> +		 * TEMP_PERIOD is an index into the sampling frequency lookup
> +		 * table. Clamp in case the register holds a reserved value.
> +		 */
> +		period = min(period, ARRAY_SIZE(max30210_samp_freq_avail) - 1);
> +
> +		*val = max30210_samp_freq_avail[period][0];
> +		*val2 = max30210_samp_freq_avail[period][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	case IIO_CHAN_INFO_RAW: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		guard(mutex)(&st->lock);
> +
> +		/*
> +		 * TEMP_DATA_REG is only refreshed by a single-shot
> +		 * conversion; the buffer/FIFO path is the only thing that
> +		 * gets updated during AUTO mode. If AUTO is already running
> +		 * for the buffer and/or events, triggering a one-off
> +		 * conversion here would stomp the AUTO bit out from under
> +		 * whoever enabled it, and there is no way to get a fresh
> +		 * single-shot value without doing so -- refuse instead of
> +		 * returning stale data.
> +		 */
> +		if (st->autoconv_users > 0)
> +			return -EBUSY;
> +
> +		ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
> +				   MAX30210_TEMPCONV_CONV_T);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Wait until CONVERT_T auto-clears.
> +		 * Datasheet:
> +		 *   tBIAS_WU = 260 µs
> +		 *   tINT     = 8 ms
> +		 *
> +		 * Worst-case conversion ≈ 8.26 ms.
> +		 * Use 10 ms timeout for margin.
> +		 */

> +		ret = regmap_read_poll_timeout(st->regmap, MAX30210_TEMP_CONV_REG, uval,
> +					       !(uval & MAX30210_TEMPCONV_CONV_T),
> +					       500, 10 * USEC_PER_MSEC);

Logical split

		ret = regmap_read_poll_timeout(map, MAX30210_TEMP_CONV_REG,
					       uval, !(uval & MAX30210_TEMPCONV_CONV_T),
					       500, 10 * USEC_PER_MSEC);

> +		if (ret)
> +			return ret;
> +
> +		return max30210_read_temp(st->regmap, MAX30210_TEMP_DATA_REG, val);

		return max30210_read_temp(map, MAX30210_TEMP_DATA_REG, val);

will fit into 80 characters limit.

> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int max30210_set_watermark(struct iio_dev *indio_dev, unsigned int val)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (val < 1 || val > MAX30210_FIFO_SIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * FIFO_A_FULL sets the number of empty FIFO slots remaining when the
> +	 * A_FULL interrupt fires. For a watermark of N samples, set
> +	 * FIFO_A_FULL = FIFO_SIZE - N.
> +	 */

The rule of thumb is to make lines in the comments balanced (by length):

	/*
	 * FIFO_A_FULL sets the number of empty FIFO slots remaining when
	 * the A_FULL interrupt fires. For a watermark of N samples, set
	 * FIFO_A_FULL = FIFO_SIZE - N.
	 */

> +	ret = regmap_write(st->regmap, MAX30210_FIFO_CONF_1_REG,
> +			   FIELD_PREP(MAX30210_FIFOCONF1_A_FULL_MASK,
> +				      MAX30210_FIFO_SIZE - val));
> +	if (ret)
> +		return ret;
> +
> +	st->watermark = val;
> +
> +	return 0;
> +}

...

> +static int max30210_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	/* Enable FIFO-full interrupt */
> +	ret = regmap_set_bits(st->regmap, MAX30210_INT_EN_REG,
> +			      MAX30210_STATUS_A_FULL_MASK);
> +	if (ret)
> +		return ret;
> +
> +	/* Flush FIFO before starting autonomous conversions */
> +	ret = regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
> +			      MAX30210_FIFOCONF2_FLUSH_FIFO);
> +	if (ret)
> +		goto err_disable_irq;

> +	scoped_guard(mutex, &st->lock)
> +		ret = max30210_autoconv_get(st);
> +	if (ret)
> +		goto err_disable_irq;

Oh, does it compile this way with scoped_guard()?

> +	return 0;
> +
> +err_disable_irq:
> +	/* The core won't call postdisable() when preenable() fails. */
> +	regmap_clear_bits(st->regmap, MAX30210_INT_EN_REG,
> +			  MAX30210_STATUS_A_FULL_MASK);
> +
> +	return ret;
> +}

> +static int max30210_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st = iio_priv(indio_dev);
> +	int ret, err;
> +
> +	scoped_guard(mutex, &st->lock)
> +		err = max30210_autoconv_put(st);
> +
> +	/* Keep going on error so the interrupt is always disabled below. */
> +	ret = regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
> +			      MAX30210_FIFOCONF2_FLUSH_FIFO);
> +	if (!err)
> +		err = ret;
> +
> +	/* Disable FIFO-full interrupt */
> +	ret = regmap_clear_bits(st->regmap, MAX30210_INT_EN_REG,
> +				MAX30210_STATUS_A_FULL_MASK);
> +
> +	return err ?: ret;
> +}

TBH, I don't like how these two callbacks are implemented in terms of goto:s
and additional error code variable, but I have nothing to suggest, so we would
live with the above... :-(

...

> +static void max30210_powerdown(void *data)
> +{
> +	struct gpio_desc *powerdown_gpio = data;
> +
> +	gpiod_set_value(powerdown_gpio, 1);
> +}

static void max30210_powerdown(void *powerdown_gpio)
{
	gpiod_set_value(powerdown_gpio, 1);
}

...

> +static void max30210_quiesce(void *data)
> +{
> +	struct max30210_state *st = data;
> +
> +	/* Stop interrupt sources and autonomous conversions; errors are not actionable here */

Make it multi-line to fit 80 characters limit.

> +	regmap_write(st->regmap, MAX30210_INT_EN_REG, 0);
> +	regmap_write(st->regmap, MAX30210_TEMP_CONV_REG, 0);
> +}

...

> +static int max30210_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max30210_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable vdd regulator.\n");

Here it is fine to have a single line

		return dev_err_probe(dev, ret, "Failed to enable vdd regulator.\n");

> +	st->regmap = devm_regmap_init_i2c(client, &max30210_regmap);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to allocate regmap.\n");
> +
> +	st->watermark = MAX30210_WATERMARK_DEFAULT;
> +
> +	ret = max30210_setup(st, dev);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = &max30210_channel;
> +	indio_dev->num_channels = 1;
> +	indio_dev->name = "max30210";
> +	indio_dev->info = &max30210_info;
> +
> +	/* Currently, without an interrupt there is no way to drain the FIFO into the buffer */
> +	if (client->irq) {
> +		ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev, &max30210_buffer_ops,
> +						      max30210_fifo_attributes);

		ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
						      &max30210_buffer_ops,
						      max30210_fifo_attributes);

> +		if (ret)
> +			return ret;
> +
> +		/* Runs after unregister, so nothing can re-arm the device; before powerdown. */
> +		ret = devm_add_action_or_reset(dev, max30210_quiesce, st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (!client->irq)
> +		return 0;
> +
> +	/*
> +	 * Request the IRQ after registering the IIO device so devm tears it
> +	 * down first on removal, before the event interface is freed.
> +	 */
> +	return devm_request_threaded_irq(dev, client->irq, NULL,
> +					 max30210_irq_handler, IRQF_ONESHOT,
> +					 indio_dev->name, indio_dev);
> +}

...

Module description:
> +MODULE_DESCRIPTION("MAX30210 low-power digital temperature sensor");

Kconfig:
> +	tristate "Analog Devices MAX30210 temperature sensor"

Top comment:
>  * Analog Devices MAX30210 I2C Temperature Sensor driver

Make all three texts to be the same.

-- 
With Best Regards,
Andy Shevchenko


