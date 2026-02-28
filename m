Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB133D6D3;
	Sat, 28 Feb 2026 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772304734; cv=none; b=eDEIGj5rEjpHolpUvFLefPf/L6+g4rsCJkDW+bR2IJUJKpDNVkWcqy5y0Uj3mQ12Va2Kg+HRmYU46doNMqN489z4euG3jEzsZdv/KJCyADKNiiP69k+kWD/TVeieOr81w91CebZ9rBtISJ8uZ9qMKLtxZZRhn9BC/njZljHV+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772304734; c=relaxed/simple;
	bh=9JUOdKhs+7nAfGHKcbV2HtDPPvJzHBA2GAPggl8y2VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZB7+jMv/1EsHeEr/5VtPvn24NqIea2QJjgwxFF5El+062HDurDL8fE/YF2iMoPGklNZyVgDywFITR5YrYvKQkzsGU3ofCIZbIICYWadUfWducckz437PyWrCZf1oeRDHph1c2Q4CvbY93cQQuHCDVIveH5cPgw9LOsMRRZ4FHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSrumuKF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSrumuKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CCFC19423;
	Sat, 28 Feb 2026 18:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772304733;
	bh=9JUOdKhs+7nAfGHKcbV2HtDPPvJzHBA2GAPggl8y2VQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XSrumuKFU8mhhspbfei4ag8xodeG+YORibjzmOgsGRb74euq7FiznsVPVtga97A3z
	 +V8hA7kK2uCePSfzWYgUJtxKaki27brM+wphfvAUKA7wf5TLFldbTqzaiHdXJAdUZb
	 qIqgCfIvSNzZQuccWqkzSTRXnfVCGAiVk2Gi5yZ9Da5/FjWdsDV0O10yc2u9ebzlFR
	 77Cx6BWSgb+bFqueCWymjeoSYkmWVAMU1O6NWNHIfT3gavaehvKUId9g/ERLBL6T7a
	 QZ8wtz640+9UCMuGZkihy5EZYYWyssxXtT+uoNddyCJ148Va3oOZ96+B7DzvwF9ql/
	 kVtyesf8atPoQ==
Date: Sat, 28 Feb 2026 18:52:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 2/3] iio: imu: inv_icm42607: add new inv_icm42607 driver
Message-ID: <20260228185202.13d09e27@jic23-huawei>
In-Reply-To: <20260224163109.370930-3-macroalpha82@gmail.com>
References: <20260224163109.370930-1-macroalpha82@gmail.com>
	<20260224163109.370930-3-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Feb 2026 10:31:04 -0600
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add a new driver for the Invensense ICM42607 IMU. This device is
> extremely similar to the existing ICM42600 but with a very different
> register layout.
> 
> This driver was built based on the existing icm42600 along with
> the datasheet from Invensense and out-of-tree sources included
> in the LineageOS kernels [1] and Rockchip kernels [2], both derived
> from sources provided by Invensense. The driver is structured
> identically to the in-tree ICM42600 driver.
> 
> It should work for the ICM42607 and ICM42607P on both the I2C and
> SPI busses, however only the ICM42607P over I2C has been tested
> as it is the only hardware I have available.
> 
> [1] https://github.com/LineageOS/android_kernel_nvidia_kernel-nx/tree/lineage-23.0/drivers/iio/imu/inv_icm42607x
> [2] https://github.com/rockchip-linux/kernel/tree/develop-6.6/drivers/iio/imu/inv_icm42670
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris,

I decided to take a quick look to hopefully be able to point out some minor
things that make sense to fix for your split up version.

Jonathan

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> new file mode 100644
> index 000000000000..a275f24bf291
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -0,0 +1,472 @@

