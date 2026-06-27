Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3591FBC8E
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782589773; cv=none; b=sb788k6R/n8DCMhuwQgoualObqgIE9aTuo3Xx5aM3mC+xgfJO1TsKjSy2HSgkCaXy5JBX7/w/PRrVqxP20Db9OzI+dITGkYpGP3PutP5HDxiGtdbno18xKo1TWrV5LMAnz1AuH0wE6xlIQIm/Ocw4emoRGw/aNp6gy4i+lZGF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782589773; c=relaxed/simple;
	bh=kzq4UWxahX7NYOsvB4mKvwjyIMm71pm42eqy711Mph4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsTbDOYk0+nQkwGrfWdZcl9xltMJnW7LJYDEr9lo59jvRQLhKQMAzmWWwEzB3bCtDPmwlA5KmkSfvW0T6B22CjYhWDvn7CH3Fpn1VFcKTLbVdapvF3wsMw2Gk2ovDksh8MabZVBqQ6He7HBGyKr9VysvZ4XuL7sQ42/1BCOFkqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SmMVEuEu; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SmMVEuEu"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6a145935764so638476eaf.3
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 12:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782589769; x=1783194569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zDg9+DcOgSmq3p7pDdhdYYITDq+BlhsC76az7vImnOw=;
        b=SmMVEuEuZ11ak56sbGVRmcFEFpO8ZXYKwBJTsN0fY6r9girBK4Zfq7e09WOsoePQPQ
         Tc8JTvT8qh0Od/HyB7F5U8s8mLrVMXdq7KvJZWLZfsEeCUFQbMuDdgrm52C2yO2lYq9Q
         L7oej6tq761Gh7jUNuoSfJmRRdzx7t09zq1dKgP8youpvLqEcpNVHpuXZddwZQUOA9oB
         IMTWOQ2s+DscFk+klRHjAPaok3lJSVnno5Qw5uK2/3z69edDBp+K74pKkiKo+D4nSzM3
         1zeoi5/y/mKpYLEhjvF6RkzNo2iHquK1Gxw/qqKEwmHu3NenurS/93lvP8zPhDJhg5r5
         2nIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782589769; x=1783194569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDg9+DcOgSmq3p7pDdhdYYITDq+BlhsC76az7vImnOw=;
        b=cTw+gTEDdHKdcPIwgLZZ4CXCXdzJcaeEtucm9HFLaZkVN+7kCGSIdjuiHCCflTPnbt
         /7z6roMgD/IRyKA3Ogg2fuTkhEGArC47rf+zLMIPfWIN+7gGo0CfttR2jfKCMXi2kyTG
         nAfxGvBwI48ErTkEJocCamxeeekCuQQMyCGN3iu+IYgtXriWIh/b2qQSph3ml7qqtyP6
         ACzVe/P5l6EAFkVez/TvS8qcgFgqZJHtaVA04J4znT3Sb0oQTbHy+7TbVZMRYWpIydnn
         KkRY1ERXS+u4L33rSr6v372RoYIGsw9Ac2emvjoiEvhXkBat41wPUe2RaOTn+r9pkHBq
         kakg==
X-Forwarded-Encrypted: i=1; AFNElJ+dbL4fN64gwrHy6W4AbXnsJepDt14V+USLfkltytn7EI9THmANMDUO7B99gZ96Wy1F1SDYakAq+r8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Sc2RoReSpEwOTgexdv2i5QEr84dJIPG1disorDF+/eU+hyRt
	zwn1C0vmg8EJHd8LQn/8f2aLoWTfPLPYqh0BP+0ABawYbzR6oaK5xtHFFghjer8LAT4=
X-Gm-Gg: AfdE7clkBmH2Is64mpbbedVsOySNJsvDGznUO7KbULHQsS+mnCfG9dATIQx64PChU05
	D++sFq4MGq/kssIpMmd9czaC1NFnXZh5FHkGyn6JJU+BxPB8TrMqXj3yFel4I8JMYVicBBdyNgg
	WFegOF+EJFp43cLZCh5EyHjcGjLXKomnijgV5CQKnOO7VwTsp0KlDSlygTXCkDwFQHhd3lwI8Wy
	5U7waaIIadxDTwC8zFE07LeeQrqMapYJt+Z5dql2uGgFNCVQUGwUMi5qIjy0OURX+AEg22fjoCR
	XNzrZBq+wQlue1Khq13FxLaGW2wGJ4OtRzVd1ikasbsu7YH2mdYy+DZR43jQswns8wGrwPyRUJc
	KN5BZ+wbk8xUPA+hyeznxBOQD42pxldCMG88M9gqWKDHCmWJPAaTRS0ebvmyIt9da/DKrXAhkZ/
	K0rXQtkGXv7gNsd5Piq+dmr4Bylv/E1MQQWdFSxKbjcS7mtyn/IaZtJXMPKXxm6kc=
