Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0B3EDACC;
	Wed, 20 May 2026 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298885; cv=none; b=jpeVPdqgxRYHtp+cAh8Gv9Zj/RbZyzTI6+X9rS9aoaB8kA5AH41D50ONof05EXiP+ABpkMzWmbcgfnIQKgzy6YqO+1f6PkQ5UbRvW8SFyIgYXbVLtXOuDcgyLxiDF6HSMpmBc6sSuT1HlS112A3Gy4/ZL6AKo30I5pORmS8kF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298885; c=relaxed/simple;
	bh=x8nwAIGk93YkM+3UTm8NofNd8Srsrtn1SKsTEFoOUwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+BbvBEXf1pTLqH6tXlXCsxfCdpCFCIJ5vCQncnZHpRGKBLS3e+cC5zv9v7cPHZV4mRWx17xxxUNe4HAti0J9Dm9M+t9Swa+mTm6hZH2RJo1Y7QH8jP3PCPelYjE0H+pH2OPOTCneQVE00PKXxQ+T30f1VHxIVgFm5E+Ot77ERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKezlBOC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKezlBOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5401F000E9;
	Wed, 20 May 2026 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779298883;
	bh=GqncshP8bMhCZVCkr7YP7QMNen7yCu2zNyWcT7d0fMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SKezlBOCJ6eoZX3fHZUhYpvz7fbxd6+kEoMMa2UKmXrNd22Bewl/2BuO8NgAyEc0V
	 Wd3n2G0axhVntgOU4mZe9fMpnN7+ZguFipT5sV/g8vJQf2oGMSOqQ7PeLakDJfolEs
	 XI2j69UVRwdVQj7oTtVGQruqBHdS9BIBkYyyOu3/RpLdjGPr8wixo1xY8+WJMFLcrA
	 6c6HCJH9VkLGYiTLEIn6zsdYOf/5VeqnNbCb1VoEd5OQ6eYO5blhFKBqd2BUajBGVw
	 WVNlEis1vTnOI9Hs3fA7xv776ucl0Fa5Mn4t5S0/6bEG+jNyNUwf66mI6zJFaasG5K
	 MRaMaTKEhzw3Q==
Date: Wed, 20 May 2026 18:41:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>, devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, heiko@sntech.de, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com, Chris
 Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V8 06/10] iio: imu: inv_icm42607: Add Buffer support for
 icm42607
Message-ID: <20260520184113.2c36f49a@jic23-huawei>
In-Reply-To: <20260518200526.458421-7-macroalpha82@gmail.com>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
	<20260518200526.458421-7-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 15:05:21 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add all FIFO parsing and reading functions to support
> inv_icm42607 hardware.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

https://sashiko.dev/#/patchset/20260518200526.458421-1-macroalpha82%40gmail.com
Is unhappy.  I haven't checked closely though - might be wrong.

> ---

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> new file mode 100644
> index 000000000000..a011f1f728b9
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> @@ -0,0 +1,482 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/minmax.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/common/inv_sensors_timestamp.h>
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
One of the things sashiko doesn't like is pointers to unaligned
structures.  I'm not sure what architectures we have that really
don't like these still but it is correct that they can be a problem.

Ultimately you need to use unaligned accessors

> +	s8 temp;
> +} __packed;
> +
> +struct inv_icm42607_fifo_2sensors_packet {
> +	u8 header;
> +	struct inv_icm42607_fifo_sensor_data accel;
> +	struct inv_icm42607_fifo_sensor_data gyro;
> +	s8 temp;
> +	__be16 timestamp;
> +} __packed;


