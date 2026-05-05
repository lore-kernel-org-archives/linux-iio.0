Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A141B367;
	Tue,  5 May 2026 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976069; cv=none; b=Nprk9pRoAG43F63Z1FDGHrUSyicyfCbty1PltGvJTW306AfNmTsmqRZ4QfOaUOUhQmXhNjmHkK6QckqgZSKXyyNhf7U+TCdoPfBbvG+IrWy0znTR+ZLX6/FWh+RTEKrqRqBRnQjgP/ibZY4+lw5e0HDwBNOjKvL29vespwuBdTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976069; c=relaxed/simple;
	bh=bOnZxTjoqYVWdZLxp/MVHtyMN09VkAKH5iOG5FMq6jw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/ce4SKbOOx736sjZyKkpQy4MjGDsfB2AGgpA7Oh+jcSlZPhfUqJuLJGN8i8CpVYraPeLAzI0GdatrQwu8nCg8AcBmMMgw/+WU+CcJUQoxA4DLx0JDBvcD4aQPE9hpOCocQyEBXa8gilajrKtODLASET3URqfDREIIaO4MO6axw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fy4p20IJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy4p20IJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC4AC2BCC7;
	Tue,  5 May 2026 10:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777976068;
	bh=bOnZxTjoqYVWdZLxp/MVHtyMN09VkAKH5iOG5FMq6jw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fy4p20IJP0f4K09+dyh54G62rzT4ojNKP6HS/6mMx8iGKZ1TNZ2vq5BGg7Yc1Yez7
	 BQqJ/7p8Vv+81iz5I98HAyqCXluNxwjJRxypeid5a6nZsytsImBBYkf50P1oN9SURt
	 IBGG1ccKx1LqgtBmOWgsT6b/76JL/LRSp3/J4cr+ZzAeH4trmWLn9JjBF9z2vpgT3W
	 dCZvOPRrx1x6Fdb0y/FA778MfdYUzcRsvioj4CcwVpuThzAVcx0N9LNNqD3awm80nq
	 72OqaQgw9b1ODNbkAtLlljT1TZ5Xqm+qDU9Tx37bsbnJ/BaYL9HxIIgJstxboH8Me0
	 7xfBWZ0q7pGEA==
Date: Tue, 5 May 2026 11:14:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 05/10] iio: imu: inv_icm42607: Add Buffer support for
 icm42607
Message-ID: <20260505111418.48ea6f25@jic23-huawei>
In-Reply-To: <20260501221152.194251-6-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
	<20260501221152.194251-6-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 May 2026 17:11:44 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add all FIFO parsing and reading functions to support> inv_icm42607 hardware.
Generally wrap commit messages to 75 ish characters.

> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Hi Chris

Various comments inline.  Biggest set seem to be on making
use of min() / max() to do clamping. They are generally as
easy to read as using a conditional and often more compact.

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> new file mode 100644
> index 000000000000..5c67f6a37520
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> @@ -0,0 +1,489 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/minmax.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/common/inv_sensors_timestamp.h>

I'd put this one in it's own block between the iio generic headers
and the very driver specific ones given its specific to invensense
sensors.

> +#include <linux/iio/iio.h>
> +
> +#include "inv_icm42607.h"
> +#include "inv_icm42607_buffer.h"
> +
> +/* FIFO header: 1 byte */
> +#define INV_ICM42607_FIFO_HEADER_MSG		BIT(7)
> +#define INV_ICM42607_FIFO_HEADER_ACCEL		BIT(6)
> +#define INV_ICM42607_FIFO_HEADER_GYRO		BIT(5)
> +#define INV_ICM42607_FIFO_HEADER_TMST_FSYNC	GENMASK(3, 2)
> +#define INV_ICM42607_FIFO_HEADER_ODR_ACCEL	BIT(1)
> +#define INV_ICM42607_FIFO_HEADER_ODR_GYRO	BIT(0)
> +
> +struct inv_icm42607_fifo_1sensor_packet {
> +	u8 header;
> +	struct inv_icm42607_fifo_sensor_data data;
> +	s8 temp;
> +} __packed;
> +#define INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE		8
> +
> +struct inv_icm42607_fifo_2sensors_packet {
> +	u8 header;
> +	struct inv_icm42607_fifo_sensor_data accel;
> +	struct inv_icm42607_fifo_sensor_data gyro;
> +	s8 temp;
> +	__be16 timestamp;
> +} __packed;
> +#define INV_ICM42607_FIFO_2SENSORS_PACKET_SIZE		16
> +
> +ssize_t inv_icm42607_fifo_decode_packet(const void *packet, const void **accel,
> +					const void **gyro, const int8_t **temp,
> +					const void **timestamp, unsigned int *odr)