X-Received: by 2002:a05:6820:98f:b0:69d:e5f6:cef5 with SMTP id 006d021491bc7-6a1352aac35mr8290403eaf.55.1782589769186;
        Sat, 27 Jun 2026 12:49:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f242:ecd6:f61e:d764? ([2600:8803:e7e4:500:f242:ecd6:f61e:d764])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a141048ebbsm4138045eaf.0.2026.06.27.12.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 12:49:28 -0700 (PDT)
Message-ID: <a8b4ba88-44e4-4755-ba41-212cb2b798c6@baylibre.com>
Date: Sat, 27 Jun 2026 14:49:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: magnetometer: add support for Melexis
 MLX90393
To: Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 u.kleine-koenig@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260627095519.8377-1-nikhilgtr@gmail.com>
 <20260627095519.8377-3-nikhilgtr@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260627095519.8377-3-nikhilgtr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/26 4:55 AM, Nikhil Gautam wrote:
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
> ---
>  MAINTAINERS                              |   1 +
>  drivers/iio/magnetometer/Kconfig         |  10 +
>  drivers/iio/magnetometer/Makefile        |   2 +
>  drivers/iio/magnetometer/mlx90393.h      |  73 +++
>  drivers/iio/magnetometer/mlx90393_core.c | 701 +++++++++++++++++++++++
>  drivers/iio/magnetometer/mlx90393_i2c.c  |  76 +++
>  6 files changed, 863 insertions(+)
>  create mode 100644 drivers/iio/magnetometer/mlx90393.h
>  create mode 100644 drivers/iio/magnetometer/mlx90393_core.c
>  create mode 100644 drivers/iio/magnetometer/mlx90393_i2c.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 469ae3f9aa0f..177dda261801 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15506,6 +15506,7 @@ M:	Nikhil Gautam <nikhilgtr@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
> +F:	drivers/iio/magnetometer/mlx90393*
>  
>  MELEXIS MLX90614 DRIVER
>  M:	Crt Mori <cmo@melexis.com>
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 3debf1320ad1..e6b74e7e3317 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -128,6 +128,16 @@ config HID_SENSOR_MAGNETOMETER_3D
>  	  Say yes here to build support for the HID SENSOR
>  	  Magnetometer 3D.
>  
> +config MLX90393
> +	tristate "MELEXIS MLX90393 3-axis magnetometer sensor"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the MELEXIS MLX90393 3-axis
> +	  magnetometer.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mlx90393.
> +
>  config MMC35240
>  	tristate "MEMSIC MMC35240 3-axis magnetic sensor"
>  	select REGMAP_I2C
> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
> index 9297723a97d8..542c89d38a59 100644
> --- a/drivers/iio/magnetometer/Makefile
> +++ b/drivers/iio/magnetometer/Makefile
> @@ -14,6 +14,8 @@ obj-$(CONFIG_BMC150_MAGN_SPI) += bmc150_magn_spi.o
>  
>  obj-$(CONFIG_MAG3110)	+= mag3110.o
>  obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
> +obj-$(CONFIG_MLX90393)		+= mlx90393_core.o
> +obj-$(CONFIG_MLX90393)		+= mlx90393_i2c.o

Seems like the tabs are just making it more messy.
I would just go with one space.