> +int inv_icm42607_buffer_set_fifo_en(struct inv_icm42607_state *st,
> +				    unsigned int fifo_en)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	/* update FIFO EN bits for accel and gyro */
> +	val = 0;
> +	if (fifo_en & INV_ICM42607_SENSOR_GYRO)
> +		val |= INV_ICM42607_FIFO_CONFIG1_MODE;
> +	if (fifo_en & INV_ICM42607_SENSOR_ACCEL)
> +		val |= INV_ICM42607_FIFO_CONFIG1_MODE;
> +	if (fifo_en & INV_ICM42607_SENSOR_TEMP)
> +		val |= INV_ICM42607_FIFO_CONFIG1_MODE;
Odd to see these all set same bit like this.  Why not something
that will stop confusing sashiko (and me ;) because it explicitly
sets teh value only once.

	if (fifo_en & (INV_ICM42607_SENSOR_GYRO |
		       INV_ICM42607_SENSOR_ACCEL |
		       INV_ICM42607_SENSOR_TEMP))
		val = INV_...


 
> +
> +	ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1, val);
> +	if (ret)
> +		return ret;
> +
> +	st->fifo.en = fifo_en;
> +	inv_icm42607_buffer_update_fifo_period(st);
> +
> +	return 0;
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
> +	const struct device *dev = regmap_get_device(st->map);
> +	unsigned int wm_gyro, wm_accel, watermark;
> +	u32 latency_gyro, latency_accel, latency;
> +	u32 period_gyro, period_accel;
> +	size_t packet_size, wm_size;
> +	__le16 raw_wm;
> +	bool restore;
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
> +		watermark = max(watermark, 1);
> +		/* update effective watermark */
> +		st->fifo.watermark.eff_gyro = max(latency / period_gyro, 1);
> +		st->fifo.watermark.eff_accel = max(latency / period_accel, 1);
> +	}
> +
> +	/* changing FIFO watermark requires to turn off watermark interrupt */
> +	ret = regmap_update_bits_check(st->map, INV_ICM42607_REG_INT_SOURCE0,
> +				       INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
> +				       0, &restore);
> +	if (ret)
> +		return ret;
> +
> +	/* compute watermark value in bytes */
> +	wm_size = watermark * packet_size;
> +	raw_wm = INV_ICM42607_FIFO_WATERMARK_VAL(wm_size);
> +	memcpy(st->buffer, &raw_wm, sizeof(raw_wm));

Shout a bit (comment) about this being le vs the be buffer. 

> +	ret = regmap_bulk_write(st->map, INV_ICM42607_REG_FIFO_CONFIG2,
> +				st->buffer, sizeof(raw_wm));
> +	if (ret) {
> +		dev_err(dev, "Unable to change watermark value: %d\n", ret);
> +		if (restore)
> +			regmap_update_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
> +					   INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
> +					   INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN);
regmap_set_bits()
> +		return ret;
> +	}
> +
> +	/* restore watermark interrupt */
> +	if (restore) {
> +		ret = regmap_update_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
> +					 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
> +					 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN);
regmap_set_bits()
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
>

> +int inv_icm42607_buffer_fifo_read(struct inv_icm42607_state *st,
> +				  unsigned int max)
> +{
> +	const void *accel, *gyro, *timestamp;
> +	size_t i, max_count;
> +	const s8 *temp;
> +	ssize_t size;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
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
> +		max_count = min((max * inv_icm42607_get_packet_size(st->fifo.en)),
> +				sizeof(st->fifo.data));
> +
> +	/* read FIFO count value */
> +	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_FIFO_COUNTH,
> +			       st->buffer, sizeof(u8) * 2);
Given buffer is an array of __be16, use size of buffer[0] to say you want to 
read one value.

> +	if (ret)
> +		return ret;
> +	st->fifo.count = be16_to_cpup(st->buffer);
whilst it is the same thing we can use the easier to read
	st->fifo.count = be16_to_cpu(st->buffer[0]);
again making it clear this is just using one __be16 from
the array.