For now at least odr doesn't seem to be used at the caller.  So I'd drop
it from the function signature until it is useful.

> +{
> +	const struct inv_icm42607_fifo_1sensor_packet *pack1 = packet;
> +	const struct inv_icm42607_fifo_2sensors_packet *pack2 = packet;
> +	u8 header = *((const u8 *)packet);
> +
> +	/* FIFO empty */
> +	if (header & INV_ICM42607_FIFO_HEADER_MSG) {
> +		*accel = NULL;
> +		*gyro = NULL;
> +		*temp = NULL;
> +		*timestamp = NULL;
> +		*odr = 0;
> +		return 0;
> +	}
> +
> +	/* handle odr flags */
> +	*odr = 0;
> +	if (header & INV_ICM42607_FIFO_HEADER_ODR_GYRO)
> +		*odr |= INV_ICM42607_SENSOR_GYRO;
> +	if (header & INV_ICM42607_FIFO_HEADER_ODR_ACCEL)
> +		*odr |= INV_ICM42607_SENSOR_ACCEL;
> +
> +	/* accel + gyro */
> +	if ((header & INV_ICM42607_FIFO_HEADER_ACCEL) &&
> +	    (header & INV_ICM42607_FIFO_HEADER_GYRO)) {
> +		*accel = &pack2->accel;
> +		*gyro = &pack2->gyro;
> +		*temp = &pack2->temp;
> +		*timestamp = &pack2->timestamp;
> +		return INV_ICM42607_FIFO_2SENSORS_PACKET_SIZE;
> +		}

Odd indent.  Should be one less tab.

> +
> +	/* accel only */
> +	if (header & INV_ICM42607_FIFO_HEADER_ACCEL) {
> +		*accel = &pack1->data;
> +		*gyro = NULL;
> +		*temp = &pack1->temp;
> +		*timestamp = NULL;
> +		return INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE;
> +	}
> +
> +	/* gyro only */
> +	if (header & INV_ICM42607_FIFO_HEADER_GYRO) {
> +		*accel = NULL;
> +		*gyro = &pack1->data;
> +		*temp = &pack1->temp;
> +		*timestamp = NULL;
> +		return INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE;
> +	}
> +
> +	/* invalid packet if here */
> +	return -EINVAL;
> +}