>  obj-$(CONFIG_MMC35240)	+= mmc35240.o
>  
>  obj-$(CONFIG_IIO_ST_MAGN_3AXIS) += st_magn.o
> diff --git a/drivers/iio/magnetometer/mlx90393.h b/drivers/iio/magnetometer/mlx90393.h
> new file mode 100644
> index 000000000000..6a646ac05198
> --- /dev/null
> +++ b/drivers/iio/magnetometer/mlx90393.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * MLX90393 magnetometer & temperature sensor driver
> + *
> + * Copyright (c) 2026 Nikhil Gautam <nikhilgtr@gmail.com>
> + */
> +
> +#ifndef MLX90393_H
> +#define MLX90393_H
> +
> +#include <linux/bits.h>
> +#include <linux/types.h>
> +
> +#define MLX90393_AXIS_MAX		2
> +#define MLX90393_GAIN_MAX		8
> +#define MLX90393_RES_MAX		4
> +#define MLX90393_OSR2_MAX		4
> +#define MLX90393_OSR_MAX		4
> +
> +#define MLX90393_CMD_MASK        GENMASK(7, 4)
> +
> +/* Commands (datasheet, Table 11 - Command List) */
> +#define MLX90393_CMD_SB        0x10	/* Start Burst Mode */
> +#define MLX90393_CMD_SW        0x20	/* Start Wake-up on Change Mode */
> +#define MLX90393_CMD_SM        0x30	/* Start Single Measurement Mode */
> +#define MLX90393_CMD_RM        0x40	/* Read Measurement */
> +#define MLX90393_CMD_RR        0x50	/* Read Register */
> +#define MLX90393_CMD_WR        0x60	/* Write Register */
> +#define MLX90393_CMD_EX        0x80	/* Exit Mode */
> +#define MLX90393_CMD_HR        0xD0	/* Memory Recall */
> +#define MLX90393_CMD_HS        0xE0	/* Memory Store */
> +#define MLX90393_CMD_RT        0xF0	/* Reset Device */
> +
> +#define MLX90393_MEASURE_Z    BIT(0)
> +#define MLX90393_MEASURE_Y    BIT(1)
> +#define MLX90393_MEASURE_X    BIT(2)
> +#define MLX90393_MEASURE_TEMP BIT(3)
> +
> +#define MLX90393_MEASURE_ALL	(MLX90393_MEASURE_TEMP | \
> +		MLX90393_MEASURE_X | MLX90393_MEASURE_Y | MLX90393_MEASURE_Z)
> +
> +#define MLX90393_NUM_CHANNELS	4
> +
> +#define MLX90393_STATUS_RESP    GENMASK(1, 0)
> +#define MLX90393_STATUS_RT	BIT(2)
> +#define MLX90393_STATUS_ERROR   BIT(4)
> +
> +#define MLX90393_REG_CONF1          0x00
> +#define MLX90393_REG_CONF2          0x01
> +#define MLX90393_REG_CONF3          0x02
> +#define MLX90393_REG_CONF4          0x03
> +
> +#define MLX90393_CONF1_GAIN_SEL     GENMASK(6, 4)
> +#define MLX90393_CONF1_HALLCONF     GENMASK(3, 0)
> +
> +#define MLX90393_CONF3_OSR        GENMASK(1, 0)
> +#define MLX90393_CONF3_DIG_FILT   GENMASK(4, 2)
> +#define MLX90393_CONF3_RES_X      GENMASK(6, 5)
> +#define MLX90393_CONF3_RES_Y      GENMASK(8, 7)
> +#define MLX90393_CONF3_RES_Z      GENMASK(10, 9)
> +#define MLX90393_CONF3_OSR2       GENMASK(12, 11)
> +
> +struct device;
> +
> +struct mlx90393_transfer_ops {
> +	int (*xfer)(void *context, const u8 *tx, int tx_len, u8 *rx, int rx_len);
> +};
> +
> +int mlx90393_core_probe(struct device *dev,
> +			const struct mlx90393_transfer_ops *ops,
> +			void *context);
> +
> +#endif
> diff --git a/drivers/iio/magnetometer/mlx90393_core.c b/drivers/iio/magnetometer/mlx90393_core.c
> new file mode 100644
> index 000000000000..78fcab8a2b56
> --- /dev/null
> +++ b/drivers/iio/magnetometer/mlx90393_core.c
> @@ -0,0 +1,701 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MLX90393 magnetometer & temperature sensor driver
> + *
> + * Copyright (c) 2026 Nikhil Gautam <nikhilgtr@gmail.com>
> + *
> + * Datasheet: https://media.melexis.com/-/media/files/documents/datasheets/mlx90393-datasheet-melexis.pdf
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +#include <linux/time64.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#include "mlx90393.h"
> +
> +struct mlx90393_data {
> +	/* Protects sensor configuration and measurement operations */
> +	struct mutex lock;
> +	struct device *dev;
> +	void *bus_context;
> +	const struct mlx90393_transfer_ops *ops;
> +	u8 gain_sel;
> +	u8 hallconf;
> +
> +	u8 res_xy;
> +	u8 res_z;
> +
> +	u8 dig_filt;
> +	u8 osr;
> +	u8 osr2;
> +};
> +
> +enum mlx90393_channels {
> +	MLX90393_CHAN_X,
> +	MLX90393_CHAN_Y,
> +	MLX90393_CHAN_Z,
> +	MLX90393_CHAN_TEMP,
> +};
> +
> +enum mlx90393_axis_type {
> +	MLX90393_AXIS_TYPE_XY,
> +	MLX90393_AXIS_TYPE_Z,
> +};
> +
> +/* Datasheet: Table no.17 */

