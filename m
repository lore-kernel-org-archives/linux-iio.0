Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF5D30F934;
	Tue,  5 May 2026 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977425; cv=none; b=g3s0ALOhfTCy0V6S6ugfekH2JiTPabMLM2tNLcgVeQ5PR/SfDs+yddPks0K4QO1aqOQOIuPf5b9p/4Lvwjh/xcwpOrwuit+EPKthqhnyRBXi2CZi73Pl4+ygJOcSiqf0VyFXVhyKyQa2CLAcI+Koi5s3JxhTiVwodySlgnarS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977425; c=relaxed/simple;
	bh=m2cxWFgosGXezamqOi4F3sx9XNIEMtb9SqKJFoUDsXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBlAFxBvIuGUFw4uPlqQSwT10Rl5q5GKsPtSGGeyxjaktv2uJFLAou4A1g6wExnCpbC4miIBBv6WhufJ3D+lVrLjsIG4NSIQLtqYfoPHZ0787Jl/ATseZiT8y9stRjITSL81O4Z7fbYr1huHu0QG3PiaGCnIeWalOnrk4/8yuzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR3uM9Su; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR3uM9Su"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B458C2BCB4;
	Tue,  5 May 2026 10:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777977424;
	bh=m2cxWFgosGXezamqOi4F3sx9XNIEMtb9SqKJFoUDsXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CR3uM9SujYCroBkDXWTZb/7yRYotkT7Re/pZUo7yoWS/N0ZaZUDyZv9baBihrGJrW
	 /1FMgPv2Dxjo6059Pjs+iahM8ju0ErsOxnqcgnkNSwk+vOH+5w13/90c5ZqK+NZuVp
	 vunK5Xt5J6XRwa9laGKDdqzcFhgnF+Q+k6dw4zQRstPe3ZY/+tn79PygMPq5oyB0HN
	 cycO0pEfn+UBIOvY330k5hjWFgQ0zs77OYrJhYFX0nuRc4nxdDtrHNATXXT2ZYk1b2
	 tJQlolB0mLvYGwabZRDT1puAvZlgd5pzy+SRxI5QIQiJgouNXCZXh1FEBPUK4QpIFv
	 G7M0z4bFo/vTw==
Date: Tue, 5 May 2026 11:36:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 07/10] iio: imu: inv_icm42607: Add Accelerometer for
 icm42607
Message-ID: <20260505113654.0c21335e@jic23-huawei>
In-Reply-To: <20260501221152.194251-8-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
	<20260501221152.194251-8-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 May 2026 17:11:46 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add icm42607 accelerometer sensor for icm42607.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris

Various comments inline. For now at least drop the power
control custom ABI. I've strongly resisted this sort of thing
for a very long time because it is exceptionally hard to generalize
to anything that makes sense for userspace.   Look at what effects
that control actually has and present those as the means to pick
a mode from userspace.

Jonathan

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> new file mode 100644
> index 000000000000..d998d8c94eb9
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> @@ -0,0 +1,686 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/delay.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/common/inv_sensors_timestamp.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>