> +
> +static unsigned int inv_icm42607_wm_truncate(unsigned int watermark,
> +					     size_t packet_size)
> +{
> +	size_t wm_size;
> +
> +	wm_size = watermark * packet_size;
> +	if (wm_size > INV_ICM42607_FIFO_WATERMARK_MAX)
> +		wm_size = INV_ICM42607_FIFO_WATERMARK_MAX;

	wm_size = min(watermark * packet_size, INV_ICM42607_FIFO_WATERMARK_MAX);

> +
> +	return wm_size / packet_size;
> +}
> +
> +/**
> + * inv_icm42607_buffer_update_watermark - update watermark FIFO threshold
> + * @st:	driver internal state
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +int inv_icm42607_buffer_update_watermark(struct inv_icm42607_state *st)
> +{
> +	size_t packet_size, wm_size;
> +	unsigned int wm_gyro, wm_accel, watermark;
> +	u32 period_gyro, period_accel;
> +	u32 latency_gyro, latency_accel, latency;
> +	bool restore;
> +	__le16 raw_wm;
> +	int ret;
> +
> +	packet_size = inv_icm42607_get_packet_size(st->fifo.en);
> +
> +	/* compute sensors latency, depending on sensor watermark and odr */
> +	wm_gyro = inv_icm42607_wm_truncate(st->fifo.watermark.gyro, packet_size);
> +	wm_accel = inv_icm42607_wm_truncate(st->fifo.watermark.accel, packet_size);
> +	/* use us for odr to avoid overflow using 32 bits values */
> +	period_gyro = inv_icm42607_odr_to_period(st->conf.gyro.odr) / 1000UL;
> +	period_accel = inv_icm42607_odr_to_period(st->conf.accel.odr) / 1000UL;
> +	latency_gyro = period_gyro * wm_gyro;
> +	latency_accel = period_accel * wm_accel;
> +
> +	/* 0 value for watermark means that the sensor is turned off */
> +	if (wm_gyro == 0 && wm_accel == 0)
> +		return 0;
> +
> +	if (latency_gyro == 0) {
> +		watermark = wm_accel;
> +		st->fifo.watermark.eff_accel = wm_accel;
> +	} else if (latency_accel == 0) {
> +		watermark = wm_gyro;
> +		st->fifo.watermark.eff_gyro = wm_gyro;
> +	} else {
> +		/* compute the smallest latency that is a multiple of both */
> +		if (latency_gyro <= latency_accel)
> +			latency = latency_gyro - (latency_accel % latency_gyro);
> +		else
> +			latency = latency_accel - (latency_gyro % latency_accel);
> +		/* all this works because periods are multiple of each others */
> +		watermark = latency / min(period_gyro, period_accel);
> +		if (watermark < 1)
> +			watermark = 1;
		watermark = max(watermark, 1);

> +		/* update effective watermark */
> +		st->fifo.watermark.eff_gyro = latency / period_gyro;
> +		if (st->fifo.watermark.eff_gyro < 1)
> +			st->fifo.watermark.eff_gyro = 1;
		st->fifo.watermark.eff_gyro = max(latency / period_gyro, 1);
is clear and shorter.


> +		st->fifo.watermark.eff_accel = latency / period_accel;
> +		if (st->fifo.watermark.eff_accel < 1)
> +			st->fifo.watermark.eff_accel = 1;

same again

> +	}
> +
> +	/* compute watermark value in bytes */
> +	wm_size = watermark * packet_size;

I'd push this down to nearer where it's used.

> +
> +	/* changing FIFO watermark requires to turn off watermark interrupt */
> +	ret = regmap_update_bits_check(st->map, INV_ICM42607_REG_INT_SOURCE0,
> +				       INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
> +				       0, &restore);
> +	if (ret)
> +		return ret;
> +
So here.
> +	raw_wm = INV_ICM42607_FIFO_WATERMARK_VAL(wm_size);
> +	memcpy(st->buffer, &raw_wm, sizeof(raw_wm));
> +	ret = regmap_bulk_write(st->map, INV_ICM42607_REG_FIFO_CONFIG2,
> +				st->buffer, sizeof(raw_wm));
> +	if (ret)
> +		return ret;
> +
> +	/* restore watermark interrupt */
> +	if (restore) {
> +		ret = regmap_update_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
> +					 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
> +					 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int inv_icm42607_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	struct inv_icm42607_sensor_state *sensor_st = iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts = &sensor_st->ts;
> +
> +	pm_runtime_get_sync(dev);

Maybe check the error return from this. Though as the docs suggest
better to use
	ret = pm_runtime_resume_and_get(dev);
as that doesn't leave ref count raised on failure.

> +
> +	guard(mutex)(&st->lock);
> +	inv_sensors_timestamp_reset(ts);
> +
> +	return 0;
> +}
> +
> +/*
> + * update_scan_mode callback is turning sensors on and setting data FIFO enable
> + * bits.
> + */
> +static int inv_icm42607_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* exit if FIFO is already on */
> +	if (st->fifo.on) {
> +		st->fifo.on++;
> +		return 0;
> +	}
> +
> +	/* set FIFO threshold interrupt */
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
> +				 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
> +				 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN);
	ret = regmap_set_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
			      INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN);

Might as well save a line on these.


> +	if (ret)
> +		return ret;
> +
> +	/* flush FIFO data */
> +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> +			   INV_ICM42607_SIGNAL_PATH_RESET_FIFO_FLUSH);
> +	if (ret)
> +		return ret;
> +
> +	/* set FIFO in streaming mode */
> +	ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
> +			   INV_ICM42607_FIFO_CONFIG1_MODE);
> +	if (ret)
> +		return ret;
> +
> +	/* workaround: first read of FIFO count after reset is always 0 */
> +	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_FIFO_COUNTH, st->buffer, 2);