> +
> +	/* check and clamp FIFO count value */
> +	if (st->fifo.count == 0)
> +		return 0;
> +
> +	st->fifo.count = min(st->fifo.count, max_count);
> +
> +	/* read all FIFO data in internal buffer */
> +	ret = regmap_noinc_read(st->map, INV_ICM42607_REG_FIFO_DATA,
> +				st->fifo.data, st->fifo.count);
> +	if (ret)
> +		return ret;
> +
> +	/* compute number of samples for each sensor */
> +	for (i = 0; i < st->fifo.count; i += size) {
> +		size = inv_icm42607_fifo_decode_packet(&st->fifo.data[i],
> +				&accel, &gyro, &temp, &timestamp);
> +		/* Make sure the size is at least 1 valid packet. */
> +		if (size < INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE)
> +			break;
> +		/* Error if we are going to overflow the buffer. */
> +		if (i + size > st->fifo.count)
> +			return -EIO;
> +		if (gyro != NULL && inv_icm42607_fifo_is_data_valid(gyro))
> +			st->fifo.nb.gyro++;
> +		if (accel != NULL && inv_icm42607_fifo_is_data_valid(accel))
> +			st->fifo.nb.accel++;
> +		st->fifo.nb.total++;
> +	}
> +
> +	return 0;
> +}

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
> new file mode 100644
> index 000000000000..b77deb66f8bd
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#ifndef INV_ICM42607_BUFFER_H_
> +#define INV_ICM42607_BUFFER_H_
> +
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
> +static inline bool
> +inv_icm42607_fifo_is_data_valid(const struct inv_icm42607_fifo_sensor_data *s)
> +{
> +	s16 x, y, z;
> +
> +	x = be16_to_cpu(s->x);
> +	y = be16_to_cpu(s->y);
> +	z = be16_to_cpu(s->z);

The input structure is unaligned and I think so are these so you need
get_unaligned_be16() 


> +
> +	if (x == INV_ICM42607_FIFO_DATA_INVALID &&
> +	    y == INV_ICM42607_FIFO_DATA_INVALID &&
> +	    z == INV_ICM42607_FIFO_DATA_INVALID)
> +		return false;
> +
> +	return true;
> +}
> +
> +ssize_t inv_icm42607_fifo_decode_packet(const void *packet, const void **accel,
> +					const void **gyro, const s8 **temp,
> +					const void **timestamp);
> +
> +extern const struct iio_buffer_setup_ops inv_icm42607_buffer_ops;
> +
> +int inv_icm42607_buffer_init(struct inv_icm42607_state *st);
> +
> +void inv_icm42607_buffer_update_fifo_period(struct inv_icm42607_state *st);
> +
> +int inv_icm42607_buffer_set_fifo_en(struct inv_icm42607_state *st,
> +				    unsigned int fifo_en);
> +
> +int inv_icm42607_buffer_update_watermark(struct inv_icm42607_state *st);
> +
> +int inv_icm42607_buffer_fifo_read(struct inv_icm42607_state *st,
> +				  unsigned int max);
> +
> +int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
> +				     unsigned int count);
> +
> +#endif
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index bc0cefa2fb77..29573d4fc0f0 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/regulator/consumer.h>
>  
>  #include "inv_icm42607.h"
> +#include "inv_icm42607_buffer.h"
>  
>  static bool inv_icm42607_is_volatile_reg(struct device *dev, unsigned int reg)
>  {
> @@ -73,6 +74,38 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
>  };
>  EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
>  
> +u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr)
> +{
> +	static const u32 odr_periods[INV_ICM42607_ODR_NB] = {
> +		/* 1600Hz */

No need for comment as it's now obvious

> +		[INV_ICM42607_ODR_1600HZ] = 625000,
> +		/* 800Hz */

Do [] = assignment for all of them and drop all the comments as they
will be unneeded.

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
> +	odr = clamp(odr, INV_ICM42607_ODR_1600HZ, INV_ICM42607_ODR_1_5625HZ_LP);
> +
> +	return odr_periods[odr];
> +}
> +
>
