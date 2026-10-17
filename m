Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76A21254B;
	Sat, 17 Oct 2026 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200274; cv=none; b=GYWZ6hhP9bAi4o2ySIFwrm/z3PQjzu+5IaWq7jk0afi0RLwVPZiXiNRb1QGEgCq1CwQKfe9VgMkCs/CfDPLPkn3T7r9bZjNTaxWsDEzr6jPyxsRMyvzi2gbrGMw7YlNBg7jcFjS3ZvIJS650pSKQMtd1RVUxKii4ye6rXPyfki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200274; c=relaxed/simple;
	bh=37FpM2Nt65+XXSaFhTAg/fvAiGovMowzdIvnnJdKPdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUtcUTyrDZl92V1AIDfEkusWAlvfOwytqnqoEBg/p3MEsALUtkQKDy9BPtR1Czh8Me5hvoH+GjANWuCx9cxwF3VBrsxUygq+ViSLtMRCtpaOJf26E5XrPBd96XucoX+fyYCNH6lYkr+fQZU/hLD37DsEcmgei20YsoqptrnSK8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXeSVGRa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXeSVGRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DCB1F000C4;
	Sat, 17 Oct 2026 01:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792200273;
	bh=9/24KwX5C8gEK3BKOkJcboRt9kt0gDPQAHIWOfX6QPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gXeSVGRa5pB6NWcigG+FlIHDTWJNtZIh+KlDbL6+czH1B5myn+ni9OHxv7QRX6ojI
	 32NqeGKaSXkHiaP8FCpZpPs4y8ilYIAOR9IZb1oqtwAU9LEPCX5pocHancNG77FXLr
	 ZNB2T92787rSWPWzwKuaUbS3UBlQL0hMDnG7yDsR7nzF4s0hvmdQ+ArlU41c3dzHWh
	 S5JwkrT+3KFYvkGx5XyPPpH6WUFWQaXzF+SqQjHnRxQOoaxR0RG3WeFU6ph2eD5kNo
	 gCDVAmsaTkJ+Yi2jU/M5QKKbSpUNr3xP8DG7Wl96kSRSjDsBMxuEVqmnfw3NvF5rjO
	 c/Mm9vcliD4Xg==
Date: Sat, 17 Oct 2026 02:24:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: imu: Add driver for the ADI ADIS16607
Message-ID: <20261017022424.2788cb70@jic23-hlaptop>
In-Reply-To: <20261015-adis16607-v3-3-f972d4efee85@analog.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
	<20261015-adis16607-v3-3-f972d4efee85@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Oct 2026 12:33:00 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
>=20
> The ADIS16607 is a Precision MEMS IMU from Analog Devices with
> triaxial gyroscope and accelerometer, delta angle/velocity, and
> temperature channels, communicating over a custom SPI Half-Duplex
> protocol. ADIS16607-2 has a =C2=B1450=C2=B0/s gyroscope range, ADIS16607-3
> =C2=B12000=C2=B0/s; both share a =C2=B140g accelerometer range and an 8 k=
Hz internal
> clock.
>=20
> This is the base driver: probe, raw channel reads, sampling-frequency
> control, startup/self-test via adislib, and debugfs identity entries.
> No buffered capture, external clock sync, or calibration bias yet -
> those follow in later patches.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
Various comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
> new file mode 100644
> index 000000000000..1d471f59f043
> --- /dev/null
> +++ b/drivers/iio/imu/adis16607.c

> +struct adis16607 {
> +	const struct adis16607_chip_info *info;
> +	struct adis adis;
> +	unsigned long clk_freq;	/* millihertz */
> +	u64 sample_period_ns;
> +	/* IIO buffer for reordered data - sized for max channels */
> +	u8 data[64] __aligned(IIO_DMA_MINALIGN);

I guess this gets used in a later patch?  Add it there instead.

> +};

> +
> +/*
> + * SPI Half-Duplex write operation for ADIS16607.
> + * Protocol:
> + *   - Send 3 bytes: [reg, val_high, val_low]
> + *   - Only 16-bit writes are supported
> + */
> +static int adis16607_spi_write(struct adis *adis, unsigned int reg,
> +			       unsigned int val, unsigned int size)
> +{
> +	if (size !=3D 2)
> +		return -EINVAL;
> +
> +	adis->tx[0] =3D reg;
> +	adis->tx[1] =3D (val >> 8) & 0xFF;
> +	adis->tx[2] =3D val & 0xFF;

put_unaligned_be16()

as that will clearly document what is going on here.

> +
> +	return spi_write(adis->spi, adis->tx, 3);
> +}