> +static const char * const inv_icm42607_accel_power_mode_items[] = {

This is non standard ABI that userspace will almost never know what to do with.
So we don't present it like this.  If it is possible to work out which mode
makes sense from other characteristics that are ABI use those. Otherwise,
default to low-noise and don't provide a control for this.

If you want to present a case for a power control framework it needs
to be a lot more descriptive of what is going on than this and suitable
for generalizing to lots of devices where the trade offs can be different.
Do that as a follow up series however to avoid delaying the rest of this.

> +	"low-noise",
> +	"low-power",
> +};
> +
> +static const int inv_icm42607_accel_power_mode_values[] = {
> +	INV_ICM42607_SENSOR_MODE_LOW_NOISE,
> +	INV_ICM42607_SENSOR_MODE_LOW_POWER,
> +};
> +
> +static const int inv_icm42607_accel_filter_values[] = {
> +	INV_ICM42607_FILTER_BW_25HZ,
> +	INV_ICM42607_FILTER_AVG_16X,
> +};
> +
> +static int inv_icm42607_accel_power_mode_set(struct iio_dev *indio_dev,
> +					     const struct iio_chan_spec *chan,
> +					     unsigned int idx)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
> +	int power_mode, filter;
> +
> +	if (chan->type != IIO_ACCEL)
> +		return -EINVAL;
> +
> +	if (idx >= ARRAY_SIZE(inv_icm42607_accel_power_mode_values))
> +		return -EINVAL;
> +
> +	power_mode = inv_icm42607_accel_power_mode_values[idx];
> +	filter = inv_icm42607_accel_filter_values[idx];
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* cannot change if accel sensor is on */
> +	if (st->conf.accel.mode != INV_ICM42607_SENSOR_MODE_OFF)
> +		return -EBUSY;
> +
> +	/* prevent change if power mode is not supported by the ODR */
> +	switch (power_mode) {
> +	case INV_ICM42607_SENSOR_MODE_LOW_NOISE:
> +		if (st->conf.accel.odr >= INV_ICM42607_ODR_6_25HZ_LP)
> +			return -EPERM;
> +		break;
> +	case INV_ICM42607_SENSOR_MODE_LOW_POWER:
> +	default:
> +		if (st->conf.accel.odr <= INV_ICM42607_ODR_800HZ)
> +			return -EPERM;
> +		break;
> +	}
> +
> +	accel_st->power_mode = power_mode;
> +	accel_st->filter = filter;
> +
> +	return 0;
> +}
> +
> +static int inv_icm42607_accel_power_mode_get(struct iio_dev *indio_dev,
> +					     const struct iio_chan_spec *chan)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
> +	unsigned int idx;
> +	int power_mode;
> +
> +	if (chan->type != IIO_ACCEL)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* if sensor is on, returns actual power mode and not configured one */
> +	switch (st->conf.accel.mode) {
> +	case INV_ICM42607_SENSOR_MODE_LOW_POWER:
> +	case INV_ICM42607_SENSOR_MODE_LOW_NOISE:
> +		power_mode = st->conf.accel.mode;
> +		break;
> +	default:
> +		power_mode = accel_st->power_mode;
> +		break;
> +	}
> +
> +	for (idx = 0; idx < ARRAY_SIZE(inv_icm42607_accel_power_mode_values); ++idx) {
> +		if (power_mode == inv_icm42607_accel_power_mode_values[idx])
> +			break;
> +	}
> +	if (idx >= ARRAY_SIZE(inv_icm42607_accel_power_mode_values))
> +		return -EINVAL;
> +
> +	return idx;
> +}
> +
> +static const struct iio_enum inv_icm42607_accel_power_mode_enum = {
> +	.items = inv_icm42607_accel_power_mode_items,
> +	.num_items = ARRAY_SIZE(inv_icm42607_accel_power_mode_items),
> +	.set = inv_icm42607_accel_power_mode_set,
> +	.get = inv_icm42607_accel_power_mode_get,
> +};
> +
> +static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
> +	IIO_ENUM_AVAILABLE("power_mode", IIO_SHARED_BY_TYPE,
> +			   &inv_icm42607_accel_power_mode_enum),
> +	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE,
> +		 &inv_icm42607_accel_power_mode_enum),
> +	{ }
> +};
> +
> +static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
> +	INV_ICM42607_ACCEL_CHAN(IIO_MOD_X, INV_ICM42607_ACCEL_SCAN_X,
> +				inv_icm42607_accel_ext_infos),
> +	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Y, INV_ICM42607_ACCEL_SCAN_Y,
> +				inv_icm42607_accel_ext_infos),
> +	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42607_ACCEL_SCAN_Z,
> +				inv_icm42607_accel_ext_infos),
> +	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
> +	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42607_ACCEL_SCAN_TIMESTAMP),
> +};
> +
> +static const struct iio_event_spec inv_icm42607_motion_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE),
> +	},
> +};
> +
> +/*
> + * IIO buffer data: size must be a power of 2 and timestamp aligned

This is generally true. I don't think we need to call it out in individual drivers.

> + * 16 bytes: 6 bytes acceleration, 2 bytes temperature, 8 bytes timestamp

This is just describing what we can see in the structure. Not sure it brings
much additional value so I'd drop it.

> + */
> +struct inv_icm42607_accel_buffer {
> +	struct inv_icm42607_fifo_sensor_data accel;
> +	s16 temp;
> +	aligned_s64 timestamp;
> +};
> +
> +#define INV_ICM42607_SCAN_MASK_ACCEL_3AXIS				\
> +	(BIT(INV_ICM42607_ACCEL_SCAN_X) |				\
> +	 BIT(INV_ICM42607_ACCEL_SCAN_Y) |				\
> +	 BIT(INV_ICM42607_ACCEL_SCAN_Z))
> +
> +#define INV_ICM42607_SCAN_MASK_TEMP	BIT(INV_ICM42607_ACCEL_SCAN_TEMP)
> +
> +static const unsigned long inv_icm42607_accel_scan_masks[] = {
> +	INV_ICM42607_SCAN_MASK_ACCEL_3AXIS,
> +	INV_ICM42607_SCAN_MASK_TEMP,
> +	INV_ICM42607_SCAN_MASK_ACCEL_3AXIS | INV_ICM42607_SCAN_MASK_TEMP,
> +	0,

That 0 is a terminating entry to the array so no trailing comma.

> +};
> +
> +/* enable accelerometer sensor and FIFO write */
> +static int inv_icm42607_accel_update_scan_mode(struct iio_dev *indio_dev,
> +					       const unsigned long *scan_mask)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	unsigned int fifo_en = 0;
> +	unsigned int sleep_temp = 0;
> +	unsigned int sleep_accel = 0;
> +	unsigned int sleep;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	if (*scan_mask & INV_ICM42607_SCAN_MASK_TEMP) {
> +		/* enable temp sensor */
> +		ret = inv_icm42607_set_temp_conf(st, true, &sleep_temp);
> +		if (ret)
> +			goto out_unlock;
> +		fifo_en |= INV_ICM42607_SENSOR_TEMP;
> +	}
> +
> +	if (*scan_mask & INV_ICM42607_SCAN_MASK_ACCEL_3AXIS) {
> +		/* enable accel sensor */
> +		conf.mode = accel_st->power_mode;
> +		conf.filter = accel_st->filter;
> +		ret = inv_icm42607_set_accel_conf(st, &conf, &sleep_accel);
> +		if (ret)
> +			goto out_unlock;
> +		fifo_en |= INV_ICM42607_SENSOR_ACCEL;
> +	}
> +
> +	/* update data FIFO write */
> +	ret = inv_icm42607_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
> +
> +out_unlock:
> +	mutex_unlock(&st->lock);
> +	/*
> +	 * Choose the highest enable-delay time of the two sensors being
> +	 * enabled, and sleep for that amount of time.
> +	 */
> +	sleep = max(sleep_accel, sleep_temp);
> +	msleep(sleep);
Might as well do

	msleep(max(sleep_accel, sleep_temp)); and save a line or two.

