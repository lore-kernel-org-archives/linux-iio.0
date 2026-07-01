Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5F340400;
	Wed,  1 Jul 2026 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933887; cv=none; b=D08FfnG6orlNrxiOxNI0IKMW5BuXs+7a2Qw0ER1uRtxFslmVq05GFNss+X/68efHP5H//xHWnG5abcDQQ3TMrX8uAIyJPRTNZn/4XHVbDfePELRSfyAp+ayDG3WEI+VG+MIrXSa8vDhP456K5aL9lots8PvWHhSjOWl+7imL4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933887; c=relaxed/simple;
	bh=A1cJ+m0uaDFcRmDL4dNtAaoqSyT0eUcKJBmrh7w1R+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUoJ32Tc2j4411n3VSQd1A/xXRe3JPL8lNjuq/enJagfpYXPjMmQL5Yy07v9EMvJvNV2BZF76gb5zCZA8aIW/f5rpK3b+35GIFMzDyO567bcTy4OvdpVcla78quep+wdhyP369SVZq6f4LIUX3qEc8qn77KiY0CuSqsBor/hRa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHoVdPMJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHoVdPMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8329A1F000E9;
	Wed,  1 Jul 2026 19:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782933885;
	bh=q8kKGc14cZ4z6L10gn228I44wkjJQG6Ee36tf+xwsys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NHoVdPMJlowTeLYVMn5LGZB+V6p5MfIFAbwuoHvSN+S6iETWtv+gGAl86DNhHQw30
	 9iRTWUhxx1O7m5opFncHHMvOMeZYp/p3fdAVg2lmlckt7oXh/+cV+7XynblXi3+05N
	 Jonv9gcEcPMMh+TCsxI3Zt75HMkjAdRLVm06DxdM1kXYupvLSVFOdbl6vWtp+CTx65
	 XdAYZfq3X6WpPN3pQTstDNvl0wC2g/OmAh3MnO46gIL1QpZUjezYfxOaCk/Zfkw0Ei
	 vJaXNI/bbJj9a52MgATVcJDWmV2mrjcCeK6ELv507D+o9tMaN0O7k0gtrCF/7YY8pD
	 BSLntlFZLXiUg==
Date: Wed, 1 Jul 2026 20:24:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V15 6/9] iio: imu: inv_icm42607: Add Accelerometer for
 icm42607
Message-ID: <20260701202441.4da5e535@jic23-huawei>
In-Reply-To: <20260626161230.93069-7-macroalpha82@gmail.com>
References: <20260626161230.93069-1-macroalpha82@gmail.com>
	<20260626161230.93069-7-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 11:12:27 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add icm42607 accelerometer sensor for icm42607.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris,

A few things in here.

Thanks,

Jonathan

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> new file mode 100644
> index 000000000000..8ef9fdae1bc8
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c

> +
> +/* IIO format int + micro , values 0-5 reserved. */

As sashiko notes, 5 is set, so probably 0-4 reserved?