I think you read this as explicitly going into a __be16 elsewhere.
Good to size this either from sizeof(st->buffer[0]) or sizeof(__be16) rather
than a magic 2.

> +	if (ret)
> +		return ret;
> +
> +	st->fifo.on++;
> +
> +	return 0;
> +}


> +int inv_icm42607_buffer_fifo_read(struct inv_icm42607_state *st,
> +				  unsigned int max)
> +{
> +	size_t max_count;
> +	__be16 *raw_fifo_count;
> +	ssize_t i, size;
> +	const void *accel, *gyro, *timestamp;

Where no other reason for ordering applies use reverse xmas tree.
If this is meant to be order of first use, that tends to be much
more fragile to code movement than reverse xmas tree hence
the preference.

> +	const s8 *temp;
> +	unsigned int odr;
> +	int ret;
> +
> +	/* reset all samples counters */
> +	st->fifo.count = 0;
> +	st->fifo.nb.gyro = 0;
> +	st->fifo.nb.accel = 0;
> +	st->fifo.nb.total = 0;
> +
> +	/* compute maximum FIFO read size */
> +	if (max == 0)
> +		max_count = sizeof(st->fifo.data);
> +	else
> +		max_count = max * inv_icm42607_get_packet_size(st->fifo.en);
> +
> +	/* read FIFO count value */
> +	raw_fifo_count = (__be16 *)st->buffer;

I think st->buffer is __be16 [3] so no cast needed here maybe make
it clear you want the first element with &st->buffer[0];

However I'd be tempted to just use that directly and drop the local
variable as adding little when we only use it so locally.

> +	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_FIFO_COUNTH,
> +			       raw_fifo_count, sizeof(*raw_fifo_count));
> +	if (ret)
> +		return ret;
> +	st->fifo.count = be16_to_cpup(raw_fifo_count);
> +
> +	/* check and clamp FIFO count value */
> +	if (st->fifo.count == 0)
> +		return 0;

I'd add a blank line here, just to make it easier to spot this
successful exit path.

> +	if (st->fifo.count > max_count)
> +		st->fifo.count = max_count;

	st->fifo.count = max(st->fifo.count, max_count);
is slightly more readable.

> +
> +	/* read all FIFO data in internal buffer */
> +	ret = regmap_noinc_read(st->map, INV_ICM42607_REG_FIFO_DATA,
> +				st->fifo.data, st->fifo.count);
> +	if (ret)
> +		return ret;
> +
> +	/* compute number of samples for each sensor */
> +	for (i = 0; i < st->fifo.count; i += size) {
	for (size_t i = 0; < st->fifo.count...

I'm curious on why it's signed. Should be fine to use an unsigned iterator as
only add positive values of size.

> +		size = inv_icm42607_fifo_decode_packet(&st->fifo.data[i],
> +				&accel, &gyro, &temp, &timestamp, &odr);
> +		if (size <= 0)
> +			break;
> +		if (gyro != NULL && inv_icm42607_fifo_is_data_valid(gyro))
> +			st->fifo.nb.gyro++;
> +		if (accel != NULL && inv_icm42607_fifo_is_data_valid(accel))
> +			st->fifo.nb.accel++;
> +		st->fifo.nb.total++;
> +	}
> +
> +	return 0;
> +}
> +
> +int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
> +				     unsigned int count)
> +{
> +	s64 gyro_ts, accel_ts;
> +	int ret;
> +
> +	gyro_ts = iio_get_time_ns(st->indio_gyro);
> +	accel_ts = iio_get_time_ns(st->indio_accel);
> +
> +	ret = inv_icm42607_buffer_fifo_read(st, count);
> +

To avoid a bit of churn later you could do
	if (ret)
		return ret;

	return 0;
now but not that important.


> +	return ret;
> +}

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
> new file mode 100644
> index 000000000000..2df49e795ad1
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.

Given you are using gmail / hotmail, just to confirm, is this work
being paid for by InvenSense? If it's based on other work of theirs
then there should be more detail on why this copyright notice so
we have that recorded for the long term.