> +
> +	return ret;
> +}
> +
> +static int inv_icm42607_accel_read_sensor(struct iio_dev *indio_dev,
> +					  struct iio_chan_spec const *chan,
> +					  s16 *val)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	unsigned int reg;
> +	__be16 *data;
> +	int ret;
> +
> +	if (chan->type != IIO_ACCEL)
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg = INV_ICM42607_REG_ACCEL_DATA_X1;
> +		break;
> +	case IIO_MOD_Y:
> +		reg = INV_ICM42607_REG_ACCEL_DATA_Y1;
> +		break;
> +	case IIO_MOD_Z:
> +		reg = INV_ICM42607_REG_ACCEL_DATA_Z1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
> +		return -ENXIO;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* enable accel sensor */
> +	conf.mode = accel_st->power_mode;
> +	conf.filter = accel_st->filter;
> +	ret = inv_icm42607_set_accel_conf(st, &conf, NULL);
> +	if (ret)
> +		return ret;
> +
> +	/* read accel register data */
> +	data = (__be16 *)&st->buffer[0];

I believe it is already of that type so the cast isn't doing anything.

> +	ret = regmap_bulk_read(st->map, reg, data, sizeof(*data));
> +	if (ret)
> +		return ret;
> +
> +	*val = be16_to_cpup(data);
> +	if (*val == INV_ICM42607_DATA_INVALID)
> +		ret = -EINVAL;
		return -EINVAL;

	return 0;

to me is slightly easier to read as same patter as other early exits.


> +
> +	return ret;
> +}

