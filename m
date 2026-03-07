Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5940D368959;
	Sat,  7 Mar 2026 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772887135; cv=none; b=MeSXAAJW0xcDD+GjIqcvdDOjtz70VZhxOp7SVOgjohKF6Vn9CbW51WXvYbLm4DrJ16dXPOI+YgJ40dQwzqtkpWTg5VcdgKZXp8YfxSFs8s+do4eX6vyIS/0IU8LdnuNRJhQuWGnzCDN6jBqRi4h77AJiaWTYmqMe24YFFsRSHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772887135; c=relaxed/simple;
	bh=6zZX9NkSONzyhlVnZjEBMBUGQHFY8Lj13sGcN+PiS/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6u5EsA+UPziuwEBksHpFkwSahZbi78jYTVrWIh50zc3SoWVPnYU1bbLaoLZnOjlH/GiV6ywYxBBLAUz7jYWyl0lUdRz5+40+eyMqQaa33dT9vtJymBzAbHIUIWffeHxT70FaO+fMqbajCQnfNy9VcdbLy8/nMJMIu7FyKERbyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYp1mmyF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYp1mmyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93D8C19422;
	Sat,  7 Mar 2026 12:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772887135;
	bh=6zZX9NkSONzyhlVnZjEBMBUGQHFY8Lj13sGcN+PiS/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nYp1mmyFdrDz0pK4/NBSj0V9GZAn05aCHakuHwKgvwWFYurgyub0R8hOvbP36tlVG
	 fVGAIRyPcTc9qTLPMxvuGuGVO3keO8llKBVogeQZ1nNMPOvlNWKVTajrx0ASacBDxa
	 CR9tGmf5JJ6sfqLmIok8O9e5yyStHbU2/wvAEtchVjKLLgpxyTSSyLdH2F72TxnIfy
	 WMVLxRIT7vVBZp6pZc1rwv/pJROOmpf55OU121R7j8XkjGyo3mnPeHLEJYJzAe6oLf
	 3CDe/jf1RkjecOlsMAgjhf3Sv42BbO7JAwtstIapDXCVBJW1vzUla7lsDZYYd/YBkP
	 p5rYLy98OJQ0A==
Date: Sat, 7 Mar 2026 12:38:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: <linux-iio@vger.kernel.org>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: temperature: add support for Analog Devices
 MAX30210
Message-ID: <20260307123847.19395745@jic23-huawei>
In-Reply-To: <20260304122509.67931-3-johnerasmusmari.geronimo@analog.com>
References: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
	<20260304122509.67931-3-johnerasmusmari.geronimo@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Mar 2026 20:25:09 +0800
John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com> wrote:

> Add support for the Analog Devices MAX30210 I2C temperature
> sensor.
>=20
> The driver uses regmap for register access and integrates with
> the IIO framework. It supports:
>=20
> - Direct mode temperature conversion
> - Configurable sampling frequency
> - Threshold events
> - FIFO operation with IIO kfifo buffer support
> - Optional interrupt-driven data ready signaling
>=20
> The device provides 16-bit signed temperature data and a
> 64-sample FIFO.
>=20
> Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analo=
g.com>
Hi John

A few additional comment from me, but overall this is coming together nicel=
y.

Thanks,

Jonathan

> diff --git a/drivers/iio/temperature/max30210.c b/drivers/iio/temperature=
/max30210.c
> new file mode 100644
> index 000000000000..839ed9830957
> --- /dev/null
> +++ b/drivers/iio/temperature/max30210.c

> +static void max30210_fifo_read(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(st->regmap, MAX30210_FIFO_DATA_REG,
> +			       st->fifo_buf, 3 * st->watermark);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Failed to read from fifo.\n");
> +		return;
> +	}
> +
> +	for (unsigned int i =3D 0; i < st->watermark; i++) {
> +		u32 raw =3D get_unaligned_be24(&st->fifo_buf[3 * i]);
> +
> +		if (raw =3D=3D MAX30210_FIFO_INVAL_DATA) {
Whilst this aligns with how the datasheet describes it, the
only bit that is definitely different for invalid data is bit 7 of the
tag.  So could just check that. The code to get the temperature value then
just becomes  memcpy() with the channel described as bit endian.
I don't mind if you prefer it this way though, just thought I'd raise
the possibility.

> +			dev_err_ratelimited(&indio_dev->dev, "Invalid data\n");
> +			continue;
> +		}
> +
> +		s16 temp =3D (s16)(raw & 0xFFFF);
> +
> +		iio_push_to_buffers(indio_dev, &temp);
> +	}
> +}


> +static int max30210_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	unsigned int uval;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 5;
> +		*val2 =3D 1000;
> +
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret =3D regmap_read(st->regmap, MAX30210_TEMP_CONF_2_REG, &uval);
> +		if (ret)
> +			return ret;
> +
> +		uval =3D FIELD_GET(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, uval);
> +
> +		if (uval >=3D ARRAY_SIZE(max30210_samp_freq_avail))
> +			uval =3D ARRAY_SIZE(max30210_samp_freq_avail) - 1;
		uval =3D min(uval, ARRAY_SIZE(max30210_samp_freq_avail) - 1);

