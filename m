Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D777538DD3;
	Wed,  1 Jul 2026 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782867594; cv=none; b=Z/17P2BJiqpysOAjZeyqaPsfAGjPX2+RhANcGo+weospm0ud+RtptMHPhERCwwe0++gPh1emkF5em/iirNfM8AVJoJYJKtMijds5ySZkRlm6ewjPZpPgz5+UJg/StaVpZRzFY/9q4z8yIu9N4KlyASX1fM+uTx6PWdzLgut82n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782867594; c=relaxed/simple;
	bh=n3/zdA2DbajTQhBJP5rWC/+JdKL34hTR2IrEMC2A/VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyJNJXFURLi5rEhJD9RZJYqHvYkdSOgIvsx0+z4BvxnN5ss0eeZ//X49YRHxHFCm8psbZZbYgEqWzrMHMns7JcREu60F8OixbEz6GU1/IKXwyosFcXoOyM9qZk5O2EBJVKDJSzNi4nfPJnPOQ+1M4CjksT4WZVVvUJJFI9ypu0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zyw5Ho4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zyw5Ho4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCB81F000E9;
	Wed,  1 Jul 2026 00:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782867592;
	bh=2t7u5S0N+F8wKA12XkGWMQb/d1YC5Ddu/4G62sn+ja0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zyw5Ho4iIoMXd/kuEf+/kMLyw66AsmBOqm/mPnQ1IRqaOc+zXELRRCmUMJxWQppBq
	 NH4mBg/lv4yRZp8sO/BFnQDl02O8812mQ0xavOxO5Dkeb3MJw41LZbnKJaxGhWzHfP
	 ahWC1XVSb93jS5yKW9u7RToh6HA8jp97i6zQyq+0hSiz6GjM/fLuvOLugmNaOGRNS/
	 LOyIZVTE1oQxk7ks/RIhJPxYPFMMYaxwEPv+RPasL2+Qji0JrARhQaiypTyf86nSAO
	 XSnhJ4+g2QAejKJEmrfYxebF+nZAyVvgU5+k7EQBeeWKXtbiqzaXWG/2hfIg4a3lVr
	 RqZQ3Vd0b+qyQ==
Date: Wed, 1 Jul 2026 01:59:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, u.kleine-koenig@baylibre.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: magnetometer: add support for Melexis
 MLX90393
Message-ID: <20260701015948.20fb7289@jic23-huawei>
In-Reply-To: <20260627095519.8377-3-nikhilgtr@gmail.com>
References: <20260627095519.8377-1-nikhilgtr@gmail.com>
	<20260627095519.8377-3-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 15:25:19 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Add Industrial I/O subsystem support for the Melexis
> MLX90393 3-axis magnetometer and temperature sensor.
> 
> The driver currently supports:
> 
> raw magnetic field measurements
> raw temperature measurements
> configurable gain/scale selection
> configurable oversampling ratio
> direct mode operation
> 
> The MLX90393 supports both I2C and SPI interfaces. This
> initial implementation adds support for the I2C interface.
> 
> The device uses a command-based communication protocol
> rather than a conventional register-addressed interface.
> A small transport abstraction layer is therefore used
> instead of regmap to share the common sensor logic
> between the current I2C implementation and future SPI
> support without duplicating code.
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
Hi Nikhil,

You have a lot of review already so I'm only going to take a very quick
look at this version.

Also take a look at:
https://sashiko.dev/#/patchset/20260627095519.8377-1-nikhilgtr%40gmail.com

The osr2_avail comment at least looks superficially valid as an oversampling
ratio of 0 means you don't read the value at all.

I2C dma safety one is wrong (that keeps coming up) as you have to opt in
to use DMA directly on buffers when using the Linux I2C stack.

Some of the later ones look plausible but over to you to analyse them.
It can be useful to address any you don't agree with by replying to this
thread to quote them and say why they are wrong

Thanks,

Jonathan


> diff --git a/drivers/iio/magnetometer/mlx90393_core.c b/drivers/iio/magnetometer/mlx90393_core.c
> new file mode 100644
> index 000000000000..78fcab8a2b56
> --- /dev/null
> +++ b/drivers/iio/magnetometer/mlx90393_core.c

> +static const int mlx90393_scale_table[MLX90393_AXIS_MAX][MLX90393_GAIN_MAX]
> +				      [MLX90393_RES_MAX] = {
> +	/* XY axis */
> +	{
> +		{ 751, 1502, 3004, 6009},
> +		{ 601, 1202, 2403, 4840},
> +		{ 451, 901, 1803, 3605},
> +		{ 376, 751, 1502, 3004},
> +		{ 300, 601, 1202, 2403},
> +		{ 250, 501, 1001, 2003},
> +		{ 200, 401, 801, 1602},
> +		{ 150, 300, 601, 1202},
> +	},
> +	/* Z axis */
> +	{
> +		{ 1210, 2420, 4840, 9680},

Space before } on all these

> +		{ 968, 1936, 3872, 7744},
> +		{ 726, 1452, 2904, 5808},
> +		{ 605, 1210, 2420, 4840},
> +		{ 484, 968, 1936, 3872},
> +		{ 403, 807, 1613, 3227},
> +		{ 323, 645, 1291, 2581},
> +		{ 242, 484, 968, 1936},
> +	}
> +};
> +
> +static const int mlx90393_osr2_avail[MLX90393_OSR2_MAX] = {
> +	0, 1, 2, 3,
> +};

> +static int mlx90393_read_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct mlx90393_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		guard(mutex)(&data->lock);
> +		ret = mlx90393_read_measurement(data, chan->address, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_MAGN:
> +			return mlx90393_get_scale(data, chan, val, val2);
> +
> +		case IIO_TEMP:
> +			/*
> +			 * Datasheet Table 7: Thermal Specification
> +			 */

Single line comment.

> +			*val = 0;
> +			*val2 = 22124;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type != IIO_TEMP)
> +			return -EINVAL;
> +		/*
> +		 * Datasheet Table 7: Thermal Specification

Single line comment.

> +		 */
> +
> +		*val = -45114;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			return mlx90393_get_temp_osr2(data, val);
> +		case IIO_MAGN:
> +			return mlx90393_get_osr(data, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

> diff --git a/drivers/iio/magnetometer/mlx90393_i2c.c b/drivers/iio/magnetometer/mlx90393_i2c.c
> new file mode 100644
> index 000000000000..a9f0a40d15e8
> --- /dev/null
> +++ b/drivers/iio/magnetometer/mlx90393_i2c.c
>
...

> +
> +static const struct mlx90393_transfer_ops mlx90393_i2c_ops = {
> +	.xfer = mlx90393_i2c_xfer,
> +};
> +
> +static int mlx90393_i2c_probe(struct i2c_client *client)
> +{
> +	return mlx90393_core_probe(&client->dev, &mlx90393_i2c_ops, client);
> +}


Drop this blank line. It is a common convention to not have one here
as it visually associates the macro with the data it is using
(which isn't used anywhere else!)

> +module_i2c_driver(mlx90393_i2c_driver);
> +
> +MODULE_IMPORT_NS("IIO_MLX90393");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Nikhil Gautam <nikhilgtr@gmail.com>");
> +MODULE_DESCRIPTION("MLX90393 magnetometer sensor driver");