> +
> +static int inv_icm42607_accel_read_scale(struct iio_dev *indio_dev,
> +					 int *val, int *val2)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	unsigned int idx;
> +
> +	idx = st->conf.accel.fs;
> +
> +	*val = inv_icm42607_accel_scale_nano[idx][0];
> +	*val2 = inv_icm42607_accel_scale_nano[idx][1];
> +	return IIO_VAL_INT_PLUS_NANO;
> +}
> +
> +static int inv_icm42607_accel_write_scale(struct iio_dev *indio_dev,
> +					  int val, int val2)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int idx;
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	int ret;
> +	size_t scales_len = ARRAY_SIZE(inv_icm42607_accel_scale_nano);
> +
> +	for (idx = 0; idx < scales_len; idx++) {
> +		if (val == inv_icm42607_accel_scale_nano[idx][0] &&
> +		    val2 == inv_icm42607_accel_scale_nano[idx][1])
> +			break;
> +	}
> +	if (idx >= scales_len)
> +		return -EINVAL;
> +
> +	conf.fs = idx;
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
> +		return -ENXIO;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = inv_icm42607_set_accel_conf(st, &conf, NULL);
> +
> +	return ret;

If this doesn't get updated later.
	return inv_icm...

> +}
> +
> +/* IIO format int + micro */
> +static const int inv_icm42607_accel_odr[] = {
> +	/* 1.5625Hz */
> +	1, 562500,

For these we often do them in an [][2] and cast it to
int * when using it in available. Tends to make indexing a little
easier elsewhere. Same as you've done for scale_nano above.


> +	/* 3.125Hz */
> +	3, 125000,
> +	/* 6.25Hz */
> +	6, 250000,
> +	/* 12.5Hz */
> +	12, 500000,
> +	/* 25Hz */
> +	25, 0,
> +	/* 50Hz */
> +	50, 0,
> +	/* 100Hz */
> +	100, 0,
> +	/* 200Hz */
> +	200, 0,
> +	/* 400Hz */
> +	400, 0,
> +	/* 800Hz */
> +	800, 0,
> +	/* 1600Hz */
> +	1600, 0,
> +};

> +
> +static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
> +					int val, int val2)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts = &accel_st->ts;
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int idx;
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	int ret;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(inv_icm42607_accel_odr); idx += 2) {
> +		if (val == inv_icm42607_accel_odr[idx] &&
> +			val2 == inv_icm42607_accel_odr[idx + 1])

Align as:
		if (val ==
		    val2 ==

> +			break;
> +	}
> +	if (idx >= ARRAY_SIZE(inv_icm42607_accel_odr))
> +		return -EINVAL;
> +
> +	conf.odr = inv_icm42607_accel_odr_conv[idx / 2];
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
> +		return -ENXIO;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = inv_sensors_timestamp_update_odr(ts, inv_icm42607_odr_to_period(conf.odr),
> +					       iio_buffer_enabled(indio_dev));
> +	if (ret)
> +		return ret;
> +
> +	ret = inv_icm42607_set_accel_conf(st, &conf, NULL);
> +	if (ret)
> +		return ret;
> +
> +	inv_icm42607_buffer_update_fifo_period(st);
> +	inv_icm42607_buffer_update_watermark(st);
> +
> +	return ret;

	return 0;

> +}

> +
> +struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	const char *name;
> +	struct inv_icm42607_sensor_state *accel_st;
> +	struct inv_sensors_timestamp_chip ts_chip;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL, "%s-accel", st->name);
> +	if (!name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*accel_st));
> +	if (!indio_dev)
> +		return ERR_PTR(-ENOMEM);
> +	accel_st = iio_priv(indio_dev);
> +
> +	accel_st->power_mode = INV_ICM42607_SENSOR_MODE_LOW_POWER;
> +	accel_st->filter = INV_ICM42607_FILTER_AVG_16X;
> +
> +	/*
> +	 * clock period is 32kHz (31250ns)
> +	 * jitter is +/- 2% (20 per mille)
> +	 */
> +	ts_chip.clock_period = 31250;
> +	ts_chip.jitter = 20;
> +	ts_chip.init_period = inv_icm42607_odr_to_period(st->conf.accel.odr);
> +	inv_sensors_timestamp_init(&accel_st->ts, &ts_chip);
> +
> +	iio_device_set_drvdata(indio_dev, st);
> +	indio_dev->name = name;
> +	indio_dev->info = &inv_icm42607_accel_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;

INDIO_BUFFER_SOFTWARE is set in devm_iio_kifo_buffer_setup() so no
need to set it here.