> +
> +/* ODR values */
> +enum inv_icm42607_odr {
> +	INV_ICM42607_ODR_1600HZ = 5,
> +	INV_ICM42607_ODR_800HZ,
> +	INV_ICM42607_ODR_400HZ,
> +	INV_ICM42607_ODR_200HZ,
> +	INV_ICM42607_ODR_100HZ,
> +	INV_ICM42607_ODR_50HZ,
> +	INV_ICM42607_ODR_25HZ,
> +	INV_ICM42607_ODR_12_5HZ,
> +	INV_ICM42607_ODR_6_25HZ_LP,
> +	INV_ICM42607_ODR_3_125HZ_LP,
> +	INV_ICM42607_ODR_1_5625HZ_LP,
> +	INV_ICM42607_ODR_NB,
This is another type of terminating entry, so no comma.
(see below for more on this and make sure to fix all the cases of the same thing)
> +};

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> new file mode 100644
> index 000000000000..92cf7ffe5077
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> @@ -0,0 +1,566 @@

> +
> +static size_t inv_icm42607_get_packet_size(unsigned int fifo_en)
> +{
> +	size_t packet_size;
> +
> +	if ((fifo_en & INV_ICM42607_SENSOR_GYRO) &&
> +	    (fifo_en & INV_ICM42607_SENSOR_ACCEL))
> +		packet_size = INV_ICM42607_FIFO_2SENSORS_PACKET_SIZE;
> +	else
> +		packet_size = INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE;
> +
> +	return packet_size;
Not a lot of point in the local variable. I'd get rid of it and just do
		return INV_ICM42607_FIFO_2SENSORS_PACKET_SIZE;
> +}
> +
>
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
> new file mode 100644
> index 000000000000..6d8d7fa7bd13
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> new file mode 100644
> index 000000000000..9b69ccb1d101
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -0,0 +1,811 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +
> +#include "inv_icm42607.h"
> +#include "inv_icm42607_buffer.h"
> +
> +static const struct regmap_range_cfg inv_icm42607_regmap_ranges[] = {
> +	{
> +		.name = "user bank",
> +		.range_min = 0x0000,
> +		.range_max = 0x00FF,
> +		.selector_reg = 0, /* not used */
> +		.selector_mask = 0, /* not used */
> +		.selector_shift = 0, /* not used */

The defaults of these are otherwise 0.  So what's the point in setting
them explicitly here?  I don't mind if it provides useful educational value.

> +		.window_start = 0,
> +		.window_len = 0x0100,
> +	},
> +};
>
> +
> +u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr)
> +{
> +	static u32 odr_periods[INV_ICM42607_ODR_NB] = {
> +		/* Reserved values */
> +		0, 0, 0, 0, 0,
> +		/* 1600Hz */

As below I'd add comments to line with the value they are referring to.

> +		625000,
> +		/* 800Hz */
> +		1250000,
> +		/* 400Hz */
> +		2500000,
> +		/* 200Hz */
> +		5000000,
> +		/* 100 Hz */
> +		10000000,
> +		/* 50Hz */
> +		20000000,
> +		/* 25Hz */
> +		40000000,
> +		/* 12.5Hz */
> +		80000000,
> +		/* 6.25Hz */
> +		160000000,
> +		/* 3.125Hz */
> +		320000000,
> +		/* 1.5625Hz */
> +		640000000,
> +	};
> +
> +	return odr_periods[odr];
> +}

