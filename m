Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45175 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbbA2Sgv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jan 2015 13:36:51 -0500
Message-ID: <54CA7DC1.1030102@kernel.org>
Date: Thu, 29 Jan 2015 18:36:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Karol Wrona <k.wrona@samsung.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Karol Wrona <wrona.vy@gmail.com>
Subject: Re: [PATCH v5 3/5] iio: common: ssp_sensors: Add sensorhub iio commons
References: <1422453954-27317-1-git-send-email-k.wrona@samsung.com> <1422453954-27317-4-git-send-email-k.wrona@samsung.com>
In-Reply-To: <1422453954-27317-4-git-send-email-k.wrona@samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/01/15 14:05, Karol Wrona wrote:
> This patch adds common library for sensorhub iio drivers.
> 
> Signed-off-by: Karol Wrona <k.wrona@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Applied with the make file line brought forward from patch 1.
Pushed out as testing for the autobuilders to play.

> ---
>  drivers/iio/common/ssp_sensors/ssp_iio.c        |  107 +++++++++++++++++++++++
>  drivers/iio/common/ssp_sensors/ssp_iio_sensor.h |   70 +++++++++++++++
>  2 files changed, 177 insertions(+)
>  create mode 100644 drivers/iio/common/ssp_sensors/ssp_iio.c
>  create mode 100644 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
> new file mode 100644
> index 0000000..a3ae165
> --- /dev/null
> +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
> @@ -0,0 +1,107 @@
> +/*
> + *  Copyright (C) 2014, Samsung Electronics Co. Ltd. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/iio/common/ssp_sensors.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include "ssp_iio_sensor.h"
> +
> +/**
> + * ssp_common_buffer_postenable() - generic postenable callback for ssp buffer
> + *
> + * @indio_dev:		iio device
> + *
> + * Returns 0 or negative value in case of error
> + */
> +int ssp_common_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ssp_sensor_data *spd = iio_priv(indio_dev);
> +	struct ssp_data *data = dev_get_drvdata(indio_dev->dev.parent->parent);
> +
> +	/* the allocation is made in post because scan size is known in this
> +	 * moment
> +	 * */
> +	spd->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL | GFP_DMA);
> +	if (!spd->buffer)
> +		return -ENOMEM;
> +
> +	return ssp_enable_sensor(data, spd->type,
> +				 ssp_get_sensor_delay(data, spd->type));
> +}
> +EXPORT_SYMBOL(ssp_common_buffer_postenable);
> +
> +/**
> + * ssp_common_buffer_postdisable() - generic postdisable callback for ssp buffer
> + *
> + * @indio_dev:		iio device
> + *
> + * Returns 0 or negative value in case of error
> + */
> +int ssp_common_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct ssp_sensor_data *spd = iio_priv(indio_dev);
> +	struct ssp_data *data = dev_get_drvdata(indio_dev->dev.parent->parent);
> +
> +	ret = ssp_disable_sensor(data, spd->type);
> +	if (ret < 0)
> +		return ret;
> +
> +	kfree(spd->buffer);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(ssp_common_buffer_postdisable);
> +
> +/**
> + * ssp_common_process_data() - Common process data callback for ssp sensors
> + *
> + * @indio_dev:		iio device
> + * @buf:		source buffer
> + * @len:		sensor data length
> + * @timestamp:		system timestamp
> + *
> + * Returns 0 or negative value in case of error
> + */
> +int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
> +			    unsigned int len, int64_t timestamp)
> +{
> +	__le32 time;
> +	int64_t calculated_time;
> +	struct ssp_sensor_data *spd = iio_priv(indio_dev);
> +
> +	if (indio_dev->scan_bytes == 0)
> +		return 0;
> +
> +	/*
> +	 * it always sends full set of samples, remember about available masks
> +	 */
> +	memcpy(spd->buffer, buf, len);
> +
> +	if (indio_dev->scan_timestamp) {
> +		memcpy(&time, &((char *)buf)[len], SSP_TIME_SIZE);
> +		calculated_time =
> +			timestamp + (int64_t)le32_to_cpu(time) * 1000000;
> +	}
> +
> +	return iio_push_to_buffers_with_timestamp(indio_dev, spd->buffer,
> +						  calculated_time);
> +}
> +EXPORT_SYMBOL(ssp_common_process_data);
> +
> +MODULE_AUTHOR("Karol Wrona <k.wrona@samsung.com>");
> +MODULE_DESCRIPTION("Samsung sensorhub commons");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> new file mode 100644
> index 0000000..dda267c
> --- /dev/null
> +++ b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> @@ -0,0 +1,70 @@
> +#ifndef __SSP_IIO_SENSOR_H__
> +#define __SSP_IIO_SENSOR_H__
> +
> +#define SSP_CHANNEL_AG(_type, _mod, _index) \
> +{ \
> +		.type = _type,\
> +		.modified = 1,\
> +		.channel2 = _mod,\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +		.scan_index = _index,\
> +		.scan_type = {\
> +			.sign = 's',\
> +			.realbits = 16,\
> +			.storagebits = 16,\
> +			.shift = 0,\
> +			.endianness = IIO_LE,\
> +		},\
> +}
> +
> +/* It is defined here as it is a mixed timestamp */
> +#define SSP_CHAN_TIMESTAMP(_si) {					\
> +	.type = IIO_TIMESTAMP,						\
> +	.channel = -1,							\
> +	.scan_index = _si,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 64,						\
> +		.storagebits = 64,					\
> +		},							\
> +}
> +
> +#define SSP_MS_PER_S			1000
> +#define SSP_INVERTED_SCALING_FACTOR	1000000ULL
> +
> +#define SSP_FACTOR_WITH_MS \
> +	(SSP_INVERTED_SCALING_FACTOR * SSP_MS_PER_S)
> +
> +int ssp_common_buffer_postenable(struct iio_dev *indio_dev);
> +
> +int ssp_common_buffer_postdisable(struct iio_dev *indio_dev);
> +
> +int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
> +			    unsigned int len, int64_t timestamp);
> +
> +/* Converts time in ms to frequency */
> +static inline void ssp_convert_to_freq(u32 time, int *integer_part,
> +				       int *fractional)
> +{
> +	if (time == 0) {
> +		*fractional = 0;
> +		*integer_part = 0;
> +		return;
> +	}
> +
> +	*integer_part = SSP_FACTOR_WITH_MS / time;
> +	*fractional = do_div(*integer_part, SSP_INVERTED_SCALING_FACTOR);
> +}
> +
> +/* Converts frequency to time in ms */
> +static inline int ssp_convert_to_time(int integer_part, int fractional)
> +{
> +	u64 value;
> +
> +	value = integer_part * SSP_INVERTED_SCALING_FACTOR + fractional;
> +	if (value == 0)
> +		return 0;
> +
> +	return div_u64(SSP_FACTOR_WITH_MS, value);
> +}
> +#endif /* __SSP_IIO_SENSOR_H__ */
> 