> +/*
> + * Perform sensor self-test for ADIS16607.
> + * Reads self-test data before and after forcing self-test,
> + * then verifies delta values are within acceptable ranges.
> + */
> +static int adis16607_sensor_self_test(struct adis16607 *st)
> +{
> +	struct adis *adis =3D &st->adis;
> +	u16 st1_val[6], st2_val[6];
> +	s16 delta_max[6] =3D {
> +		ADIS16607_ACCEL_XY_DELTA_MAX,
> +		ADIS16607_ACCEL_XY_DELTA_MAX,
> +		ADIS16607_ACCEL_Z_DELTA_MAX,
> +		ADIS16607_GYRO_DELTA_MAX,
> +		ADIS16607_GYRO_DELTA_MAX,
> +		ADIS16607_GYRO_DELTA_MAX,
> +	};
> +	int ret, i;
> +
> +	/* Enable sensor self-test */
> +	ret =3D __adis_write_reg_16(adis, ADIS16607_REG_SELF_TEST,
> +				  ADIS16607_SNSR_SELF_TEST_MASK);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for self-test to settle before reading results */
> +	msleep(adis->data->timeouts->self_test_ms);
> +
> +	/* Read first set of self-test data */
> +	for (i =3D 0; i < 6; i++) {
> +		ret =3D __adis_read_reg_16(adis, ADIS16607_REG_SELF_TEST_DATA(i),
> +					 &st1_val[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Force self-test */
> +	ret =3D __adis_write_reg_16(adis, ADIS16607_REG_SELF_TEST,
> +				  ADIS16607_SNSR_SELF_TEST_MASK | ADIS16607_ST_FORCE_MASK);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for forced self-test to settle before reading results */
> +	msleep(adis->data->timeouts->self_test_ms);
> +
> +	/* Read second set of self-test data */
> +	for (i =3D 0; i < 6; i++) {
> +		ret =3D __adis_read_reg_16(adis, ADIS16607_REG_SELF_TEST_DATA(i),
> +					 &st2_val[i]);
> +		if (ret)
> +			return ret;
> +
> +		if (!adis16607_delta_check((s16)st1_val[i], (s16)st2_val[i],
> +					   delta_max[i])) {
> +			dev_err(&adis->spi->dev,
> +				"Self-test failed for axis %d: delta out of range\n", i);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* Clear self-test register */
> +	ret =3D __adis_write_reg_16(adis, ADIS16607_REG_SELF_TEST, 0);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
	return __adis_write_reg_16()

> +}


> +static int adis16607_get_freq(struct adis16607 *st, u32 *freq)
> +{
> +	u16 dec =3D 0;
> +	int ret;
> +
> +	mutex_lock(&st->adis.state_lock);
> +
> +	ret =3D __adis_read_reg_16(&st->adis, ADIS16607_REG_DEC_RATE, &dec);
> +	if (ret)
> +		goto unlock;
> +
> +	*freq =3D DIV_ROUND_CLOSEST(st->clk_freq, dec + 1);
> +
> +unlock:
> +	mutex_unlock(&st->adis.state_lock);

As below. We have guards for this and a special helper
to make them even easier to use for this lock.

> +	return ret;
> +}
> +
> +static int adis16607_set_freq(struct adis16607 *st, u32 freq)
> +{
> +	u32 dec;
> +	int ret;
> +
> +	if (!freq)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->adis.state_lock);

Use guard.  However, don't we have more specific helpers for these?

adis_dev_autolock()

> +
> +	dec =3D DIV_ROUND_CLOSEST(st->clk_freq, freq);
> +	if (dec)
> +		dec--;
> +
> +	dec =3D min_t(u32, dec, st->info->max_dec);
> +
> +	ret =3D __adis_write_reg_16(&st->adis, ADIS16607_REG_DEC_RATE, dec);
> +	if (!ret)
With a guard you can have the error path out of line.
Always do that unless it makes the code a lot less redable.
	if (ret)
		return ret;

	st->sample_period_ns =3D ...

> +		st->sample_period_ns =3D DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * 100=
0ULL * (dec + 1),
> +							     st->clk_freq);
> +
> +	mutex_unlock(&st->adis.state_lock);
> +	return ret;
> +}



> +#define ADIS16607_MOD_CHAN(_type, _mod, _address, _si, _bits) { \
> +	.type =3D (_type), \
> +	.modified =3D 1, \
> +	.channel2 =3D (_mod), \
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.address =3D (_address), \
> +	.scan_index =3D (_si), \
> +	.scan_type =3D { \
> +		.sign =3D 's', \
> +		.realbits =3D (_bits), \

Always 24?  If so hard code it.

> +		.storagebits =3D 32, \
> +		.endianness =3D IIO_BE, \
> +	}, \
> +}
> +
> +#define ADIS16607_ACCEL_CHANNEL(_mod) \
> +	ADIS16607_MOD_CHAN(IIO_ACCEL, IIO_MOD_ ## _mod, \
> +			   ADIS16607_REG_ ## _mod ## _ACCEL, \
> +			   ADIS16607_SCAN_ACCEL_ ## _mod, 24)
> +
> +#define ADIS16607_GYRO_CHANNEL(_mod) \
> +	ADIS16607_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_ ## _mod, \
> +			   ADIS16607_REG_ ## _mod ## _GYRO, \
> +			   ADIS16607_SCAN_GYRO_ ## _mod, 24)
> +
> +#define ADIS16607_TEMP_CHANNEL() { \
> +	.type =3D IIO_TEMP, \
> +	.indexed =3D 1, \
> +	.channel =3D 0, \
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> +			      BIT(IIO_CHAN_INFO_SCALE) | \
> +			      BIT(IIO_CHAN_INFO_OFFSET), \
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.address =3D ADIS16607_REG_TEMP, \
> +	.scan_index =3D ADIS16607_SCAN_TEMP, \
> +	.scan_type =3D { \
> +		.sign =3D 's', \
> +		.realbits =3D 16, \
> +		.storagebits =3D 16, \
> +		.endianness =3D IIO_BE, \
> +	}, \

Only one of these. Just put it inline.  The macro isn't adding anything
useful that I can see.

> +}
> +
> +#define ADIS16607_MOD_CHAN_DELTA(_type, _mod, _address, _si) { \
> +	.type =3D (_type), \
> +	.modified =3D 1, \
> +	.channel2 =3D (_mod), \
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.address =3D (_address), \
> +	.scan_index =3D (_si), \
> +	.scan_type =3D { \
> +		.sign =3D 's', \
> +		.realbits =3D 24, \
> +		.storagebits =3D 32, \
> +		.endianness =3D IIO_BE, \
> +	}, \
> +}
> +
> +#define ADIS16607_DELTANG_CHAN(_mod) \
> +	ADIS16607_MOD_CHAN_DELTA(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
> +				 ADIS16607_REG_ ## _mod ## _DELTANG, \
> +				 ADIS16607_SCAN_DELTANG_ ## _mod)
> +
> +#define ADIS16607_DELTVEL_CHAN(_mod) \
> +	ADIS16607_MOD_CHAN_DELTA(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
> +				 ADIS16607_REG_ ## _mod ## _DELTVEL, \
> +				 ADIS16607_SCAN_DELTVEL_ ## _mod)
> +
> +static const struct iio_chan_spec adis16607_channels[] =3D {
> +	ADIS16607_ACCEL_CHANNEL(X),
> +	ADIS16607_ACCEL_CHANNEL(Y),
> +	ADIS16607_ACCEL_CHANNEL(Z),
> +	ADIS16607_GYRO_CHANNEL(X),
> +	ADIS16607_GYRO_CHANNEL(Y),
> +	ADIS16607_GYRO_CHANNEL(Z),
> +	ADIS16607_DELTVEL_CHAN(X),
> +	ADIS16607_DELTVEL_CHAN(Y),
> +	ADIS16607_DELTVEL_CHAN(Z),
> +	ADIS16607_DELTANG_CHAN(X),
> +	ADIS16607_DELTANG_CHAN(Y),
> +	ADIS16607_DELTANG_CHAN(Z),
> +	ADIS16607_TEMP_CHANNEL(),
> +	IIO_CHAN_SOFT_TIMESTAMP(13),
> +};
> +
> +/*
> + * ADIS16607-2: 450 deg/s gyro, 40g accel
> + * ADIS16607-3: 2000 deg/s gyro, 40g accel
> + */
> +#define ADIS16607_CHIP_INFO_COMMON					\
> +	.channels	=3D adis16607_channels,				\
> +	.num_channels	=3D ARRAY_SIZE(adis16607_channels),		\
> +	.accel_max_val	=3D IIO_G_TO_M_S_2(40),				\
> +	.accel_max_scale =3D 31250 << 8,					\
> +	.temp_scale	=3D 5,						\
> +	.deltvel_max_val =3D IIO_G_TO_M_S_2(40),				\
> +	.int_clk	=3D 8000,						\
> +	.max_dec	=3D 65535

For only two instances, I'd just duplicate this in the assignments.

> +
> +static const struct adis16607_chip_info adis16607_2_chip_info =3D {
> +	ADIS16607_CHIP_INFO_COMMON,
> +	.name		=3D "adis16607-2",
> +	.gyro_max_val	=3D IIO_DEGREE_TO_RAD(450),
> +	.gyro_max_scale	=3D 30000 << 8,
> +	.deltang_max_val =3D IIO_DEGREE_TO_RAD(450),
> +};
> +
> +static const struct adis16607_chip_info adis16607_3_chip_info =3D {
> +	ADIS16607_CHIP_INFO_COMMON,
> +	.name		=3D "adis16607-3",
> +	.gyro_max_val	=3D IIO_DEGREE_TO_RAD(2000),
> +	.gyro_max_scale	=3D 31250 << 8,
> +	.deltang_max_val =3D IIO_DEGREE_TO_RAD(2000),
> +};