> +static irqreturn_t inv_icm42607_irq_handler(int irq, void *_data)
> +{
> +	struct inv_icm42607_state *st = _data;
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int status;
> +	int ret;
> +
> +	mutex_lock(&st->lock);

guard() and direct returns should make this easier to read.


> +
> +	if (st->apex.on) {
> +		unsigned int status2, status3;
> +
> +		/* read INT_STATUS2 and INT_STATUS3 in 1 operation */
> +		ret = regmap_bulk_read(st->map, INV_ICM42607_REG_INT_STATUS2, st->buffer, 2);
> +		if (ret)
> +			goto out_unlock;
> +		status2 = st->buffer[0];
> +		status3 = st->buffer[1];
> +		inv_icm42607_accel_handle_events(st->indio_accel, status2, status3,
> +						 st->timestamp.accel);
> +	}
> +
> +	ret = regmap_read(st->map, INV_ICM42607_REG_INT_STATUS, &status);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (status & INV_ICM42607_INT_STATUS_FIFO_FULL)
> +		dev_warn(dev, "FIFO full data lost!\n");
> +
> +	if (status & INV_ICM42607_INT_STATUS_FIFO_THS) {
> +		ret = inv_icm42607_buffer_fifo_read(st, 0);
> +		if (ret) {
> +			dev_err(dev, "FIFO read error %d\n", ret);
> +			goto out_unlock;
> +		}
> +		ret = inv_icm42607_buffer_fifo_parse(st);
> +		if (ret)
> +			dev_err(dev, "FIFO parsing error %d\n", ret);
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&st->lock);
> +	return IRQ_HANDLED;
> +}

> +
> +static int inv_icm42607_runtime_suspend(struct device *dev)
> +{
> +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> +	int ret = 0;

always set, so don't initialise here.

> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
> +					 INV_ICM42607_SENSOR_MODE_OFF, false,
> +					 NULL);
> +	if (ret)
> +		return ret;
> +
> +	regulator_disable(st->vddio_supply);
> +
> +	return 0;
> +}

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> new file mode 100644
> index 000000000000..e3a873185569
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> @@ -0,0 +1,578 @@
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
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/common/inv_sensors_timestamp.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>

Some of these seem unlikely. Make sure they are all used in this
file. I haven't checked, so may be fine.

> +
> +static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
> +	{},

	{ }

> +};

> +/*
> + * IIO buffer data: size must be a power of 2 and timestamp aligned
> + * 16 bytes: 6 bytes angular velocity, 2 bytes temperature, 8 bytes timestamp
> + */
> +struct inv_icm42607_gyro_buffer {
> +	struct inv_icm42607_fifo_sensor_data gyro;
> +	s16 temp;
> +	aligned_s64 timestamp;
> +};

> +static const unsigned long inv_icm42607_gyro_scan_masks[] = {
> +	/* 3-axis gyro + temperature */
> +	INV_ICM42607_SCAN_MASK_GYRO_3AXIS | INV_ICM42607_SCAN_MASK_TEMP,
> +	0,
It's a terminating entry so drop the comma (more below) - note that
I review backwards so sometimes review comments may feel odd if you
read them forwards.

> +};
> +
> +/* enable gyroscope sensor and FIFO write */
> +static int inv_icm42607_gyro_update_scan_mode(struct iio_dev *indio_dev,
> +					      const unsigned long *scan_mask)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	unsigned int fifo_en = 0;
> +	unsigned int sleep_gyro = 0;
> +	unsigned int sleep_temp = 0;
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
> +	if (*scan_mask & INV_ICM42607_SCAN_MASK_GYRO_3AXIS) {
> +		/* enable gyro sensor */
> +		conf.mode = INV_ICM42607_SENSOR_MODE_LOW_NOISE;
> +		ret = inv_icm42607_set_gyro_conf(st, &conf, &sleep_gyro);
> +		if (ret)
> +			goto out_unlock;
> +		fifo_en |= INV_ICM42607_SENSOR_GYRO;
> +	}
> +
> +	/* update data FIFO write */
> +	ret = inv_icm42607_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
> +	if (ret)
> +		goto out_unlock;
Why. It's right there.  Drop this gotot.  
> +
> +out_unlock:
> +	mutex_unlock(&st->lock);
> +	/* sleep maximum required time */
> +	sleep = max(sleep_gyro, sleep_temp);
> +	if (sleep)
> +		msleep(sleep);
> +	return ret;
> +}
> +


