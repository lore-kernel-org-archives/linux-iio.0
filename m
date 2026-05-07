Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E13164BB;
	Thu,  7 May 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173265; cv=none; b=Kpwip0E+9W+se+i9EImhGSeHkeLqcLQQIb54GG28cGHGa/azfMiopuC2hymAHv0fQardkkvvmJlvfPq6irwaI2+NUUyN8qQ6eFRkc7e/d6P0bBadGaSrT28/NzESXcOWS7COPRQ5sbGPslvFibcbFi7Ut7/jCn3ePyIGro0jsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173265; c=relaxed/simple;
	bh=S/YLvLPLEyXakM+HNeRkH6FixojRw1eV3M3Tz0vu6rA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrgsCznewibTqr3/tSesNTU9wd1ORpzquF7vbEk53U13808W8AvodjQlZhfmYzSHlr1Usjs0B4DDvoxTRMd5MeoBDn089ySMQoTnFYIwpNDPkup1ltXlCFkdv9kuqFGOJ7++hYHGErmIkCDSCi2dFEDho0mPjdS0jhhknl+ADhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKYIHO9v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKYIHO9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7840C2BCB2;
	Thu,  7 May 2026 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173264;
	bh=S/YLvLPLEyXakM+HNeRkH6FixojRw1eV3M3Tz0vu6rA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fKYIHO9vX1pY6bUuEMr72YJueo8zLWUiZfwB2BLnqWfz3Tmq2pkX/xS/flRe+RTaq
	 QxxBvaI+2P+E1nv/eBumLzi4V+PVpUxu8VE2QUE1kF1/lwaNvwIw0g1jfAU3wmvur8
	 /f52oFccIXYqqzaw+W/m1nUYQaG5+SuxngEPm8rWhee+SPkXqhQFysHT0id6/qffav
	 YrY4xTukAS1L/aUjkGEs8QYC58aqWiytkXIc7tpMnAAmi1N850RS6EczYXHAH5Juva
	 fRU+TZPGiGY6nRs8MVH1NId6AvuC1jeDbiD52VpybjS3nAZNBagxKoVazYL0yNt+0m
	 7vqdtlSs7bVDw==
Date: Thu, 7 May 2026 18:00:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: magnetometer: add driver for MEMSIC MMC5983MA
Message-ID: <20260507180055.1f6fa50b@jic23-huawei>
In-Reply-To: <20260507124724.813043-3-vlad.kulikov.c@gmail.com>
References: <20260507124724.813043-1-vlad.kulikov.c@gmail.com>
	<20260507124724.813043-3-vlad.kulikov.c@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 12:47:23 +0000
Vladislav Kulikov <vlad.kulikov.c@gmail.com> wrote:

> Add support for the MEMSIC MMC5983MA 3-axis magnetometer. The driver
> provides raw magnetic field readings via IIO sysfs with SET/RESET
> offset cancellation for each measurement.
> 
> Signed-off-by: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Hi

A few comments inline but mostly a nice clean driver.

Thanks,

Jonathan

> diff --git a/drivers/iio/magnetometer/mmc5983.c b/drivers/iio/magnetometer/mmc5983.c
> new file mode 100644
> index 000000000000..7f2f5133a472
> --- /dev/null
> +++ b/drivers/iio/magnetometer/mmc5983.c


> +enum mmc5983_axis {
> +	MMC5983_AXIS_X,
> +	MMC5983_AXIS_Y,
> +	MMC5983_AXIS_Z
May get more entries so add trailing comma to reduce future churn

> +};
> +
> +struct mmc5983_data {
> +	struct regmap *regmap;
> +	/* Protects chip access during SET/RESET measurement sequence */
> +	struct mutex mutex;
> +};

> +
> +static const struct iio_chan_spec mmc5983_channels[] = {
> +	MMC5983_CHANNEL(X),
> +	MMC5983_CHANNEL(Y),
> +	MMC5983_CHANNEL(Z)

We may well get channels after this so add a trailing ,

> +};