It would be more helpful to also say that this is nanotesela per LSB at 25 deg C.
And probably also explain why we don't care about the 35 deg C table.

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

OSR of 0 does not make sense. It would mean 0 samples, which would
be no data. Should this be the same as OSR below?

> +};
> +
> +static const int mlx90393_osr_avail[MLX90393_OSR_MAX] = {
> +	1, 2, 4, 8,
> +};
> +
> +#define MLX90393_CHAN(idx, axis, addr) { \
> +	.type = IIO_MAGN, \
> +	.modified = 1, \
> +	.channel = idx, \
> +	.address = addr, \
> +	.channel2 = IIO_MOD_##axis, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
> +		BIT(IIO_CHAN_INFO_SCALE), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),\
> +	.info_mask_separate_available = \
> +		BIT(IIO_CHAN_INFO_SCALE),  \
> +	.info_mask_shared_by_type_available = \
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> +}
> +
> +static const struct iio_chan_spec mlx90393_channels[] = {
> +	MLX90393_CHAN(0, X, MLX90393_CHAN_X),
> +	MLX90393_CHAN(1, Y, MLX90393_CHAN_Y),
> +	MLX90393_CHAN(2, Z, MLX90393_CHAN_Z),
> +	{
> +		.type = IIO_TEMP,
> +		.address = MLX90393_CHAN_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_OFFSET) |
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_separate_available =
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),

It would make the attribute names a bit more symetric if 
IIO_CHAN_INFO_OVERSAMPLING_RATIO was shared_by_type and
IIO_CHAN_INFO_SCALE was separate just like the mag channels.