> +
> +static int inv_icm42607_gyro_write_scale(struct iio_dev *indio_dev,
> +					 int val, int val2)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42607_sensor_state *gyro_st = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int idx;
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	int ret;
> +
> +	for (idx = 0; idx < gyro_st->scales_len; idx += 2) {
> +		if (val == gyro_st->scales[idx] &&
> +		    val2 == gyro_st->scales[idx + 1])
> +			break;
> +	}
> +	if (idx >= gyro_st->scales_len)
> +		return -EINVAL;
> +
> +	conf.fs = idx / 2;
> +
> +	pm_runtime_get_sync(dev);
Firstly can always fail so these all need checks.
Secondly this would be neater with the scoped based runtime pm stuff I mention
below
> +
> +	scoped_guard(mutex, &st->lock)
After the other change use
	guard(mutex)(&st->lock);
	return inv_icm...

Applies in at least a few other places.


> +		ret = inv_icm42607_set_gyro_conf(st, &conf, NULL);
> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +/* IIO format int + micro */
> +static const int inv_icm42607_gyro_odr[] = {
> +	/* 12.5Hz */
> +	12, 500000,

	12, 500000, /* 12.5Hz */

etc if you do want to add the comments. Too much scrolling otherwise!
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
>
> +
> +static int inv_icm42607_gyro_write_odr(struct iio_dev *indio_dev,
> +				       int val, int val2)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42607_sensor_state *gyro_st = iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts = &gyro_st->ts;
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int idx;
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	int ret;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(inv_icm42607_gyro_odr); idx += 2) {
> +		if (val == inv_icm42607_gyro_odr[idx] &&
> +			val2 == inv_icm42607_gyro_odr[idx + 1])
Align as
		if (val ==...
		    val2 == ...

> +			break;
> +	}
> +	if (idx >= ARRAY_SIZE(inv_icm42607_gyro_odr))
> +		return -EINVAL;
> +
> +	conf.odr = inv_icm42607_gyro_odr_conv[idx / 2];
> +
> +	pm_runtime_get_sync(dev);
> +	mutex_lock(&st->lock);
> +
> +	ret = inv_sensors_timestamp_update_odr(ts, inv_icm42607_odr_to_period(conf.odr),
> +					       iio_buffer_enabled(indio_dev));
> +	if (ret)
> +		goto out_unlock;
> +
> +	ret = inv_icm42607_set_gyro_conf(st, &conf, NULL);
> +	if (ret)
> +		goto out_unlock;
> +	inv_icm42607_buffer_update_fifo_period(st);
> +	inv_icm42607_buffer_update_watermark(st);
> +
> +out_unlock:
> +	mutex_unlock(&st->lock);
> +	pm_runtime_put_autosuspend(dev);
As below. Look at whether you can use guard() and the runtime PM acquire
to simplify the code flow in this function.

> +
> +	return ret;
> +}