> + */
> +
> +#ifndef INV_ICM42607_BUFFER_H_
> +#define INV_ICM42607_BUFFER_H_
> +
> +#include <linux/kernel.h>

For new code we avoid including linux/kernel.h but instead
use more specific headers.  Not entirely sure what you need here
but definitely something for the endian swap.
Also you need to have a forwards def for the 
struct inv_icm42607_state; maybe others.

> +#include <linux/bitops.h>
> +
> +struct inv_icm42607_state;
> +
> +#define INV_ICM42607_SENSOR_GYRO	BIT(0)
> +#define INV_ICM42607_SENSOR_ACCEL	BIT(1)
> +#define INV_ICM42607_SENSOR_TEMP	BIT(2)
> +
> +/**
> + * struct inv_icm42607_fifo - FIFO state variables
> + * @on:		reference counter for FIFO on.
> + * @en:		bits field of INV_ICM42607_SENSOR_* for FIFO EN bits.
> + * @period:	FIFO internal period.
> + * @watermark:	watermark configuration values for accel and gyro.
> + * @count:	number of bytes in the FIFO data buffer.
> + * @nb:		gyro, accel and total samples in the FIFO data buffer.
> + * @data:	FIFO data buffer aligned for DMA (2kB + 32 bytes of read cache).
> + */
> +struct inv_icm42607_fifo {
> +	unsigned int on;
> +	unsigned int en;
> +	u32 period;
> +	struct {
> +		unsigned int gyro;
> +		unsigned int accel;
> +		unsigned int eff_gyro;
> +		unsigned int eff_accel;
> +	} watermark;
> +	size_t count;
> +	struct {
> +		size_t gyro;
> +		size_t accel;
> +		size_t total;
> +	} nb;
> +	u8 data[2080] __aligned(IIO_DMA_MINALIGN);
> +};
> +
> +/* FIFO data packet */
> +struct inv_icm42607_fifo_sensor_data {
> +	__be16 x;
> +	__be16 y;
> +	__be16 z;
> +};
> +
> +#define INV_ICM42607_FIFO_DATA_INVALID		-32768
> +
> +static inline s16 inv_icm42607_fifo_get_sensor_data(__be16 d)
> +{
> +	return be16_to_cpu(d);

Is this helper worth bothering with?  Seems like it would be pretty
clear what was going on if the be16_to_cpu() was just inline?


> +}
> +
> +static inline bool
> +inv_icm42607_fifo_is_data_valid(const struct inv_icm42607_fifo_sensor_data *s)
> +{
> +	s16 x, y, z;
> +
> +	x = inv_icm42607_fifo_get_sensor_data(s->x);
> +	y = inv_icm42607_fifo_get_sensor_data(s->y);
> +	z = inv_icm42607_fifo_get_sensor_data(s->z);
> +
> +	if (x == INV_ICM42607_FIFO_DATA_INVALID &&
> +		y == INV_ICM42607_FIFO_DATA_INVALID &&
> +		z == INV_ICM42607_FIFO_DATA_INVALID)

Align this as:
	if (x == INV_ICM42607_FIFO_DATA_INVALID &&
	    y == INV_ICM42607_FIFO_DATA_INVALID &&
	    z == INV_ICM42607_FIFO_DATA_INVALID)

You could flip this around and do
	__be16 be_inval_marker = cpu_to_be16(INV_ICM42607_FIFO_DATA_INVALID);

	if (s->x == be_inval_marker &&
	    s->y == be_inval_marker &&
	    s->z == be_inval_marker)
		return false;

> +		return false;
> +
> +	return true;
> +}
> +
> +ssize_t inv_icm42607_fifo_decode_packet(const void *packet, const void **accel,
> +					const void **gyro, const s8 **temp,
> +					const void **timestamp, unsigned int *odr);

> +

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index af3784040b7a..7b9c05df820a 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  
>  #include "inv_icm42607.h"
> +#include "inv_icm42607_buffer.h"
>  
>  static const struct regmap_range_cfg inv_icm42607_regmap_ranges[] = {
>  	{
> @@ -163,6 +164,7 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
>  	return 0;
>  }
>  
> +

Stray change. Remember to check your patches for these.
we all introduce them whilst editing a series, so it's always a case
of taking a look at the final result to catch them.

>  int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,