> +static const int inv_icm42607_accel_odr[][2] = {
> +	[INV_ICM42607_ODR_1600HZ] = { 1600, 0 },
> +	[INV_ICM42607_ODR_800HZ] = { 800, 0 },
> +	[INV_ICM42607_ODR_400HZ] = { 400, 0 },
> +	[INV_ICM42607_ODR_200HZ] = { 200, 0 },
> +	[INV_ICM42607_ODR_100HZ] = { 100, 0 },
> +	[INV_ICM42607_ODR_50HZ] = { 50, 0 },
> +	[INV_ICM42607_ODR_25HZ] = { 25, 0 },
> +	[INV_ICM42607_ODR_12_5HZ] = { 12, 500000 },
> +	[INV_ICM42607_ODR_6_25HZ_LP] = { 6, 250000 },
> +	[INV_ICM42607_ODR_3_125HZ_LP] = { 3, 125000 },
> +	[INV_ICM42607_ODR_1_5625HZ_LP] = { 1, 562500 },
> +};
> +
> +static int inv_icm42607_accel_read_odr(struct inv_icm42607_state *st,
> +				       int *val, int *val2)
> +{
> +	unsigned int odr;
> +	unsigned int i;
> +
> +	guard(mutex)(&st->lock);
> +
> +	odr = st->conf.accel.odr;
> +
> +	for (i = 5; i < ARRAY_SIZE(inv_icm42607_accel_odr); ++i) {

As below. Also, why the preincrement?  Common practice in kernel
is postincrement unless it matters.

> +		if (i == odr)
> +			break;
> +	}
> +	if (i >= ARRAY_SIZE(inv_icm42607_accel_odr))
> +		return -EINVAL;
> +
> +	*val = inv_icm42607_accel_odr[i][0];
> +	*val2 = inv_icm42607_accel_odr[i][1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
> +					int val, int val2)
> +{
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int idx;
> +	int ret;
> +
> +	for (idx = 5; idx < ARRAY_SIZE(inv_icm42607_accel_odr); ++idx) {

Maybe use the define rather than 5 for the start point?
As it stands that 5 looks a bit magic :)
Similar to above on the preincrement

> +		if (val == inv_icm42607_accel_odr[idx][0] &&
> +		    val2 == inv_icm42607_accel_odr[idx][1])
> +			break;
> +	}
> +	if (idx >= ARRAY_SIZE(inv_icm42607_accel_odr))
> +		return -EINVAL;

> +
> +static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
> +				       struct iio_chan_spec const *chan,
> +				       int *val, int *val2, long mask)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	s16 data;
> +	int ret;
> +
> +	switch (chan->type) {
> +	case IIO_ACCEL:

Same issue as for avail for samp_freq as it is shared_by_all and later
you add the temperature channel. (I admit we cheat in a similar way
for timestamp channels which strictly speaking should have all the
shared_by_all values set).  Still nice to do better here and not
add ordering constraints to channel definitions!


> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = inv_icm42607_read_sensor(indio_dev, chan, &data);
> +		if (ret)
> +			return ret;
> +		*val = data;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		return inv_icm42607_accel_read_scale(indio_dev, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return inv_icm42607_accel_read_odr(st, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int inv_icm42607_accel_read_avail(struct iio_dev *indio_dev,
> +					 struct iio_chan_spec const *chan,
> +					 const int **vals,
> +					 int *type, int *length, long mask)
> +{
> +	if (chan->type != IIO_ACCEL)
> +		return -EINVAL;

Not sure why sashiko only moaned on the gyro, as same issue here. 
After temperature support is added we have that as a possible channel for
read_avail for the sampling frequency but that patch doesn't change this
check.  So it works because of channel ordering and that a different channel
is associated with that sysfs attribute. That is messy so this should
handle temperature as well. Perhaps push this check into the IIO_CHAN_INFO_SCALE
case only?
 
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (const int *)inv_icm42607_accel_scale_nano;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		*length = ARRAY_SIZE(inv_icm42607_accel_scale_nano) * 2;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = (const int *)inv_icm42607_accel_odr[5];
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = (ARRAY_SIZE(inv_icm42607_accel_odr) - 5) * 2;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 738970ed5c66..300c583aba81 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

> +int inv_icm42607_set_sensor_conf(struct inv_icm42607_state *st,
> +				 struct inv_icm42607_sensor_conf *conf,
> +				 enum iio_chan_type chan_type)
> +{
> +	struct inv_icm42607_sensor_conf *oldconf;
> +	bool config0, config1;
> +	unsigned int val;
> +	int ret;
> +
> +	switch (chan_type) {
> +	case IIO_ACCEL:
> +		oldconf = &st->conf.accel;
> +		break;
> +	case IIO_ANGL_VEL:
> +		oldconf = &st->conf.gyro;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	inv_icm42607_update_config(conf, oldconf, &config0, &config1);
> +
> +	if (config0) {
> +		if (chan_type == IIO_ANGL_VEL) {
> +			val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK, conf->fs);
> +			val |= FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK, conf->odr);

Looking again at this code, it would be fairly easy to stash masks and registers in
a pair of structs that we pick between based on channel type, but maybe it's not worth
the effort. Up to you.

> +			ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
> +		} else {
> +			val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->fs);
> +			val |= FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->odr);
> +			ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
> +		}
> +		if (ret)
> +			return ret;
> +
> +		oldconf->fs = conf->fs;
> +		oldconf->odr = conf->odr;
> +	}
> +
> +	if (config1) {
> +		if (chan_type == IIO_ANGL_VEL) {
> +			val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG1_FILTER_MASK,
> +					 conf->filter);
> +			ret = regmap_update_bits(st->map, INV_ICM42607_REG_GYRO_CONFIG1,
> +						 INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, val);
> +		} else {
> +			val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK,
> +					 conf->filter);
> +			ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
> +						 INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK, val);
> +		}
> +		if (ret)
> +			return ret;
> +
> +		oldconf->filter = conf->filter;
> +	}
> +
> +	if (chan_type == IIO_ANGL_VEL)

I'd be tempted to do this with a switch just to match the style for the similar
per channel type block above.

> +		return inv_icm42607_set_pwr_mgmt0(st, conf->mode, st->conf.accel.mode);
> +
> +	return inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode, conf->mode);
> +}