perhaps?

> +
> +		*val =3D max30210_samp_freq_avail[uval][0];
> +		*val2 =3D max30210_samp_freq_avail[uval][1];
> +
> +		return IIO_VAL_FRACTIONAL;


> +static int max30210_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		if (val < 0 || val2 < 0)
> +			return -EINVAL;
> +
> +		for (unsigned int i =3D 0; i < ARRAY_SIZE(max30210_samp_freq_avail); i=
++) {
> +			if (val =3D=3D max30210_samp_freq_avail[i][0] &&
> +			    val2 =3D=3D max30210_samp_freq_avail[i][1]) {

Flip the logic to reduce indent.
			if (val !=3D max...[0] ||
			    val !=3D max...[1])
				continue;

			return....

> +				return regmap_update_bits(st->regmap, MAX30210_TEMP_CONF_2_REG,
> +						MAX30210_TEMPCONF2_TEMP_PERIOD_MASK,
> +						FIELD_PREP(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, i));
> +			}
> +		}
> +
> +		return -EINVAL;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int max30210_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D regmap_set_bits(st->regmap, MAX30210_INT_EN_REG, MAX30210_STATU=
S_A_FULL_MASK);
I would wrap this one. Won't hurt readability and keeps it inline with the =
wrapping
on the clear in postdisable()

> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
> +			      MAX30210_FIFOCONF1_FLUSH_FIFO_MASK);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
> +			    MAX30210_TEMPCONV_AUTO_MASK | MAX30210_TEMPCONV_CONV_T_MASK);
> +}
> +
> +static int max30210_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D regmap_write(st->regmap, MAX30210_TEMP_CONV_REG, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
> +			      MAX30210_FIFOCONF1_FLUSH_FIFO_MASK);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_clear_bits(st->regmap, MAX30210_INT_EN_REG,
> +				 MAX30210_STATUS_A_FULL_MASK);
> +}

> +
> +static const struct iio_chan_spec max30210_channels =3D {

only one. So max30210_channel

> +	.type =3D IIO_TEMP,
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +			      BIT(IIO_CHAN_INFO_SCALE) |
> +			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.scan_index =3D 0,
> +	.event_spec =3D max30210_events,
> +	.num_event_specs =3D ARRAY_SIZE(max30210_events),
> +	.scan_type =3D {
> +		.sign =3D 's',
> +		.realbits =3D 16,
> +		.storagebits =3D 16,
> +		.shift =3D 0,

A zero shift is kind of considered the obvious default, so we normally don't
bother setting it explicitly.

> +		.endianness =3D IIO_CPU,
> +	},
> +};
> +
> +static int max30210_setup(struct max30210_state *st, struct device *dev)
> +{
> +	struct gpio_desc *powerdown_gpio;
> +	unsigned int val;
> +	int ret;
> +
> +	/* Optional hardware reset via powerdown GPIO */
> +	powerdown_gpio =3D devm_gpiod_get_optional(dev, "powerdown",
> +						 GPIOD_OUT_HIGH);
> +	if (IS_ERR(powerdown_gpio))
> +		return dev_err_probe(dev, PTR_ERR(powerdown_gpio),
> +				     "failed to request powerdown GPIO\n");
> +
> +	if (powerdown_gpio) {
> +		/* Deassert powerdown to power up device */
> +		gpiod_set_value(powerdown_gpio, 0);
> +	} else {
> +		/* Software reset fallback */
> +		ret =3D regmap_update_bits(st->regmap, MAX30210_SYS_CONF_REG,
> +					 MAX30210_SYSCONF_RESET_MASK,
> +					 MAX30210_SYSCONF_RESET_MASK);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Datasheet Figure 6:
	/*
	 * Datasheet..

> +	 * tPU max =3D 700 =C2=B5s after power-up or reset before device is rea=
dy.
> +	 */
> +	fsleep(700);
> +
> +	/* Clear status byte */
> +	return regmap_read(st->regmap, MAX30210_STATUS_REG, &val);
> +}
> +

> +static int max30210_probe(struct i2c_client *client)
> +{

...

> +	ret =3D devm_iio_kfifo_buffer_setup_ext(dev, indio_dev, &max30210_buffe=
r_ops,
> +					      max30210_fifo_attributes);
> +	if (ret)
> +		return ret;
> +
> +	if (client->irq) {
> +		ret =3D devm_request_irq(dev, client->irq, max30210_irq_handler, IRQF_=
NO_THREAD,

You are doing a bunch of bus accesses in your handler and I can't see anyth=
ing int here
that wouldn't work in a thread. So I think this is backwards. All the work =
should be
done in an interrupt thread.

> +				       indio_dev->name, indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