> +struct iio_dev *inv_icm42607_gyro_init(struct inv_icm42607_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	const char *name;
> +	struct inv_icm42607_sensor_state *gyro_st;
> +	struct inv_sensors_timestamp_chip ts_chip;

If no other order makes sense, reverse xmas tree is usually fine for kernel code.
What we don't like is lack of an obvious reason for the order.

> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->name);
> +	if (!name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*gyro_st));
> +	if (!indio_dev)
> +		return ERR_PTR(-ENOMEM);
> +	gyro_st = iio_priv(indio_dev);
> +
> +	gyro_st->scales = inv_icm42607_gyro_scale;
> +	gyro_st->scales_len = ARRAY_SIZE(inv_icm42607_gyro_scale);
> +
> +	/*
> +	 * clock period is 32kHz (31250ns)
> +	 * jitter is +/- 2% (20 per mille)
> +	 */
> +	ts_chip.clock_period = 31250;
> +	ts_chip.jitter = 20;
> +	ts_chip.init_period = inv_icm42607_odr_to_period(st->conf.accel.odr);
> +	inv_sensors_timestamp_init(&gyro_st->ts, &ts_chip);
> +
> +	iio_device_set_drvdata(indio_dev, st);
> +	indio_dev->name = name;
> +	indio_dev->info = &inv_icm42607_gyro_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->channels = inv_icm42607_gyro_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(inv_icm42607_gyro_channels);
> +	indio_dev->available_scan_masks = inv_icm42607_gyro_scan_masks;
> +	indio_dev->setup_ops = &inv_icm42607_buffer_ops;
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
> +	return indio_dev;
> +}
> +
> +int inv_icm42607_gyro_parse_fifo(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42607_sensor_state *gyro_st = iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts = &gyro_st->ts;
> +	ssize_t i, size;
> +	unsigned int no;
> +	const void *accel, *gyro, *timestamp;
> +	const s8 *temp;
> +	unsigned int odr;
> +	s64 ts_val;
> +	struct inv_icm42607_gyro_buffer buffer = { };
> +
> +	/* parse all fifo packets */
> +	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {

	for (ssize_t i = 0, unsigned int no = 0; i < ...

Plus reduce the scope of some of the variables above to inside this loop
by declaring them here.

> +		size = inv_icm42607_fifo_decode_packet(&st->fifo.data[i],
> +				&accel, &gyro, &temp, &timestamp, &odr);
> +		/* quit if error or FIFO is empty */
> +		if (size <= 0)
> +			return size;
> +
> +		/* skip packet if no gyro data or data is invalid */
> +		if (gyro == NULL || !inv_icm42607_fifo_is_data_valid(gyro))
> +			continue;
> +
> +		/* update odr */
> +		if (odr & INV_ICM42607_SENSOR_GYRO) {
> +			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
> +							st->fifo.nb.total, no);
> +		}
> +
> +		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
> +		/* convert 8 bits FIFO temperature in high resolution format */
> +		buffer.temp = temp ? (*temp * 64) : 0;
> +		ts_val = inv_sensors_timestamp_pop(ts);
> +		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);

Please use iio_push_to_buffers_with_ts() in new code.

> +	}
> +
> +	return 0;
> +}

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> new file mode 100644
> index 000000000000..51ce3deeb706
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/kernel.h>

Look at what is actually used. It is rare a modern driver should be including the
catch all headers kernel.h and device.h.  There are much more specific headers
that are normally an improvement.

> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +#include <linux/property.h>

Not seeing this used.  Check for other headers and make sure they are
only included where things they define are included.


> +
> +#include "inv_icm42607.h"
> +
> +static int inv_icm42607_spi_bus_setup(struct inv_icm42607_state *st)
> +{
> +	unsigned int mask, val;
> +	int ret;
> +
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_DEVICE_CONFIG,
> +				 INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE,
> +				 INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE);

regmap_set_bits() avoids duplicating that field mask.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
> +				 INV_ICM42607_INTF_CONFIG1_I3C_DDR_EN |
> +				 INV_ICM42607_INTF_CONFIG1_I3C_SDR_EN, 0);
regmap_clear_bits() lets you drop the 0.

> +	if (ret)
> +		return ret;
> +
> +	mask = INV_ICM42607_DRIVE_CONFIG3_SPI_MASK;
> +	val = INV_ICM42607_DRIVE_CONFIG3_SPI(INV_ICM42607_SLEW_RATE_INF_2NS);
Even though it will be a long line, I'd put at least the mask inline
and probably even val, just to keep things consistent with other calls
around this.  As long as it is under 100 chars and helps readability it is fine
to go a little wild.

> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_DRIVE_CONFIG3,
> +				 mask, val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
> +				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK,
> +				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS);
> +}
> +
> +static int inv_icm42607_probe(struct spi_device *spi)
> +{
> +	const void *match;
> +	enum inv_icm42607_chip chip;
> +	struct regmap *regmap;
> +
> +	match = device_get_match_data(&spi->dev);
spi_get_device_match_data() - which will only work if you stop using an enum
below.
> +	if (!match)
> +		return -EINVAL;
> +	chip = (uintptr_t)match;
> +
> +	regmap = devm_regmap_init_spi(spi, &inv_icm42607_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
> +				     "Failed to register spi regmap %ld\n",
> +				     PTR_ERR(regmap));
> +
> +	return inv_icm42607_core_probe(regmap, chip,
> +				       inv_icm42607_spi_bus_setup);
> +}
> +
> +static const struct of_device_id inv_icm42607_of_matches[] = {
> +	{
> +		.compatible = "invensense,icm42607",
> +		.data = (void *)INV_CHIP_ICM42607,

Use a pointer to the structure, not an enum value.  
We used to do this enum thing a lot. Experience showed it is harder
to read and encourages people to use the enum to makes stuff 'code'
that should have been 'data'.  + it breaks spi_get_device_match_data()
which relies on NULL meaning no match.

> +	},
> +	{
> +		.compatible = "invensense,icm42607p",
> +		.data = (void *)INV_CHIP_ICM42607P,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);
> +
> +static const struct spi_device_id inv_icm42607_spi_id_table[] = {
> +	{ "icm42607", INV_CHIP_ICM42607 },
> +	{ "icm42607p", INV_CHIP_ICM42607P },
> +	{ },
No trailing comma for these terminating entries.

> +};
> +MODULE_DEVICE_TABLE(spi, inv_icm42607_spi_id_table);

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
> new file mode 100644
> index 000000000000..ae382352c861
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
> @@ -0,0 +1,82 @@
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
> +#include <linux/iio/iio.h>
> +
> +#include "inv_icm42607.h"
> +#include "inv_icm42607_temp.h"
> +
> +static int inv_icm42607_temp_read(struct inv_icm42607_state *st, s16 *temp)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	__be16 *raw;
> +	int ret;
> +
> +	pm_runtime_get_sync(dev);
Can fail.  Note we have some cleanup.h magic now to help with this.
Look at PM_RUNTIME_ACQUIRE_AUTOSUSPEND() / PM_RUNTIME_ACQUIRE_ERR()



> +	mutex_lock(&st->lock);
With the acquire stuff in use for runtime PM, this can be handled
via guard(mutex)(&st->lock);

> +
> +	ret = inv_icm42607_set_temp_conf(st, true, NULL);
> +	if (ret)
> +		goto exit;
And after we have cleanup.h handling for all the cleanup, this can be
simply return ret;

> +
> +	raw = (__be16 *)&st->buffer[0];
I'm not sure why we need the pointer...

> +	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_TEMP_DATA1, raw, sizeof(*raw));
> +	if (ret)
> +		goto exit;
> +
> +	*temp = (s16)be16_to_cpup(raw);

I'd just use the unaligned_get_be16() path here so the code here isn't making
alignment assumptions that are in a structure defined elsewhere.
Or, use a union so we can have the right type of buffer.

> +	if (*temp == INV_ICM42607_DATA_INVALID)
> +		ret = -EINVAL;
> +
> +exit:
> +	mutex_unlock(&st->lock);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +int inv_icm42607_temp_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);

I'd expect to get to this via a pointer stashed in the structure
we get from iio_priv() rather than drvdata.

> +	s16 temp;
> +	int ret;
> +
> +	if (chan->type != IIO_TEMP)

Given the function name, this feels like an overly paranoid check.
If it's needed, add a comment on why.

> +		return -EINVAL;
> +

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
> new file mode 100644
> index 000000000000..d0bd6c460ff2
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
Hi Chris,

Are you working for InvenSense to upstream this driver?  Or is your thought
that this is based closely on existing code so should reflect that?

If it's the latter then add comments to describe that and provide the cross
references in the driver.

> + */