> +	indio_dev->channels = inv_icm42607_accel_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(inv_icm42607_accel_channels);
> +	indio_dev->available_scan_masks = inv_icm42607_accel_scan_masks;
> +
> +	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
> +					  &inv_icm42607_buffer_ops);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	/* accel events are wakeup capable */
> +	ret = devm_device_init_wakeup(&indio_dev->dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return indio_dev;
> +}
> +
> +int inv_icm42607_accel_parse_fifo(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts = &accel_st->ts;
> +	ssize_t i, size;
> +	unsigned int no;
> +	const void *accel, *gyro, *timestamp;
> +	const int8_t *temp;
> +	unsigned int odr;
> +	int64_t ts_val;
> +	struct inv_icm42607_accel_buffer buffer = { };
> +
> +	/* parse all fifo packets */
> +	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
> +		size = inv_icm42607_fifo_decode_packet(&st->fifo.data[i],
> +				&accel, &gyro, &temp, &timestamp, &odr);
> +		/* quit if error or FIFO is empty */
> +		if (size <= 0)
> +			return size;
> +
> +		/* skip packet if no accel data or data is invalid */
> +		if (accel == NULL || !inv_icm42607_fifo_is_data_valid(accel))
> +			continue;
> +
> +		/* update odr */
> +		if (odr & INV_ICM42607_SENSOR_ACCEL) {

No {} needed for single statement.  The kernel coding style gets a bit vague
on multi line single statements but here I don't see dropping the {} as adding
an confusion.

> +			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
> +							st->fifo.nb.total, no);
> +		}
> +
> +		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
> +		/* convert 8 bits FIFO temperature in high resolution format */
> +		buffer.temp = temp ? (*temp * 64) : 0;
> +		ts_val = inv_sensors_timestamp_pop(ts);
> +		iio_push_to_buffers_with_ts(indio_dev, &buffer,
> +					    sizeof(buffer), ts_val);
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> index 5c67f6a37520..34698b429c2e 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c

>  int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
>  				     unsigned int count)
>  {
> +	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
> +	struct inv_sensors_timestamp *ts;
>  	s64 gyro_ts, accel_ts;
>  	int ret;
>  
> @@ -466,8 +500,21 @@ int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
>  	accel_ts = iio_get_time_ns(st->indio_accel);
>  
>  	ret = inv_icm42607_buffer_fifo_read(st, count);
> +	if (ret)
> +		return ret;
>  
> -	return ret;
This is the change I referred to earlier when suggesting a minor edit to 
reduce churn.

> +	if (st->fifo.nb.total == 0)
> +		return 0;
> +
> +	if (st->fifo.nb.accel > 0) {
> +		ts = &accel_st->ts;
> +		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
> +		ret = inv_icm42607_accel_parse_fifo(st->indio_accel);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  int inv_icm42607_buffer_init(struct inv_icm42607_state *st)
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 77b9a633d31a..5c2010d8256f 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

> @@ -164,6 +173,53 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
>  	return 0;
>  }
>  
> +int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
> +				struct inv_icm42607_sensor_conf *conf,
> +				unsigned int *sleep_ms)
> +{
> +	struct inv_icm42607_sensor_conf *oldconf = &st->conf.accel;

Given you update it throughout, the oldconf naming seems inconsistent.
It becomes new conf.  Maybe come up with a different name?

> +	unsigned int val;
> +	int ret;
> +
> +	if (conf->mode < 0)
> +		conf->mode = oldconf->mode;
> +	if (conf->fs < 0)
> +		conf->fs = oldconf->fs;
> +	if (conf->odr < 0)
> +		conf->odr = oldconf->odr;
> +	if (conf->filter < 0)
> +		conf->filter = oldconf->filter;

There is a patch kicking around for the older invensense drivers.
Whilst it does too much deduplication the helper for this section makes sense to me
given it's going to turn up a lot. Probably makes sense to do that here as well.


> +
> +	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
> +		val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->fs);
> +		val |= FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->odr);
> +		ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
> +		if (ret)
> +			return ret;
> +		oldconf->fs = conf->fs;
> +		oldconf->odr = conf->odr;
> +	}
> +
> +	if (conf->filter != oldconf->filter) {
> +		if (conf->mode == INV_ICM42607_SENSOR_MODE_LOW_POWER) {
> +			val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_AVG_MASK, conf->filter);
> +			ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
> +						 INV_ICM42607_ACCEL_CONFIG1_AVG_MASK, val);
> +		} else {
> +			val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK,
> +					 conf->filter);
> +			ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
> +						 INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK, val);
> +		}
> +		if (ret)
> +			return ret;
> +		oldconf->filter = conf->filter;
> +	}
> +
> +	return inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode, conf->mode,
> +					  st->conf.temp_en, sleep_ms);
> +}