> +
> +static int mmc5983_read_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct mmc5983_data *data = iio_priv(indio_dev);
> +	int m1[3], m2[3];
> +	int ret = -EBUSY;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &data->mutex) {
To avoid the intent and need for that return at the end (due to compilers
being slow to catch on to for loops that are always run once!)

	case IIO_CHAN_INFO_RAW: {
		guard(mutex)(&data->mutex);

		ret = ...

		...
		reutrn IIO_VAL_INT;
	}

> +			ret = regmap_write(data->regmap, MMC5983_REG_CTRL0,
> +					   MMC5983_CTRL0_SET_BIT);
> +			if (ret)
> +				break;
> +
> +			fsleep(500);
> +
> +			ret = mmc5983_take_measurement(data, m1);
> +			if (ret)
> +				break;
> +
> +			ret = regmap_write(data->regmap, MMC5983_REG_CTRL0,
> +					   MMC5983_CTRL0_RESET_BIT);
> +			if (ret)
> +				break;
> +
> +			fsleep(500);
> +
> +			ret = mmc5983_take_measurement(data, m2);
> +			if (ret)
> +				break;
> +
> +			*val = (m1[chan->address] - m2[chan->address]) / 2;
> +			ret = IIO_VAL_INT;
> +		}
> +		return ret;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = 61035;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int mmc5983_init(struct mmc5983_data *data)
> +{
> +	unsigned int reg_id, status;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, MMC5983_REG_ID, &reg_id);
> +	if (ret)
> +		return dev_err_probe(regmap_get_device(data->regmap), ret,
Have

	struct device *dev = regmap_get_device(data->regmap);

at top of function to avoid repeats of this.  Then we should near enough
to 80 chars that at least some of these error messages become one liners.
Given lots of uses of regmap might be useful to have a local variable for
that as well.  If a given line is a tiny bit over 80 chars and that
helps readability then that is fine in IIO these days. With these
local variables I suspect that applies quite a lot in here!

> +				     "Error reading product id\n");
> +
> +	if (reg_id != MMC5983_PRODUCT_ID)
This one is a bit subtle but we never fail to probe on a missmatched product ID.
The reason is DT fallback compatibles.  If in future memsic release a new device
that has a different product ID but which is a strict superset (or identical)
in interface etc, then it will have a fallback compatible listed in the dt-binding.

Those allow old kernels to still support the device based on that compatibility.
That doesn't work if the product ID failing to match is a hard failure.

So trust the firmware and just print an dev_info() to indicate you have
a part you don't recognise rather than failing.

> +		return dev_err_probe(regmap_get_device(data->regmap), -ENODEV,
> +				     "wrong product id 0x%02x\n", reg_id);
> +
> +	ret = regmap_write(data->regmap, MMC5983_REG_CTRL1,
> +			   MMC5983_CTRL1_SW_RST_BIT);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(10000);
As below. Would expect a comment on why this time.

> +
> +	ret = regmap_write(data->regmap, MMC5983_REG_CTRL0,
> +			   MMC5983_CTRL0_OTP_RD_BIT);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read_poll_timeout(data->regmap, MMC5983_REG_STATUS,
> +				       status,
> +				       status & MMC5983_STATUS_OTP_RD_DONE_BIT,
> +				       1000, 10000);

Why these times?  Spec reference.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, MMC5983_REG_CTRL0,
> +			   MMC5983_CTRL0_SET_BIT);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(500);
As below.
> +
> +	ret = regmap_write(data->regmap, MMC5983_REG_CTRL0,
> +			   MMC5983_CTRL0_RESET_BIT);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(500);

Add a spec reference ideally that justifies this value. Sometimes
we get 'slow' parts that need longer. Hence it is good to know
where to find the numbers.

> +
> +	return 0;
> +}
> +
> +static int mmc5983_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct mmc5983_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +
> +	ret = devm_mutex_init(dev, &data->mutex);
> +	if (ret)
> +		return ret;
> +
> +	data->regmap = devm_regmap_init_i2c(i2c, &mmc5983_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "failed to allocate register map\n");
> +
> +	indio_dev->info = &mmc5983_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = i2c->name;

Use a hard coded name.  This can provide annoying fragile dependent on exactly
how the driver was bound / firmware etc and for now there is only one
right answer wrt to what the part number is.

> +	indio_dev->channels = mmc5983_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mmc5983_channels);
> +
> +	ret = mmc5983_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "mmc5983 chip init failed\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