> +	},
> +};
> +
> +/*
> + * Calculate total conversion time in microseconds.
> + *
> + * Formula derived from datasheet timing equations.
> + * Datasheet: Table 8, Page no. 12
> + *
> + * Abbreviations:
> + * TCONVM	-> Single Magnetic axis conversion time
> + * TCONVT	-> Temperature conversion time
> + * TSTBY	-> Time from IDLE to STANDBY
> + * TACTIVE	-> Time from STBY to ACTIVE
> + * TCONV_END	-> Time to end analog active mode
> + */
> +static int mlx90393_get_tconv_us(struct mlx90393_data *data)
> +{
> +	const int osr = data->osr;
> +	const int osr2 = data->osr2;
> +	const int df = data->dig_filt;
> +
> +	int tconvm;
> +	int tconvt;
> +
> +	int m = 3; /* X,Y,Z */

const

> +
> +	/*
> +	 * TCONVM = 67 + 64 * 2^OSR * (2 + 2^DIG_FILT)
> +	 */

Can be single line comment.

> +	tconvm = 67 + (64 * BIT(osr) * (2 + BIT(df)));
> +
> +	/*
> +	 * TCONVT = 67 + 192 * 2^OSR2
> +	 */

ditto

> +	tconvt = 67 + (192 * BIT(osr2));
> +	/*
> +	 * Total conversion time:
> +	 * TSTBY + TACTIVE + m * TCONVM + TCONVT + TCONV_END
> +	 */
> +	return 220 + 360 + (m * tconvm) + tconvt + 120;

Unnecessary ().

> +}
> +
> +static int mlx90393_xfer(struct mlx90393_data *data,
> +			 const u8 *tx, int tx_len,
> +			 u8 *rx, int rx_len)
> +{
> +	return data->ops->xfer(data->bus_context, tx, tx_len, rx, rx_len);
> +}
> +
> +static int mlx90393_check_status(u8 cmd, u8 status)
> +{
> +	/* Datasheet: Table 12: Status byte definition */
> +
> +	/* Always validate error bit */
> +	if (status & MLX90393_STATUS_ERROR)
> +		return -EIO;
> +
> +	switch (cmd & MLX90393_CMD_MASK) {
> +	case MLX90393_CMD_RM:
> +		/*
> +		 * D1:D0 indicates response availability
> +		 * 00 means invalid/no measurement
> +		 */
> +		if ((status & MLX90393_STATUS_RESP) == 0)
> +			return -EIO;

Should this have a different error code? In other words,
does this just mean "try again later and there might be
data"?

> +		return 0;
> +	case MLX90393_CMD_RT:
> +		/* Reset acknowledge */
> +		if ((status & MLX90393_STATUS_RT) == 0)
> +			return -EIO;


Datasheet calls this RS bit, not RT (which is the cooresponding
command).

> +		return 0;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int mlx90393_write_cmd(struct mlx90393_data *data, u8 cmd)
> +{
> +	u8 status;
> +	int ret;
> +
> +	ret = mlx90393_xfer(data, &cmd, 1, &status, 1);
> +	if (ret)
> +		return ret;
> +
> +	return mlx90393_check_status(cmd, status);
> +}
> +
> +static int mlx90393_read_cmd(struct mlx90393_data *data, u8 cmd, u8 *rx,
> +			     int rx_len)
> +{
> +	int ret;
> +
> +	ret = mlx90393_xfer(data, &cmd, 1, rx, rx_len);
> +	if (ret)
> +		return ret;
> +
> +	return mlx90393_check_status(cmd, rx[0]);
> +}
> +
> +static int mlx90393_read_reg(struct mlx90393_data *data, u8 reg, u16 *val)
> +{
> +	u8 tx[2];
> +	u8 rx[3];
> +	int ret;
> +
> +	tx[0] = MLX90393_CMD_RR;
> +	/* Register address is encoded in bits [7:2] */
> +	tx[1] = reg << 2;
> +
> +	ret = mlx90393_xfer(data, tx, sizeof(tx), rx, sizeof(rx));
> +	if (ret)
> +		return ret;
> +
> +	ret = mlx90393_check_status(tx[0], rx[0]);
> +	if (ret)
> +		return ret;
> +
> +	*val = get_unaligned_be16(&rx[1]);
> +
> +	return 0;
> +}
> +
> +static int mlx90393_write_reg(struct mlx90393_data *data, u8 reg, u16 val)
> +{
> +	u8 tx[4];
> +	u8 status;
> +	int ret;
> +
> +	tx[0] = MLX90393_CMD_WR;
> +	put_unaligned_be16(val, &tx[1]);
> +	/* Register address is encoded in bits [7:2] */
> +	tx[3] = reg << 2;
> +
> +	ret = mlx90393_xfer(data, tx, sizeof(tx), &status, 1);
> +	if (ret)
> +		return ret;
> +
> +	return mlx90393_check_status(tx[0], status);
> +}
> +
> +static int mlx90393_update_bits(struct mlx90393_data *data, u8 reg,
> +				u16 mask, u16 val)
> +{
> +	u16 reg_val;
> +	int ret;
> +
> +	ret = mlx90393_read_reg(data, reg, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	reg_val &= ~mask;
> +	reg_val |= (val << __ffs(mask)) & mask;

Usually, we would call FIELD_PREP() before passing val rather
than doing this here. As it is, this doesn't allow updating
multiple fields at the same time.

> +
> +	return mlx90393_write_reg(data, reg, reg_val);
> +}

Why not create a regmap with a custom bus type instead of reimplementing
functions like this?

> +
> +static int mlx90393_read_measurement(struct mlx90393_data *data,
> +				     enum mlx90393_channels chan, int *val)
> +{
> +	u8 rx[9];
> +	int ret;
> +
> +	/* Start measurement */
> +	ret = mlx90393_write_cmd(data, MLX90393_CMD_SM | MLX90393_MEASURE_ALL);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait conversion */
> +	fsleep(mlx90393_get_tconv_us(data));
> +
> +	/* Read measurement */
> +	ret = mlx90393_read_cmd(data, MLX90393_CMD_RM | MLX90393_MEASURE_ALL,
> +				rx, sizeof(rx));
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Measurement response layout:
> +	 * [status][temp][x][y][z]

Would be more useful if this also said how many bytes each field is.
Although not sure how useful comment is since we can see this below.
Other than mentioning that status is ignored.

> +	 */
> +
> +	switch (chan) {
> +	case MLX90393_CHAN_TEMP:
> +		*val = get_unaligned_be16(&rx[1]);
> +		return 0;
> +
> +	case MLX90393_CHAN_X:
> +		*val = sign_extend32(get_unaligned_be16(&rx[3]), 15);
> +		return 0;
> +
> +	case MLX90393_CHAN_Y:
> +		*val = sign_extend32(get_unaligned_be16(&rx[5]), 15);
> +		return 0;
> +
> +	case MLX90393_CHAN_Z:
> +		*val = sign_extend32(get_unaligned_be16(&rx[7]), 15);
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mlx90393_get_scale(struct mlx90393_data *data,

Would be nice if the function name included _mag_ since this doesn't
include the temperature scale.

> +			      const struct iio_chan_spec *chan,
> +			      int *val, int *val2)
> +{
> +	enum mlx90393_axis_type axis;
> +	u8 res;
> +
> +	if (chan->channel2 == IIO_MOD_Z) {
> +		axis = MLX90393_AXIS_TYPE_Z;
> +		res = data->res_z;
> +	} else {
> +		axis = MLX90393_AXIS_TYPE_XY;
> +		res = data->res_xy;
> +	}
> +
> +	*val = 0;
> +	*val2 = mlx90393_scale_table[axis][data->gain_sel][res];
> +
> +	return IIO_VAL_INT_PLUS_NANO;
> +}
> +
> +static int mlx90393_find_scale(struct mlx90393_data *data, bool z_axis,

same here.

> +			       int val, int val2,
> +			       int *gain)

don't need to wrap this last line.

> +{
> +	u8 res;
> +	enum mlx90393_axis_type axis;

Putting enum first (like the previous funtion) looks nicer.

> +
> +	if (z_axis) {
> +		axis = MLX90393_AXIS_TYPE_Z;
> +		res = data->res_z;
> +	} else {
> +		axis = MLX90393_AXIS_TYPE_XY;
> +		res = data->res_xy;
> +	}
> +
> +	if (val != 0)
> +		return -EINVAL;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(mlx90393_scale_table[0]); i++) {
> +		if (mlx90393_scale_table[axis][i][res] == val2) {
> +			*gain = i;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int mlx90393_set_scale(struct mlx90393_data *data,
> +			      const struct iio_chan_spec *chan,
> +			      int val, int val2)
> +{
> +	bool z_axis;
> +	int gain;
> +	int ret;
> +
> +	z_axis = chan->channel2 == IIO_MOD_Z;
> +
> +	ret = mlx90393_find_scale(data, z_axis, val, val2, &gain);
> +	if (ret)
> +		return ret;
> +
> +	ret = mlx90393_update_bits(data, MLX90393_REG_CONF1, MLX90393_CONF1_GAIN_SEL,
> +				   gain);
> +	if (ret)
> +		return ret;
> +
> +	data->gain_sel = gain;
> +	return 0;
> +}
> +
> +static int mlx90393_get_osr(struct mlx90393_data *data, int *val)
> +{
> +	*val = mlx90393_osr_avail[data->osr];
> +	return IIO_VAL_INT;
> +}
> +
> +static int mlx90393_find_osr(int val, int *osr)
> +{
> +	for (unsigned int i = 0; i < MLX90393_OSR_MAX;  i++) {
> +		if (mlx90393_osr_avail[i] == val) {
> +			*osr = i;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}

The two functions above are quite simple and only used once each.
They could just be done inline instead.

> +
> +static int mlx90393_get_temp_osr2(struct mlx90393_data *data, int *val)
> +{
> +	*val = mlx90393_osr2_avail[data->osr2];
> +	return IIO_VAL_INT;
> +}
> +
> +static int mlx90393_set_osr(struct mlx90393_data *data, int val)

Would be more logical to keep this with other osr functions instead of
being in the middle of osr2 functions.

> +{
> +	int osr;
> +	int ret;
> +
> +	ret = mlx90393_find_osr(val, &osr);
> +	if (ret)
> +		return ret;
> +
> +	if (osr == data->osr)
> +		return 0;
> +
> +	ret = mlx90393_update_bits(data, MLX90393_REG_CONF3, MLX90393_CONF3_OSR,
> +				   osr);
> +	if (ret)
> +		return ret;
> +
> +	data->osr = osr;
> +	return 0;
> +}
> +
> +static int mlx90393_set_temp_osr2(struct mlx90393_data *data, int val)
> +{
> +	int ret;
> +
> +	if (val < 0 || val >= MLX90393_OSR2_MAX)
> +		return -EINVAL;

As mentioned already, allowing 0 doesn't make sense for oversampling_ratio.

> +
> +	if (val == data->osr2)
> +		return 0;
> +
> +	ret = mlx90393_update_bits(data, MLX90393_REG_CONF3, MLX90393_CONF3_OSR2,
> +				   val);
> +	if (ret)
> +		return ret;
> +
> +	data->osr2 = val;
> +
> +	return 0;
> +}
> +
> +static int mlx90393_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan,
> +				      long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mlx90393_write_raw(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      int val, int val2,
> +			      long mask)
> +{
> +	struct mlx90393_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE: {
> +		guard(mutex)(&data->lock);
> +		return mlx90393_set_scale(data, chan, val, val2);
> +	}
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
> +		guard(mutex)(&data->lock);
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			return mlx90393_set_temp_osr2(data, val);
> +
> +		case IIO_MAGN:
> +			return mlx90393_set_osr(data, val);
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
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

One too many tabs before }.

> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_MAGN:
> +			return mlx90393_get_scale(data, chan, val, val2);
> +
> +		case IIO_TEMP:
> +			/*
> +			 * Datasheet Table 7: Thermal Specification
> +			 */

Comment fits on one line.

> +			*val = 0;
> +			*val2 = 22124;

It this converting to millideg C?

From 45.2 LSB/deg C, I got:

			*val = 22;
			*val2 = 123893;

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
> +
> +static int mlx90393_read_avail(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       const int **vals,
> +			       int *type,
> +			       int *length,
> +			       long mask)
> +{
> +	struct mlx90393_data *data = iio_priv(indio_dev);
> +	static int scale_avail[MLX90393_GAIN_MAX][MLX90393_AXIS_MAX];
> +	enum mlx90393_axis_type axis;
> +	u8 res;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE: {
> +		guard(mutex)(&data->lock);
> +		axis = chan->channel2 == IIO_MOD_Z;
> +		res = axis ? data->res_z : data->res_xy;
> +
> +		for (unsigned int i = 0; i < MLX90393_GAIN_MAX; i++) {
> +			scale_avail[i][0] = 0;
> +			scale_avail[i][1] =
> +				mlx90393_scale_table[axis][i][res];
> +		}
> +
> +		*vals = &scale_avail[0][0];
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		*length = MLX90393_GAIN_MAX * MLX90393_AXIS_MAX;

Although MLX90393_AXIS_MAX has the correct value of 2, it doesn't
makes sense semantically. The 2 just comes from the fact we have
2 ints per value in the array. Just use `2` here directly.

> +		return IIO_AVAIL_LIST;
> +	}
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (chan->type == IIO_TEMP) {
> +			*vals = mlx90393_osr2_avail;
> +			*type = IIO_VAL_INT;
> +			*length = MLX90393_OSR2_MAX;
> +		} else {
> +			*vals = mlx90393_osr_avail;
> +			*type = IIO_VAL_INT;
> +			*length = MLX90393_OSR_MAX;
> +		}
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info mlx90393_info = {
> +	.read_raw = mlx90393_read_raw,
> +	.write_raw = mlx90393_write_raw,
> +	.read_avail = mlx90393_read_avail,
> +	.write_raw_get_fmt = mlx90393_write_raw_get_fmt,
> +};
> +
> +static int mlx90393_init(struct mlx90393_data *data)
> +{
> +	int ret;
> +	u16 reg;
> +
> +	/* Exit mode */
> +	ret = mlx90393_write_cmd(data, MLX90393_CMD_EX);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Datasheet section 15.4.1.2 (RT command), Figure 16:
> +	 * Wait 1 ms after EX command before issuing RT.
> +	 */
> +	fsleep(1 * USEC_PER_MSEC);
> +
> +	/* Reset device */
> +	ret = mlx90393_write_cmd(data, MLX90393_CMD_RT);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Datasheet section 15.4.1.2 (RT command), Figure 16:
> +	 * Wait 1.5 ms for the start-up sequence to complete.
> +	 */
> +	fsleep(1.5 * USEC_PER_MSEC);
> +
> +	ret = mlx90393_read_reg(data, MLX90393_REG_CONF1, &reg);
> +	if (ret)
> +		return ret;
> +
> +	data->gain_sel = FIELD_GET(MLX90393_CONF1_GAIN_SEL, reg);
> +	data->hallconf = FIELD_GET(MLX90393_CONF1_HALLCONF, reg);

We should know the default values after reset already, so could
hard-code them instead, no?

> +
> +	ret = mlx90393_read_reg(data, MLX90393_REG_CONF3, &reg);
> +	if (ret)
> +		return ret;
> +
> +	data->res_xy = FIELD_GET(MLX90393_CONF3_RES_X, reg);
> +	data->res_z = FIELD_GET(MLX90393_CONF3_RES_Z, reg);
> +	data->dig_filt = FIELD_GET(MLX90393_CONF3_DIG_FILT, reg);
> +	data->osr = FIELD_GET(MLX90393_CONF3_OSR, reg);
> +	data->osr2 = FIELD_GET(MLX90393_CONF3_OSR2, reg);

Same here.

> +
> +	return 0;
> +}
> +
> +int mlx90393_core_probe(struct device *dev,
> +			const struct mlx90393_transfer_ops *ops,
> +			void *context)
> +{
> +	struct iio_dev *indio_dev;
> +	struct mlx90393_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	data->dev = dev;
> +	data->ops = ops;
> +	data->bus_context = context;
> +
> +	indio_dev->name = "mlx90393";
> +	indio_dev->info = &mlx90393_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = mlx90393_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mlx90393_channels);
> +
> +	ret = mlx90393_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize device\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(mlx90393_core_probe, "IIO_MLX90393");
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Nikhil Gautam <nikhilgtr@gmail.com>");
> +MODULE_DESCRIPTION("MLX90393 magnetometer sensor driver");
> diff --git a/drivers/iio/magnetometer/mlx90393_i2c.c b/drivers/iio/magnetometer/mlx90393_i2c.c
> new file mode 100644
> index 000000000000..a9f0a40d15e8
> --- /dev/null
> +++ b/drivers/iio/magnetometer/mlx90393_i2c.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/array_size.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +
> +#include "mlx90393.h"
> +
> +/*
> + * MLX90393 commands use repeated-start transfers where
> + * every command is followed by a status/data response.
> + */
> +static int mlx90393_i2c_xfer(void *context,
> +			     const u8 *tx, int tx_len,
> +			     u8 *rx, int rx_len)
> +{
> +	struct i2c_client *client = context;
> +	int ret;
> +	struct i2c_msg msgs[2] = {
> +		[0] = {
> +			.addr = client->addr,
> +			.len = tx_len,
> +			.buf = (u8 *)tx,
> +		},
> +		[1] = {
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = rx_len,
> +			.buf = rx,
> +		},
> +	};
> +
> +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (ret != ARRAY_SIZE(msgs))
> +		return ret < 0 ? ret : -EIO;
> +
> +	return 0;
> +}
> +
> +static const struct mlx90393_transfer_ops mlx90393_i2c_ops = {
> +	.xfer = mlx90393_i2c_xfer,
> +};
> +
> +static int mlx90393_i2c_probe(struct i2c_client *client)
> +{
> +	return mlx90393_core_probe(&client->dev, &mlx90393_i2c_ops, client);
> +}
> +
> +static const struct i2c_device_id mlx90393_id[] = {
> +	{ .name = "mlx90393" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mlx90393_id);
> +
> +static const struct of_device_id mlx90393_of_match[] = {
> +	{ .compatible = "melexis,mlx90393" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mlx90393_of_match);
> +
> +static struct i2c_driver mlx90393_i2c_driver = {
> +	.driver = {
> +		.name = "mlx90393",
> +		.of_match_table = mlx90393_of_match,
> +	},
> +	.probe = mlx90393_i2c_probe,
> +	.id_table = mlx90393_id,
> +};
> +
> +module_i2c_driver(mlx90393_i2c_driver);
> +
> +MODULE_IMPORT_NS("IIO_MLX90393");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Nikhil Gautam <nikhilgtr@gmail.com>");
> +MODULE_DESCRIPTION("MLX90393 magnetometer sensor driver");

