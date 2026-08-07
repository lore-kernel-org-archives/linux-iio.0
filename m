Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF13B9DA5
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097385; cv=none; b=slLhDZbMLGymUTewlSUiNlGqA8pn9sNWPg7W/fwYV0aye/qTig0XZOeBElskon6s4edKfJIC4W5PtLlxSUgMp4DdlUu9c4sPc5eOywM/390FVsmYeKBP6SE6LNLEsny9Ezp0dXDORPXB+yiySi/0zphu5fXbND/3JSRjcda7lTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097385; c=relaxed/simple;
	bh=kkvN4gb6wnhnpHywzV2HxMDnk/4owwmNekU+f7EBo1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXDtNk2434LZhY2ogtubDJVc9gJUdc/cZbxPSsCxKHSfdk0BlvS8+PChnUUVDO27bd7Af4t12T9STYcWiR3IJOdTMS3YVfuT+DtpUTc6mWFR+m46RjoEcdq/PErwp6vOybv5ykiFLJhzZOML4M59oO3ffEeSt8oGXyYPblJxNfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGN/E6Jw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGN/E6Jw"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495590dde14so36351755e9.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 03:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097380; x=1786702180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fD7ThAmvp+kqow4uJIkOrcU+mQcOQJyaUh8KA4eCQB0=;
        b=bGN/E6JwXScNvMaFX54VeOdWpU4ZbxQnQaPtoTdr1dwRgRkuLSS0dBG4VNKA4rxgSy
         a+zMiF7u7jo8GoieUEbLgeVndb0Sg5ZbJ6tkfLPlitruUOL3tacaYE/JzejzuEycu7KG
         Y2IFJ2nvbvvUCzVGu3dYl1gtiZMaU8nQJ2cZRChZNLn3DmhYMdVRCV5lHcrCyYp4gcvg
         f+P5pfkQlS5Mwpr//cEgg2obgiM8PVoHoxnZRKK4km0ckK/h9+uZN63pMGZxwfL0zBQ4
         asVAVHKJ6A92sr0N18kSxzJ356EdRrMpXRDSVOkuQCbGI5AroOJa4lWYDpuH3JQ3GAOa
         Cc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097380; x=1786702180;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fD7ThAmvp+kqow4uJIkOrcU+mQcOQJyaUh8KA4eCQB0=;
        b=nFz3w7hAnxUarSVIEoiBg+VgL0Aitw00tmRC8VQRLAtE74Ui+KAB8Xtq3CZRcDeZzF
         ejqBTuGry2x7MZphfgDWsaMwMX+8xZbWOsmTQk7HLZee7ZpNs8tlbraaAOcP1dJlQbM8
         sT9s6xOL6sBkaCOh6ZaJA7xHGsJkiCLp3ZYcKghmIlC1IB8mwAz1zb9gi6UQxexW8eb7
         aJaEpeCs2jaLC5NKZRy4uIaBud7sL+EtWRzODIgCDmuvpgOckmxJ2BcJ2d+7g7nX7YXf
         QGyAkSGn4Bv2gdqcZNT2sWVnpDvwYewFOOvgoYQRPI45KZf0UoHwyNkuetdOUlKJTGwk
         n/oQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqX0ZCqLAb2COktFjcieAY7afzXdYZR/VbiuCjC63pv53rvJhQI57U0KLSCnR1LeqCOUEYLIjdteo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjYZ4udSM/XzDWi+i+96Rwve/mvBD5vdSI+7EHv4jNaZ/Gubz
	nVmGmmQtEQtaBJpS5hkMGoAagBpokUeG6azq12xmNjFKqo2qE94aBJaW
X-Gm-Gg: AR+sD12kYBHNsbnr2mPMCidhhZfB+pMQDMMLFUNHajZT7EvzvAyytQPcQT6mAmbTM9E
	phXlPL+lgKxNT99+36MuGyzab5rhLewRKLIqZbJhiRw8Ln2m9um7tPnYDvXuFC0Q2W6CdHTK99z
	NpfCl46DDB9yT+3MwIvsX16ZZ7ZFrhBYsPjMtKjO/sUS6IonGK6nWSJiaOlU8LaXRU6w+IO/hMa
	AXNu+iUMhhJjeYC2hJcn2O3TMo8Ryo5Ykewf2J28qen68nrlgzHb1r4WWFpfV2qY9+sz97QnkmR
	SFL31HhTPUrt77RwmcS/SCGD/EBFPBcuUd5HykZ4ZLYxGzCJKM6jCTABJUV8cmjwf+WA3KGYjRn
	ymW9wTBOyptHjFD/x0f/Jl/enMksN/qFqsGNAIFuYkgi4ZFoFWZiK/z/NsfxK/FMKiNYftUsbDQ
	VAOj2HSGDPBtTN3JIzshLeI1jWQAalgdxMpJng0o04OkM69hPykKzrUAyiXNXhWY7SRksSNPqJG
	avGaUZUYB+DcGFhk0JCtyW/cl2q4Gx7U2/2uu30Y1d5VxgMTylIte0C0ZkzJWVAhqnVsnOw6KfX
	Y8cvZnPECvgk3s/7Td2QYAERtsS1bTmVAc9dpgf3JAff1qYePmZrcugsDMIy+LPDLwQY/atbitI
	z4z2vK6IpsAaNVnTCg1vGcBadSvfIbaxwEAXnDNNVWEOaQvr1PLal6CS+3ijmB1yAHLVN2dA=
X-Received: by 2002:a05:600c:354a:b0:496:c249:dd9b with SMTP id 5b1f17b1804b1-4994e7c594dmr285458015e9.13.1786097379653;
        Fri, 07 Aug 2026 03:09:39 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995420cb4esm132400425e9.2.2026.08.07.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:09:39 -0700 (PDT)
Date: Fri, 7 Aug 2026 12:09:37 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Henrik Grimler" <henrik.grimler@axis.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH 2/3] iio: accel: Add support for ICM42370P
Message-ID: <20260807120937.00004e3c@gmail.com>
In-Reply-To: <20260806-b4-inv_icm42370p-v1-2-670837f5842f@axis.com>
References: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
	<20260806-b4-inv_icm42370p-v1-2-670837f5842f@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Aug 2026 14:46:28 +0200
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

> Add support for the Invensense ICM42370P MEMS MotionTracking 3-axis
> accelerometer with a built-in temperature sensor. Compared to other
> sensors from the same vendor ICM42370 uses a different way of handling
> register banks. Although the device supports I2C, SPI, and I3C,
> implement only I2C support.  Provide basic support for raw sensor
> reads and a sysfs interface for setting the calibration bias. Keep the
> embedded temperature sensor enabled because the device design does not
> allow it to be turned off.
>=20
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> ---

Hi Kanak,

my comments inline. This is an large driver and I've probably missed
something. Additionally, Sashiko had some pretty good remarks about
the scaling math etc. so please check out those:

https://sashiko.dev/#/patchset/20260806-b4-inv_icm42370p-v1-0-670837f5842f%=
40axis.com

Josh

> +config INV_ICM42370
> +	tristate
> +	select IIO_BUFFER
> +	select IIO_INV_SENSORS_TIMESTAMP
> +
> +config INV_ICM42370_I2C
> +	tristate "InvenSense ICM-42370 I2C driver"
> +	depends on I2C
> +	select INV_ICM42370
> +	select REGMAP_I2C
> +	help
> +	  This driver supports the InvenSense ICM-42730 motion tracking
> +	  devices over I2C.
> +
> +	  This driver can be built as a module. The module will be called
> +	  inv_icm42370_i2c.
> +
>  config KXSD9
>  	tristate "Kionix KXSD9 Accelerometer Driver"
>  	select IIO_BUFFER
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index fa440a8592839..6750b03edf518 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -49,6 +49,11 @@ obj-$(CONFIG_HID_SENSOR_ACCEL_3D) +=3D hid-sensor-acce=
l-3d.o
>  obj-$(CONFIG_IIO_KX022A)	+=3D kionix-kx022a.o
>  obj-$(CONFIG_IIO_KX022A_I2C)	+=3D kionix-kx022a-i2c.o
>  obj-$(CONFIG_IIO_KX022A_SPI)	+=3D kionix-kx022a-spi.o
> +
> +obj-$(CONFIG_INV_ICM42370) +=3D inv-icm42370.o
> +inv-icm42370-y +=3D inv_icm42370_core.o
> +obj-$(CONFIG_INV_ICM42370_I2C) +=3D inv_icm42370_i2c.o
> +
>  obj-$(CONFIG_KXCJK1013) +=3D kxcjk-1013.o
>  obj-$(CONFIG_KXSD9)	+=3D kxsd9.o
>  obj-$(CONFIG_KXSD9_SPI)	+=3D kxsd9-spi.o
> diff --git a/drivers/iio/accel/inv_icm42370.h b/drivers/iio/accel/inv_icm=
42370.h
> new file mode 100644
> index 0000000000000..9866a5e970dcd
> --- /dev/null
> +++ b/drivers/iio/accel/inv_icm42370.h
> @@ -0,0 +1,365 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2020 Invensense, Inc.
> + * Copyright (C) 2026 Axis Communications AB
> + */
> +
> +#ifndef INV_ICM42370_H_
> +#define INV_ICM42370_H_
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/regmap.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>

Sort these headers alphabetically. Also you're missing types.h.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/common/inv_sensors_timestamp.h>

Group the <linux/iio/*> headers separately (check other drivers in IIO
for reference).

> +
> +enum inv_icm42370_chip {
> +	INV_CHIP_INVALID,
> +	INV_CHIP_ICM42370,
> +	INV_CHIP_NB,
> +};
> +
> +/* sensor configuration struct */
> +struct inv_icm42370_conf {
> +	int mode;
> +	int fs;
> +	int odr;
> +	int filter;
> +};
> +
> +/**
> + * struct inv_icm42370_data - driver state variables
> + * @lock:		lock for serializing multiple register access.
> + * @name:		chip name.
> + * @map:		regmap pointer.
> + * @vdd_supply:		VDD voltage regulator for the chip.
> + * @vddio_supply:	I/O voltage regulator for the chip.
> + * @indio_accel:	accelerometer IIO device.
> + * @sensor_state:	per-sensor state tracking (e.g. power, ODR).
> + * @buffer:		buffer for reading data registers, aligned for DMA.
> + * @accel_calibbias:	accelerometer calibration bias for X, Y, and Z axes.
> + * @fifo:		FIFO state and configuration.
> + * @timestamp:		interrupt timestamp.
> + * @chip:		chip identifier.
> + * @conf:		chip sensors configurations.
> + */
> +struct inv_icm42370_data {
> +	struct mutex lock;
> +	const char *name;
> +	struct regmap *map;
> +	struct regulator *vdd_supply;
> +	struct regulator *vddio_supply;
> +	struct iio_dev *indio_accel;

You probably don't need this.

> +	struct inv_icm42370_sensor_state *sensor_state;
> +	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);

You shouldn't have a DMA buffer in the middle of your struct, move it to
the end to ensure the buffer gets its own cacheline to prevent the CPU
overwriting the DMA area on accident.

> +	s16 accel_calibbias[3];
> +	struct inv_icm42370_fifo fifo;

You add buffer support in patch 3, yet this is in patch 2, causing build
failures if you compile without buffer support. Move this to patch 3.

> +	s64 timestamp;
> +	enum inv_icm42370_chip chip;
> +	struct inv_icm42370_conf conf;
> +};
> +
> +#define INV_ICM42370_TEMP_CHAN(_index) \
> +	{								\
> +		.type =3D IIO_TEMP,					\
> +		.info_mask_separate =3D					\
> +			BIT(IIO_CHAN_INFO_RAW) |			\
> +			BIT(IIO_CHAN_INFO_OFFSET) |			\
> +			BIT(IIO_CHAN_INFO_SCALE),			\
> +		.scan_index =3D _index,					\
> +		.scan_type =3D {						\
> +			.sign =3D 's',					\
> +			.realbits =3D 16,					\
> +			.storagebits =3D 16,				\
> +		},							\
> +	}
> +
> +#define INV_ICM42370_ACCEL_CHAN(_modifier, _index) \
> +	{								\
> +		.type =3D IIO_ACCEL,					\
> +		.modified =3D 1,						\
> +		.channel2 =3D _modifier,					\
> +		.info_mask_separate =3D					\
> +			BIT(IIO_CHAN_INFO_RAW) |			\
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
> +		.info_mask_shared_by_type =3D				\
> +			BIT(IIO_CHAN_INFO_SCALE),			\
> +		.info_mask_shared_by_type_available =3D			\
> +			BIT(IIO_CHAN_INFO_SCALE) |			\
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
> +		.info_mask_shared_by_all =3D				\
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +		.info_mask_shared_by_all_available =3D			\
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +		.scan_index =3D _index,					\
> +		.scan_type =3D {						\
> +			.sign =3D 's',					\
> +			.realbits =3D 16,					\
> +			.storagebits =3D 16,				\
> +			.endianness =3D IIO_BE,				\
> +		},							\
> +	}
> +
> +enum inv_icm42370_accel_scan {
> +	INV_ICM42370_ACCEL_SCAN_X,
> +	INV_ICM42370_ACCEL_SCAN_Y,
> +	INV_ICM42370_ACCEL_SCAN_Z,
> +	INV_ICM42370_ACCEL_SCAN_TEMP,
> +};
> +
> +enum inv_icm42370_sensor_mode {
> +	INV_ICM42370_SENSOR_MODE_OFF,
> +	INV_ICM42370_SENSOR_MODE_STANDBY,
> +	INV_ICM42370_SENSOR_MODE_LOW_POWER,
> +	INV_ICM42370_SENSOR_MODE_LOW_NOISE,
> +	INV_ICM42370_SENSOR_MODE_NB,
> +};
> +
> +enum inv_icm42370_filter {
> +	/* Low-Noise mode sensor data filter bandwidth*/
> +	INV_ICM42370_UI_FILT_BW_LP_FILTER_BYPASSED,
> +	/* Low-Power mode sensor data filter (averaging) */
> +	INV_ICM42370_FILTER_AVG_2X,
> +	INV_ICM42370_FILTER_AVG_4X,
> +	INV_ICM42370_FILTER_AVG_8X,
> +	INV_ICM42370_FILTER_AVG_16X,
> +	INV_ICM42370_FILTER_AVG_32X,
> +	INV_ICM42370_FILTER_AVG_64X,
> +	INV_ICM42370_FILTER_AVG_NB,
> +};
> +
> +/**
> + * struct inv_icm42370_sensor_state - sensor state variables
> + * @scales:		table of scales.
> + * @scales_len:		length (nb of items) of the scales table.
> + * @power_mode:		sensor requested power mode (for common frequencies)
> + * @filter:		sensor filter.
> + * @ts:			timestamp module states.
> + */
> +struct inv_icm42370_sensor_state {
> +	const int *scales;
> +	size_t scales_len;
> +	enum inv_icm42370_sensor_mode power_mode;
> +	enum inv_icm42370_filter filter;
> +	struct inv_sensors_timestamp ts;
> +};
> +
> +/* serial bus slew rates */
> +enum inv_icm42370_slew_rate {
> +	INV_ICM42370_SLEW_RATE_20_60NS,
> +	INV_ICM42370_SLEW_RATE_12_36NS,
> +	INV_ICM42370_SLEW_RATE_6_19NS,
> +	INV_ICM42370_SLEW_RATE_4_14NS,
> +	INV_ICM42370_SLEW_RATE_2_8NS,
> +	INV_ICM42370_SLEW_RATE_INF_2NS,
> +};
> +
> +/* accelerometer fullscale values */
> +enum inv_icm42370_accel_fs {
> +	INV_ICM42370_ACCEL_FS_16G,
> +	INV_ICM42370_ACCEL_FS_8G,
> +	INV_ICM42370_ACCEL_FS_4G,
> +	INV_ICM42370_ACCEL_FS_2G,
> +	INV_ICM42370_ACCEL_FS_NB,
> +};
> +
> +/* ODR suffixed by LN or LP are Low-Noise or Low-Power mode only */
> +enum inv_icm42370_odr {
> +	INV_ICM42370_ODR_1_6KHZ_LN =3D 5,
> +	INV_ICM42370_ODR_800HZ_LN,
> +	INV_ICM42370_ODR_400HZ,
> +	INV_ICM42370_ODR_200HZ,
> +	INV_ICM42370_ODR_100HZ,
> +	INV_ICM42370_ODR_50HZ,
> +	INV_ICM42370_ODR_25HZ,
> +	INV_ICM42370_ODR_12_5HZ,
> +	INV_ICM42370_ODR_6_25HZ_LP,
> +	INV_ICM42370_ODR_3_125HZ_LP,
> +	INV_ICM42370_ODR_1_5625HZ_LP,
> +	INV_ICM42370_ODR_NB,
> +};
> +
> +enum inv_icm42370_mregs {
> +	INV_ICM42370_MREG1,
> +	INV_ICM42370_MREG2 =3D 0x28,
> +	INV_ICM42370_MREG3 =3D 0x50,
> +};
> +
> +/* Temperature sensor filters */
> +enum inv_icm42370_temp_filter {
> +	INV_ICM42370_TEMP_FILT_BW_DLPF_BYPASS,
> +	INV_ICM42370_TEMP_FILT_BW_DLPF_180HZ,
> +	INV_ICM42370_TEMP_FILT_BW_DLPF_72HZ,
> +	INV_ICM42370_TEMP_FILT_BW_DLPF_34HZ,
> +	INV_ICM42370_TEMP_FILT_BW_DLPF_16HZ,
> +	INV_ICM42370_TEMP_FILT_BW_DLPF_8HZ,
> +	INV_ICM42370_TEMP_FILT_BW_DLPF_4HZ,
> +	INV_ICM42370_TEMP_FILT_BW_DLPF_NB,
> +};
> +
> +/* IIO format int + micro */

No need for this comment.

> +static const int inv_icm42370_accel_odr[] =3D {
> +	/* 1.5625Hz */

No need for these comments.

> +	1, 562500,
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
> +	/* 1.6kHz */
> +	1600, 0,
> +};
> +
> +#define INV_ICM42370_SENSOR_CONF_INIT { -1, -1, -1, -1 }
> +
> +/* Registers in USER BANK 1 */
> +#define INV_ICM42370_REG_MCLK_RDY 0x0
> +#define INV_ICM42370_REG_DEVICE_CONFIG 0x01
> +#define INV_ICM42370_REG_SIGNAL_PATH_RESET 0x02
> +#define INV_ICM42370_REG_DRIVE_CONFIG1 0x03
> +#define INV_ICM42370_REG_DRIVE_CONFIG2 0x04
> +#define INV_ICM42370_REG_DRIVE_CONFIG3 0x05
> +#define INV_ICM42370_REG_INT_CONFIG 0x06
> +#define INV_ICM42370_REG_TEMP_DATA1 0x09
> +#define INV_ICM42370_REG_TEMP_DATA0 0x0A
> +#define INV_ICM42370_REG_ACCEL_DATA_X1 0x0B
> +#define INV_ICM42370_REG_ACCEL_DATA_X0 0x0C
> +#define INV_ICM42370_REG_ACCEL_DATA_Y1 0x0D
> +#define INV_ICM42370_REG_ACCEL_DATA_Y0 0x0E
> +#define INV_ICM42370_REG_ACCEL_DATA_Z1 0x0F
> +#define INV_ICM42370_REG_ACCEL_DATA_Z0 0x10
> +#define INV_ICM42370_REG_ACCEL_CONFIG0 0x21
> +#define INV_ICM42370_REG_PWR_MGMT0 0x1F
> +#define INV_ICM42370_REG_INTF_CONFIG6 0x23
> +#define INV_ICM42370_REG_FIFO_CONFIG1 0x28
> +#define INV_ICM42370_REG_FIFO_WATERMARK 0x29
> +#define INV_ICM42370_REG_INT_SOURCE0 0x2B
> +#define INV_ICM42370_REG_INT_STATUS 0x3A
> +#define INV_ICM42370_REG_TEMP_CONFIG0 0x34
> +#define INV_ICM42370_REG_INTF_CONFIG0 0x35
> +#define INV_ICM42370_REG_WHO_AM_I 0x75
> +#define INV_ICM42370_REG_BLK_SEL_W 0x79
> +#define INV_ICM42370_REG_MADDR_W 0x7A
> +#define INV_ICM42370_REG_M_W 0x7B
> +#define INV_ICM42370_REG_BLK_SEL_R 0x7C
> +#define INV_ICM42370_REG_MADDR_R 0x7D
> +#define INV_ICM42370_REG_M_R 0x7E
> +
> +#define INV_ICM42370_DRIVE_CONFIG1_I3C_DDR_MASK GENMASK(5, 3)
> +#define INV_ICM42370_DRIVE_CONFIG1_I3C_DDR(_rate) \
> +	FIELD_PREP(INV_ICM42370_DRIVE_CONFIG1_I3C_DDR_MASK, (_rate))
> +
> +#define INV_ICM42370_DRIVE_CONFIG1_I3C_SDR_MASK GENMASK(2, 0)
> +#define INV_ICM42370_DRIVE_CONFIG1_I3C_SDR(_rate) \
> +	FIELD_PREP(INV_ICM42370_DRIVE_CONFIG1_I3C_SDR_MASK, (_rate))
> +#define INV_ICM42370_DRIVE_CONFIG2_I2C_MASK GENMASK(5, 3)
> +#define INV_ICM42370_DRIVE_CONFIG2_I2C(_rate) \
> +	FIELD_PREP(INV_ICM42370_DRIVE_CONFIG2_I2C_MASK, (_rate))
> +#define INV_ICM42370_DRIVE_CONFIG3_SPI_MASK GENMASK(2, 0)
> +#define INV_ICM42370_DRIVE_CONFIG3_SPI(_rate) \
> +	FIELD_PREP(INV_ICM42370_DRIVE_CONFIG3_SPI_MASK, (_rate))
> +
> +#define INV_ICM42370_SIGNAL_PATH_RESET_FIFO_FLUSH BIT(2)
> +#define INV_ICM42370_FIFO_CONFIG_MODE_MASK BIT(0)
> +#define INV_ICM42370_FIFO_CONFIG_BYPASS_MASK BIT(1)
> +#define INV_ICM42370_FIFO_CONFIG_STREAM \
> +	FIELD_PREP(INV_ICM42370_FIFO_CONFIG_MODE_MASK, 0)
> +#define INV_ICM42370_FIFO_CONFIG_STOP_ON_FULL \
> +	FIELD_PREP(INV_ICM42370_FIFO_CONFIG_MODE_MASK, 1)
> +#define INV_ICM42370_FIFO_CONFIG_BYPASS \
> +	FIELD_PREP(INV_ICM42370_FIFO_CONFIG_BYPASS_MASK, 1)
> +
> +#define INV_ICM42370_INT_CONFIG_INT2_LATCHED BIT(5)
> +#define INV_ICM42370_INT_CONFIG_INT2_PUSH_PULL BIT(4)
> +#define INV_ICM42370_INT_CONFIG_INT2_ACTIVE_HIGH BIT(3)
> +#define INV_ICM42370_INT_CONFIG_INT2_ACTIVE_LOW 0x00
> +#define INV_ICM42370_INT_CONFIG_INT1_LATCHED BIT(2)
> +#define INV_ICM42370_INT_CONFIG_INT1_PUSH_PULL BIT(1)
> +#define INV_ICM42370_INT_CONFIG_INT1_ACTIVE_HIGH BIT(0)
> +#define INV_ICM42370_INT_CONFIG_INT1_ACTIVE_LOW 0x00
> +
> +#define INV_ICM42370_INT_STATUS_FIFO_THS BIT(2)
> +#define INV_ICM42370_INT_STATUS_FIFO_FULL BIT(1)
> +
> +#define INV_ICM42370_INT_SOURCE0_FIFO_THS_INT1_EN BIT(2)
> +
> +/* Registers in MREG1 USER BANK 1*/
> +#define INV_ICM42370_REG_TMST_CONFIG1 0x00
> +#define INV_ICM42370_REG_FIFO_CONFIG5 0x01
> +#define INV_ICM42370_REG_FIFO_CONFIG6 0x02
> +#define INV_ICM42370_REG_INT_CONFIG1 0x05
> +#define INV_ICM42370_REG_OFFSET_USER4 0x52
> +#define INV_ICM42370_REG_OFFSET_USER5 0x53
> +#define INV_ICM42370_REG_OFFSET_USER6 0x54
> +#define INV_ICM42370_REG_OFFSET_USER7 0x55
> +#define INV_ICM42370_REG_OFFSET_USER8 0x56
> +
> +#define INV_ICM42370_TMST_CONFIG_TMST_DELTA_EN BIT(2)
> +#define INV_ICM42370_TMST_CONFIG_TMST_EN BIT(0)
> +
> +#define INV_ICM42370_FIFO_CONFIG5_WM_GT_TH BIT(5)
> +#define INV_ICM42370_FIFO_CONFIG5_RESUME_PARTIAL_RD BIT(4)
> +#define INV_ICM42370_FIFO_CONFIG5_ACCEL_EN BIT(0)
> +
> +#define INV_ICM42370_INT_CONFIG1_ASYNC_RESET BIT(4)
> +
> +#define INV_ICM42370_WHOAMI_VALUE 0x0D
> +
> +#define INV_ICM42370_FIFO_FLUSH_BIT_MASK BIT(2)
> +
> +#define INV_ICM42370_INTF_CONFIG0_FIFO_COUNT_ENDIAN BIT(5)
> +#define INV_ICM42370_INTF_CONFIG0_SENSOR_DATA_ENDIAN BIT(4)
> +
> +#define INV_ICM42370_FIFO_WATERMARK_VAL(_wm) cpu_to_le16((_wm) & GENMASK=
(11, 0))
> +/* FIFO is 2048 bytes, let 12 samples for reading latency */
> +#define INV_ICM42370_FIFO_WATERMARK_MAX (2048 - 12 * 16)
> +
> +#define INV_ICM42370_PWR_MGMT0(_mode) FIELD_PREP(GENMASK(1, 0), (_mode))
> +
> +#define INV_ICM42370_ACCEL_CONFIG0_FS(_fs) FIELD_PREP(GENMASK(6, 5), (_f=
s))
> +#define INV_ICM42370_ACCEL_CONFIG0_ODR(_odr) FIELD_PREP(GENMASK(3, 0), (=
_odr))
> +
> +#define INV_ICM42370_TEMP_FILT_BW_DLPF(_dlpf) FIELD_PREP(GENMASK(6, 4), =
(_dlpf))
> +
> +#define INV_ICM42370_MCLK_RDY_BIT BIT(3)
> +#define INV_ICM42370_SOFT_RESET_BIT BIT(4)
> +#define INV_ICM42370_ACCEL_MODE_LN 0x03
> +
> +#define INV_ICM42370_DATA_INVALID -32768
> +#define INV_ICM42370_ACCEL_STARTUP_TIME_MS 10
> +
> +typedef int (*inv_icm42370_bus_setup)(struct inv_icm42370_data *);
> +extern const struct regmap_config inv_icm42370_regmap_config;
> +
> +int inv_icm42370_core_probe(struct regmap *regmap, int chip, int irq,
> +			    inv_icm42370_bus_setup bus_setup);
> +u32 inv_icm42370_odr_to_period(enum inv_icm42370_odr odr);
> +
> +int inv_icm42370_core_probe(struct regmap *regmap, int chip, int irq,
> +			    inv_icm42370_bus_setup bus_setup);
> +
> +struct iio_dev *inv_icm42370_accel_init(struct iio_dev *indio_dev,
> +					struct inv_icm42370_data *data);
> +
> +int inv_icm42370_set_accel_conf(struct inv_icm42370_data *dev_data,
> +				struct inv_icm42370_conf *conf,
> +				unsigned int *sleep_ms);
> +
> +int inv_icm42370_accel_parse_fifo(struct iio_dev *indio_dev);
> +
> +#endif
> diff --git a/drivers/iio/accel/inv_icm42370_core.c b/drivers/iio/accel/in=
v_icm42370_core.c
> new file mode 100644
> index 0000000000000..9f6c302e6f331
> --- /dev/null
> +++ b/drivers/iio/accel/inv_icm42370_core.c
> @@ -0,0 +1,1251 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 Invensense, Inc.
> + * Copyright (C) 2026 Axis Communications AB
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/irq.h>
> +#include <linux/slab.h>
> +#include <linux/mod_devicetable.h>

As Uwe said in his email, remove this.

> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +

You're missing types.h, bitops.h, err.h, array_size.h and <asm/byteorder.h>.

> +#include <linux/iio/common/inv_sensors_timestamp.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include "inv_icm42370.h"
> +
> +const struct regmap_config inv_icm42370_regmap_config =3D {
> +	.name =3D "inv_icm42370",
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D 0x7E,
> +};
> +EXPORT_SYMBOL_NS_GPL(inv_icm42370_regmap_config, "IIO_ICM42370");
> +
> +static const struct inv_icm42370_conf inv_icm42370_default_conf =3D {
> +	.mode =3D INV_ICM42370_SENSOR_MODE_LOW_NOISE,
> +	.fs =3D INV_ICM42370_ACCEL_FS_16G,
> +	.odr =3D INV_ICM42370_ODR_400HZ,
> +	.filter =3D INV_ICM42370_FILTER_AVG_16X,
> +};
> +
> +static const struct iio_chan_spec inv_icm42370_accel_channels[] =3D {
> +	INV_ICM42370_ACCEL_CHAN(IIO_MOD_X, INV_ICM42370_ACCEL_SCAN_X),
> +	INV_ICM42370_ACCEL_CHAN(IIO_MOD_Y, INV_ICM42370_ACCEL_SCAN_Y),
> +	INV_ICM42370_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42370_ACCEL_SCAN_Z),
> +	INV_ICM42370_TEMP_CHAN(INV_ICM42370_ACCEL_SCAN_TEMP),
> +};
> +
> +/* IIO format int + nano */
> +static const int inv_icm42370_accel_scale[] =3D {
> +	/* +/- 16G =3D> 2*16*9.80665 / (2**15) m/s-2 */
> +	[2 * INV_ICM42370_ACCEL_FS_16G] =3D 0,
> +	[2 * INV_ICM42370_ACCEL_FS_16G + 1] =3D 9576807,
> +	/* +/- 8G =3D> 2*8*9.80665 / (2**15) m/s-2 */
> +	[2 * INV_ICM42370_ACCEL_FS_8G] =3D 0,
> +	[2 * INV_ICM42370_ACCEL_FS_8G + 1] =3D 4788403,
> +	/* +/- 4G =3D> 2*4*9.80665 / (2**15) m/s-2 */
> +	[2 * INV_ICM42370_ACCEL_FS_4G] =3D 0,
> +	[2 * INV_ICM42370_ACCEL_FS_4G + 1] =3D 2394202,
> +	/* +/- 2G =3D> 2*2*9.80665 / (2**15) m/s-2 */
> +	[2 * INV_ICM42370_ACCEL_FS_2G] =3D 0,
> +	[2 * INV_ICM42370_ACCEL_FS_2G + 1] =3D 1197101,
> +};
> +
> +/**
> + *  inv_icm42370_odr_to_period() - map ODR to Period
> + *  @odr - enum of ODR value
> + *
> + * Returns the period in nanoseconds
> + */
> +u32 inv_icm42370_odr_to_period(enum inv_icm42370_odr odr)
> +{
> +	static u32 odr_periods[INV_ICM42370_ODR_NB] =3D {
> +		/* reserved values */
> +		0,
> +		0,
> +		0,
> +		0,
> +		0,
> +		/* 1.6kHz */

Maybe a personal preference, but wouldn't it be better to have
the comment on the same line as the value? I find this harder
to read.

> +		625000,
> +		/* 800Hz */
> +		1250000,
> +		/* 400Hz */
> +		2500000,
> +		/* 200Hz */
> +		5000000,
> +		/* 100Hz */
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
> +
> +/* ODR suffixed by LN or LP are Low-Noise or Low-Power mode only */
> +static const int inv_icm42370_accel_odr_conv[] =3D {
> +	INV_ICM42370_ODR_1_6KHZ_LN,   INV_ICM42370_ODR_800HZ_LN,
> +	INV_ICM42370_ODR_400HZ,	      INV_ICM42370_ODR_200HZ,
> +	INV_ICM42370_ODR_100HZ,	      INV_ICM42370_ODR_50HZ,
> +	INV_ICM42370_ODR_25HZ,	      INV_ICM42370_ODR_12_5HZ,
> +	INV_ICM42370_ODR_6_25HZ_LP,   INV_ICM42370_ODR_3_125HZ_LP,
> +	INV_ICM42370_ODR_1_5625HZ_LP, INV_ICM42370_ODR_NB,
> +};
> +
> +/**
> + * inv_icm42370_mreg_check() - check registers before accessing the regi=
sters in other banks
> + *
> + * @map: regmap of the device
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_mreg_check(struct regmap *map)
> +{
> +	int tmp;
> +
> +	regmap_read(map, INV_ICM42370_REG_MCLK_RDY, &tmp);
> +	if (!(tmp & INV_ICM42370_MCLK_RDY_BIT))
> +		return -EINVAL;
> +	regmap_read(map, INV_ICM42370_REG_PWR_MGMT0, &tmp);
> +	if (tmp !=3D INV_ICM42370_PWR_MGMT0(INV_ICM42370_SENSOR_MODE_LOW_NOISE))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/**
> + * inv_icm42370_mreg_write() - routine for writing to other bank registe=
rs
> + *
> + * @map: regmap of the device
> + * @bank: register bank being accessed
> + * @addr: address of the register being accessed
> + * @val: value written to the register
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_mreg_write(struct regmap *map, u8 bank, u8 addr,=
 u8 val)
> +{
> +	int ret;
> +
> +	ret =3D inv_icm42370_mreg_check(map);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(map, INV_ICM42370_REG_BLK_SEL_W, bank);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret =3D regmap_write(map, INV_ICM42370_REG_MADDR_W, addr);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret =3D regmap_write(map, INV_ICM42370_REG_M_W, val);
> +	if (ret)
> +		return -EINVAL;
> +
> +	usleep_range(10, 20);
> +	return regmap_write(map, INV_ICM42370_REG_BLK_SEL_W, 0x00);
> +}
> +
> +/**
> + * inv_icm42370_mreg_read() - routine for reading from other bank regist=
ers
> + *
> + * @map: regmap of the device
> + * @bank: register bank being accessed
> + * @addr: address of the register being accessed
> + * @val: pointer to store the register's data
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_mreg_read(struct regmap *map, u8 bank, u8 addr, =
u8 *val)
> +{
> +	int ret;
> +	unsigned int read_val;
> +
> +	ret =3D inv_icm42370_mreg_check(map);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(map, INV_ICM42370_REG_BLK_SEL_R, bank);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret =3D regmap_write(map, INV_ICM42370_REG_MADDR_R, addr);
> +	if (ret)
> +		return -EINVAL;
> +
> +	usleep_range(10, 20);

fsleep() will guarantee at least 10ms of sleep and it chooses
the optimal way of achieving this.

> +	ret =3D regmap_read(map, INV_ICM42370_REG_M_R, &read_val);
> +	if (ret)
> +		return -EINVAL;
> +
> +	usleep_range(10, 20);
> +	*val =3D (u8)read_val;
> +
> +	return regmap_write(map, INV_ICM42370_REG_BLK_SEL_R, 0x00);
> +}
> +
> +/**
> + * inv_icm42370_set_conf() - set sensor configuration
> + *
> + * @data: pointer to struct containing the sensor data
> + * @conf: pointer to configuration data
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_set_conf(struct inv_icm42370_data *data,
> +				 const struct inv_icm42370_conf *conf)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	/* set PWR_MGMT0 register (accel sensor mode, temp enabled) */
> +	val =3D INV_ICM42370_PWR_MGMT0(conf->mode);
> +	ret =3D regmap_write(data->map, INV_ICM42370_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	msleep(200);
> +	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
> +	val =3D INV_ICM42370_ACCEL_CONFIG0_FS(conf->fs) |
> +	      INV_ICM42370_ACCEL_CONFIG0_ODR(conf->odr);
> +	ret =3D regmap_write(data->map, INV_ICM42370_REG_ACCEL_CONFIG0, val);
> +	if (ret)
> +		return ret;
> +
> +	msleep(200);
> +
> +	/* update internal conf */

Redundant comment.

> +	data->conf =3D *conf;
> +
> +	return 0;
> +}
> +
> +/**
> + * inv_icm42370_set_pwr_mgmt0() - set the PWR_MGMT0 register for sensor
> + *
> + * @dev_data: pointer to struct containing the sensor data
> + * @accel: enum of sensor power mode
> + * @sleep_ms: pointer to check how long the sensor is in sleep mode
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_set_pwr_mgmt0(struct inv_icm42370_data *dev_data,
> +				      enum inv_icm42370_sensor_mode accel,
> +				      unsigned int *sleep_ms)
> +{
> +	enum inv_icm42370_sensor_mode oldaccel =3D dev_data->conf.mode;
> +	unsigned int sleepval;
> +	unsigned int val;
> +	int ret;
> +
> +	/* if nothing changed, exit */
> +	if (accel =3D=3D oldaccel)
> +		return 0;
> +
> +	val =3D INV_ICM42370_PWR_MGMT0(accel);
> +	ret =3D regmap_write(dev_data->map, INV_ICM42370_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	dev_data->conf.mode =3D accel;
> +	dev_data->sensor_state->power_mode =3D accel;
> +
> +	/* compute required wait time for sensors to stabilize */
> +	sleepval =3D 0;
> +	/* accel startup time */
> +	if (accel !=3D oldaccel && oldaccel =3D=3D INV_ICM42370_SENSOR_MODE_OFF=
) {
> +		/* block any register write for at least 200 =B5s */
> +		usleep_range(200, 300);

Use fsleep() here as well.

> +		if (sleepval < INV_ICM42370_ACCEL_STARTUP_TIME_MS)
> +			sleepval =3D INV_ICM42370_ACCEL_STARTUP_TIME_MS;
> +	}
> +
> +	/* deferred sleep value if sleep pointer is provided or direct sleep */
> +	if (sleep_ms)
> +		*sleep_ms =3D sleepval;
> +	else if (sleepval)
> +		msleep(sleepval);
> +
> +	return 0;
> +}
> +
> +static void inv_icm42370_disable_pm(void *_data)
> +{
> +	struct device *dev =3D _data;
> +
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +}
> +
> +/**
> + * inv_icm42370_set_accel_conf() - set configuration data for accelerome=
ter
> + *
> + * @dev_data: pointer to struct containing the sensor data
> + * @conf: pointer to configuration data
> + * @sleep_ms: pointer to check how long the sensor is in sleep mode
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +int inv_icm42370_set_accel_conf(struct inv_icm42370_data *dev_data,
> +				struct inv_icm42370_conf *conf,
> +				unsigned int *sleep_ms)
> +{
> +	struct inv_icm42370_conf *oldconf =3D &dev_data->conf;
> +	unsigned int val;
> +	int ret;
> +
> +	/* sanitize missing values with current values */
> +	if (conf->mode < 0)
> +		conf->mode =3D oldconf->mode;
> +	if (conf->fs < 0)
> +		conf->fs =3D oldconf->fs;
> +	if (conf->odr < 0)
> +		conf->odr =3D oldconf->odr;
> +	if (conf->filter < 0)
> +		conf->filter =3D oldconf->filter;
> +
> +	/* force power mode against ODR when sensor is on */
> +	switch (conf->mode) {
> +	case INV_ICM42370_SENSOR_MODE_LOW_POWER:
> +	case INV_ICM42370_SENSOR_MODE_LOW_NOISE:
> +		if (conf->odr <=3D INV_ICM42370_ODR_800HZ_LN) {
> +			conf->mode =3D INV_ICM42370_SENSOR_MODE_LOW_NOISE;
> +			conf->filter =3D
> +				INV_ICM42370_UI_FILT_BW_LP_FILTER_BYPASSED;
> +		} else if (conf->odr =3D=3D INV_ICM42370_ODR_400HZ) {
> +			if (conf->filter =3D=3D INV_ICM42370_FILTER_AVG_16X ||
> +			    conf->filter =3D=3D INV_ICM42370_FILTER_AVG_32X ||
> +			    conf->filter =3D=3D INV_ICM42370_FILTER_AVG_64X) {
> +				conf->mode =3D INV_ICM42370_SENSOR_MODE_LOW_NOISE;
> +			} else {
> +				conf->mode =3D INV_ICM42370_SENSOR_MODE_LOW_POWER;
> +			}
> +		} else if (conf->odr =3D=3D INV_ICM42370_ODR_200HZ &&
> +			   conf->filter =3D=3D INV_ICM42370_FILTER_AVG_64X) {
> +			conf->mode =3D INV_ICM42370_SENSOR_MODE_LOW_NOISE;
> +			conf->filter =3D
> +				INV_ICM42370_UI_FILT_BW_LP_FILTER_BYPASSED;
> +		} else if (conf->odr >=3D INV_ICM42370_ODR_6_25HZ_LP) {
> +			conf->mode =3D INV_ICM42370_SENSOR_MODE_LOW_POWER;
> +			conf->filter =3D INV_ICM42370_FILTER_AVG_16X;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
> +	if (conf->fs !=3D oldconf->fs || conf->odr !=3D oldconf->odr) {
> +		val =3D INV_ICM42370_ACCEL_CONFIG0_FS(conf->fs) |
> +		      INV_ICM42370_ACCEL_CONFIG0_ODR(conf->odr);
> +		ret =3D regmap_write(dev_data->map,
> +				   INV_ICM42370_REG_ACCEL_CONFIG0, val);
> +		if (ret)
> +			return ret;

Maybe a personal opinion as well, but readability is an issue sometimes.
Adding blank lines to separate blocks of code is fine! (like here for
example)

> +		oldconf->fs =3D conf->fs;
> +		oldconf->odr =3D conf->odr;
> +	}
> +
> +	/* set PWR_MGMT0 register (accel sensor mode) */
> +	return inv_icm42370_set_pwr_mgmt0(dev_data, dev_data->conf.mode,
> +					  sleep_ms);
> +}
> +
> +/**
> + * inv_icm42370_setup() - check and setup chip
> + *
> + * @data: pointer to struct containing the sensor data
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +static int inv_icm42370_setup(struct inv_icm42370_data *data,
> +			      inv_icm42370_bus_setup bus_setup)
> +{
> +	const struct device *dev =3D regmap_get_device(data->map);
> +	unsigned int whoami;
> +	int ret;
> +
> +	/* check chip self-identification value */
> +	ret =3D regmap_read(data->map, INV_ICM42370_REG_WHO_AM_I, &whoami);
> +	if (ret)
> +		return ret;
> +
> +	if (whoami !=3D INV_ICM42370_WHOAMI_VALUE) {
> +		dev_err(dev, "Wrong WHO_AM_I: %d (want 0x%02X)\n",
> +				     whoami, INV_ICM42370_WHOAMI_VALUE);
> +		return -ENODEV;
> +	}
> +
> +	data->name =3D "inv_icm42370";
> +
> +	/* set chip bus configuration */
> +	ret =3D bus_setup(data);
> +	if (ret)
> +		return ret;
> +
> +	/* sensor data in big-endian (default) */
> +	ret =3D regmap_set_bits(data->map, INV_ICM42370_REG_INTF_CONFIG0,
> +			      INV_ICM42370_INTF_CONFIG0_SENSOR_DATA_ENDIAN);
> +	if (ret)
> +		return ret;
> +
> +	return inv_icm42370_set_conf(data, &inv_icm42370_default_conf);
> +}
> +
> +static irqreturn_t inv_icm42370_irq_timestamp(int irq, void *_data)
> +{
> +	struct inv_icm42370_data *dev_data =3D _data;
> +
> +	dev_data->timestamp =3D iio_get_time_ns(dev_data->indio_accel);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t inv_icm42370_irq_handler(int irq, void *_data)
> +{
> +	struct inv_icm42370_data *dev_data =3D _data;
> +	unsigned int status;
> +	int ret;
> +
> +	mutex_lock(&dev_data->lock);

Use guard(mutex) from cleanup.h, it eliminates the need to use gotos and
labels for cleaning up functions (a lot of examples in IIO for this).

> +
> +	ret =3D regmap_read(dev_data->map, INV_ICM42370_REG_INT_STATUS, &status=
);
> +	if (ret)
> +		goto out_unlock;
> +
> +out_unlock:
> +	mutex_unlock(&dev_data->lock);
> +	return IRQ_HANDLED;

Not sure, but is it okay to always return IRQ_HANDLED, even on regmap failu=
re?

> +}
> +
> +/**
> + * inv_icm42370_irq_init() - initialize int pin and interrupt handler
> + * @data:		driver internal state
> + * @irq:	irq number
> + * @irq_type:	irq trigger type
> + * @open_drain:	true if irq is open drain, false for push-pull
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +static int inv_icm42370_irq_init(struct inv_icm42370_data *data, int irq,
> +				 int irq_type, bool open_drain)
> +{
> +	struct device *dev =3D regmap_get_device(data->map);
> +	u8 val;
> +	int ret;
> +
> +	/* configure INT1 interrupt: default is active low on edge */
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_RISING:
> +	case IRQF_TRIGGER_HIGH:
> +		val =3D INV_ICM42370_INT_CONFIG_INT1_ACTIVE_HIGH;
> +		break;
> +	default:
> +		val =3D INV_ICM42370_INT_CONFIG_INT1_ACTIVE_LOW;
> +		break;
> +	}
> +
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_LOW:
> +	case IRQF_TRIGGER_HIGH:
> +		val |=3D INV_ICM42370_INT_CONFIG_INT1_LATCHED;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!open_drain)
> +		val |=3D INV_ICM42370_INT_CONFIG_INT1_PUSH_PULL;
> +
> +	ret =3D regmap_write(data->map, INV_ICM42370_REG_INT_CONFIG, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Deassert async reset for proper INT pin operation (cf datasheet) */
> +	ret =3D inv_icm42370_mreg_read(data->map, INV_ICM42370_MREG1,
> +				     INV_ICM42370_REG_INT_CONFIG1, &val);
> +	if (ret)
> +		return ret;

Blank line.

> +	val &=3D ~INV_ICM42370_INT_CONFIG1_ASYNC_RESET;
> +
> +	ret =3D inv_icm42370_mreg_write(data->map, INV_ICM42370_MREG1,
> +				      INV_ICM42370_REG_INT_CONFIG1, val);
> +	if (ret)
> +		return ret;
> +
> +	irq_type |=3D IRQF_ONESHOT;
> +	return devm_request_threaded_irq(dev, irq, inv_icm42370_irq_timestamp,
> +					 inv_icm42370_irq_handler, irq_type,
> +					 "inv_icm42370", data);
> +}
> +
> +/*
> + * Calibration bias values, IIO range format int + micro.
> + * Value is limited to +/-1g coded on 12 bits signed. Step is 0.5mg.
> + */
> +static int inv_icm42370_accel_calibbias[] =3D {
> +	-10, 42010, /* min: -2^12 * 0.0005 * 9.80665 =3D -10.042010 m/s=B2 */
> +	0,   4903, /* step: 0.5 * 0.00980655 =3D 0.004903 m/s=B2 */
> +	10,  37106, /* max: (2^12 - 1) * 0.0005 * 9.80665 =3D 10.037106 m/s=B2 =
*/
> +};
> +
> +/**
> + * inv_icm42370_temp_read() - internal function to access temperature se=
nsor registers
> + *
> + * @dev_data: pointer to struct containing the sensor data
> + * @temp: pointer containing the temperature data in s16 format
> + *
> + * Return 0 on success, negative errno on error
> + */
> +static int inv_icm42370_temp_read(struct inv_icm42370_data *dev_data, s1=
6 *temp)
> +{
> +	struct device *dev =3D regmap_get_device(dev_data->map);
> +	__be16 *raw;
> +	int ret;
> +
> +	pm_runtime_get_sync(dev);

Please check out PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND, it utilizes the=
 cleanup.h
magic as guard(mutex).

> +	mutex_lock(&dev_data->lock);

guard(mutex) combined with the macro above removes the need for gotos and t=
he exit
label.

> +
> +	raw =3D (__be16 *)&dev_data->buffer[0];
> +	ret =3D regmap_bulk_read(dev_data->map, INV_ICM42370_REG_TEMP_DATA1, ra=
w,
> +			       sizeof(*raw));
> +	if (ret)
> +		goto exit;
> +
> +	*temp =3D (s16)be16_to_cpup(raw);
> +
> +	/*
> +	 * Temperature data is invalid if both accel and gyro are off.
> +	 * Return -EBUSY in this case.
> +	 */
> +	if (*temp =3D=3D INV_ICM42370_DATA_INVALID)
> +		ret =3D -EBUSY;
> +
> +exit:
> +	mutex_unlock(&dev_data->lock);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +/**
> + * inv_icm42370_temp_read_raw() - read data from the temperature sensor
> + *
> + * @indio_dev: pointer to the industrial io struct
> + * @chan: pointer to the iio channel specification
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + * @mask: mask to differentiate between channel info
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_temp_read_raw(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan,
> +				      int *val, int *val2, long mask)
> +{
> +	struct inv_icm42370_data *dev_data =3D iio_priv(indio_dev);
> +	s16 temp;
> +	int ret;
> +
> +	if (chan->type !=3D IIO_TEMP)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D inv_icm42370_temp_read(dev_data, &temp);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +		*val =3D temp;
> +		return IIO_VAL_INT;
> +	/*
> +	 * T=B0C =3D (temp / 128) + 25
> +	 * Tm=B0C =3D 1000 * ((temp / 128) + 25)
> +	 * Tm=B0C =3D 7.8125 * temp + 25000
> +	 * Tm=B0C =3D (temp + 3200) * 7.8125
> +	 * scale: 1000 / 128 ~=3D 7.8125
> +	 * offset: 3200
> +	 */
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 7;
> +		*val2 =3D 812500;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D 3200;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * inv_icm42370_accel_read_offset() - read offset values from the accele=
rometer
> + *
> + * @dev_data: pointer to struct containing the sensor data
> + * @chan: pointer to iio channel specification
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_read_offset(struct inv_icm42370_data *dev_=
data,
> +					  struct iio_chan_spec const *chan,
> +					  int *val, int *val2)
> +{
> +	struct device *dev =3D regmap_get_device(dev_data->map);
> +	s64 val64;
> +	s32 bias;
> +	unsigned int reg;
> +	s16 offset;
> +	u8 data[2];
> +	int ret;
> +
> +	if (chan->type !=3D IIO_ACCEL)
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg =3D INV_ICM42370_REG_OFFSET_USER4;
> +		break;
> +	case IIO_MOD_Y:
> +		reg =3D INV_ICM42370_REG_OFFSET_USER6;
> +		break;
> +	case IIO_MOD_Z:
> +		reg =3D INV_ICM42370_REG_OFFSET_USER7;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	pm_runtime_get_sync(dev);
> +	mutex_lock(&dev_data->lock);
> +
> +	ret =3D inv_icm42370_mreg_read(dev_data->map, INV_ICM42370_MREG1, reg,
> +				     dev_data->buffer);
> +	memcpy(data, dev_data->buffer, sizeof(data));
> +
> +	mutex_unlock(&dev_data->lock);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* 12 bits signed value */
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		offset =3D sign_extend32(((data[0] & 0xF0) << 4) | data[1], 11);
> +		break;
> +	case IIO_MOD_Y:
> +		offset =3D sign_extend32(((data[1] & 0x0F) << 8) | data[0], 11);
> +		break;
> +	case IIO_MOD_Z:
> +		offset =3D sign_extend32(((data[0] & 0xF0) << 4) | data[1], 11);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * convert raw offset to g then to m/s=B2
> +	 * 12 bits signed raw step 0.5mg to g: 5 / 10000
> +	 * g to m/s=B2: 9.806650
> +	 * result in micro (1000000)
> +	 * (offset * 5 * 9.806650 * 1000000) / 10000
> +	 */
> +	val64 =3D (s64)offset * 5LL * 9806650LL;
> +	/* for rounding, add + or - divisor (10000) divided by 2 */
> +	if (val64 >=3D 0)
> +		val64 +=3D 10000LL / 2LL;
> +	else
> +		val64 -=3D 10000LL / 2LL;
> +	bias =3D div_s64(val64, 10000L);

This is probably the last time I'll mention a blank line in this review, but
there are more places in this patch where they should be added.

> +	*val =3D bias / 1000000L;
> +	*val2 =3D bias % 1000000L;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +/**
> + * inv_icm42370_accel_write_offset() - write offset values to the accele=
rometer
> + *
> + * @dev_data: pointer to struct containing the sensor data
> + * @chan: pointer to iio channel specification
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_write_offset(struct inv_icm42370_data *dev=
_data,
> +					   struct iio_chan_spec const *chan,
> +					   int val, int val2)
> +{
> +	struct device *dev =3D regmap_get_device(dev_data->map);
> +	s64 val64;
> +	s32 min, max;
> +	unsigned int regval;
> +	s16 offset;
> +	int ret;
> +
> +	if (chan->type !=3D IIO_ACCEL)
> +		return -EINVAL;
> +
> +	/* inv_icm42370_accel_calibbias: min - step - max in micro */
> +	min =3D inv_icm42370_accel_calibbias[0] * 1000000L +

This would benefit from using the macros from units.h.

> +	      inv_icm42370_accel_calibbias[1];
> +	max =3D inv_icm42370_accel_calibbias[4] * 1000000L +
> +	      inv_icm42370_accel_calibbias[5];
> +	val64 =3D (s64)val * 1000000LL + (s64)val2;
> +	if (val64 < min || val64 > max)
> +		return -EINVAL;
> +
> +	/*
> +	 * convert m/s=B2 to g then to raw value
> +	 * m/s=B2 to g: 1 / 9.806650
> +	 * g to raw 12 bits signed, step 0.5mg: 10000 / 5
> +	 * val in micro (1000000)
> +	 * val * 10000 / (9.806650 * 1000000 * 5)
> +	 */
> +	val64 =3D val64 * 10000LL;
> +	/* for rounding, add + or - divisor (9806650 * 5) divided by 2 */
> +	if (val64 >=3D 0)
> +		val64 +=3D 9806650 * 5 / 2;
> +	else
> +		val64 -=3D 9806650 * 5 / 2;
> +	offset =3D div_s64(val64, 9806650 * 5);
> +
> +	/* clamp value limited to 12 bits signed */
> +	if (offset < -2048)
> +		offset =3D -2048;
> +	else if (offset > 2047)
> +		offset =3D 2047;
> +
> +	pm_runtime_get_sync(dev);
> +	mutex_lock(&dev_data->lock);

The pm_runtime and guard_macros would clean this up nicely.

> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		/* OFFSET_USER4 register is shared */
> +		ret =3D inv_icm42370_mreg_read(dev_data->map, INV_ICM42370_MREG1,
> +					     INV_ICM42370_REG_OFFSET_USER4,
> +					     (u8 *)&regval);
> +		if (ret)
> +			goto out_unlock;
> +		dev_data->buffer[0] =3D ((offset & 0xF00) >> 4) | (regval & 0x0F);
> +		dev_data->buffer[1] =3D offset & 0xFF;
> +
> +		ret =3D inv_icm42370_mreg_write(dev_data->map, INV_ICM42370_MREG1,
> +					      INV_ICM42370_REG_OFFSET_USER4,
> +					      dev_data->buffer[0]);
> +		if (ret)
> +			goto out_unlock;
> +
> +		ret =3D inv_icm42370_mreg_write(dev_data->map, INV_ICM42370_MREG1,
> +					      INV_ICM42370_REG_OFFSET_USER5,
> +					      dev_data->buffer[1]);
> +		if (ret)
> +			goto out_unlock;
> +		break;
> +	case IIO_MOD_Y:
> +		/* OFFSET_USER7 register is shared */
> +		ret =3D inv_icm42370_mreg_read(dev_data->map, INV_ICM42370_MREG1,
> +					     INV_ICM42370_REG_OFFSET_USER7,
> +					     (u8 *)&regval);
> +		if (ret)
> +			goto out_unlock;
> +		dev_data->buffer[0] =3D offset & 0xFF;
> +		dev_data->buffer[1] =3D ((offset & 0xF00) >> 8) | (regval & 0xF0);
> +
> +		ret =3D inv_icm42370_mreg_write(dev_data->map, INV_ICM42370_MREG1,
> +					      INV_ICM42370_REG_OFFSET_USER7,
> +					      dev_data->buffer[0]);
> +		if (ret)
> +			goto out_unlock;
> +
> +		ret =3D inv_icm42370_mreg_write(dev_data->map, INV_ICM42370_MREG1,
> +					      INV_ICM42370_REG_OFFSET_USER6,
> +					      dev_data->buffer[1]);
> +		if (ret)
> +			goto out_unlock;
> +
> +		break;
> +	case IIO_MOD_Z:
> +		/* OFFSET_USER7 register is shared */
> +		inv_icm42370_mreg_read(dev_data->map, INV_ICM42370_MREG1,
> +				       INV_ICM42370_REG_OFFSET_USER7,
> +				       (u8 *)&regval);
> +
> +		dev_data->buffer[0] =3D ((offset & 0xF00) >> 4) | (regval & 0x0F);
> +		dev_data->buffer[1] =3D offset & 0xFF;
> +
> +		ret =3D inv_icm42370_mreg_write(dev_data->map, INV_ICM42370_MREG1,
> +					      INV_ICM42370_REG_OFFSET_USER7,
> +					      dev_data->buffer[0]);
> +		if (ret)
> +			goto out_unlock;
> +
> +		ret =3D inv_icm42370_mreg_write(dev_data->map, INV_ICM42370_MREG1,
> +					      INV_ICM42370_REG_OFFSET_USER8,
> +					      dev_data->buffer[1]);
> +		if (ret)
> +			goto out_unlock;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&dev_data->lock);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +	return ret;
> +}
> +
> +/**
> + * inv_icm42370_accel_read_scale() - read scaling data from the accelero=
meter
> + *
> + * @indio_dev: pointer to the industrial io struct
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_read_scale(struct iio_dev *indio_dev, int =
*val,
> +					 int *val2)
> +{
> +	struct inv_icm42370_data *dev_data =3D iio_priv(indio_dev);
> +	unsigned int idx;
> +
> +	idx =3D dev_data->conf.fs;
> +
> +	*val =3D dev_data->sensor_state->scales[2 * idx];
> +	*val2 =3D dev_data->sensor_state->scales[2 * idx + 1];
> +	return IIO_VAL_INT_PLUS_NANO;
> +}
> +
> +/**
> + * inv_icm42370_accel_write_scale() - write scaling data to the accelero=
meter
> + *
> + * @indio_dev: pointer to the industrial io struct
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_write_scale(struct iio_dev *indio_dev, int=
 val,
> +					  int val2)
> +{
> +	struct inv_icm42370_data *dev_data =3D iio_priv(indio_dev);
> +	struct device *dev =3D regmap_get_device(dev_data->map);
> +	unsigned int idx;
> +	struct inv_icm42370_conf conf =3D INV_ICM42370_SENSOR_CONF_INIT;
> +	int ret;
> +
> +	for (idx =3D 0; idx < dev_data->sensor_state->scales_len; idx +=3D 2) {
> +		if (val =3D=3D dev_data->sensor_state->scales[idx] &&
> +		    val2 =3D=3D dev_data->sensor_state->scales[idx + 1])
> +			break;
> +	}
> +
> +	if (idx >=3D dev_data->sensor_state->scales_len)
> +		return -EINVAL;
> +
> +	conf.fs =3D idx / 2;
> +
> +	pm_runtime_get_sync(dev);
> +	mutex_lock(&dev_data->lock);
> +
> +	ret =3D inv_icm42370_set_accel_conf(dev_data, &conf, NULL);
> +
> +	mutex_unlock(&dev_data->lock);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +/**
> + * inv_icm42370_accel_read_odr() - read ODR data from the accelerometer
> + *
> + * @dev_data: pointer to struct containing the sensor data
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_read_odr(struct inv_icm42370_data *dev_dat=
a,
> +				       int *val, int *val2)
> +{
> +	unsigned int odr;
> +	unsigned int i;
> +
> +	odr =3D dev_data->conf.odr;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(inv_icm42370_accel_odr_conv); ++i) {
> +		if (inv_icm42370_accel_odr_conv[i] =3D=3D odr)
> +			break;
> +	}
> +	if (i >=3D ARRAY_SIZE(inv_icm42370_accel_odr_conv))
> +		return -EINVAL;
> +
> +	*val =3D inv_icm42370_accel_odr[2 * i];
> +	*val2 =3D inv_icm42370_accel_odr[2 * i + 1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +/**
> + * inv_icm42370_accel_write_odr() - write ODR data to the accelerometer
> + *
> + * @indio_dev: pointer to struct containing the sensor data
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_write_odr(struct iio_dev *indio_dev, int v=
al,
> +					int val2)
> +{
> +	struct inv_icm42370_data *dev_data =3D iio_priv(indio_dev);
> +	struct inv_sensors_timestamp *ts =3D &dev_data->sensor_state->ts;
> +	struct device *dev =3D regmap_get_device(dev_data->map);
> +	unsigned int idx;
> +	struct inv_icm42370_conf conf =3D INV_ICM42370_SENSOR_CONF_INIT;
> +	int ret;
> +
> +	for (idx =3D 0; idx < ARRAY_SIZE(inv_icm42370_accel_odr); idx +=3D 2) {
> +		if (val =3D=3D inv_icm42370_accel_odr[idx] &&
> +		    val2 =3D=3D inv_icm42370_accel_odr[idx + 1])
> +			break;
> +	}
> +	if (idx >=3D ARRAY_SIZE(inv_icm42370_accel_odr))
> +		return -EINVAL;
> +
> +	conf.odr =3D inv_icm42370_accel_odr_conv[idx / 2];
> +
> +	pm_runtime_get_sync(dev);
> +	mutex_lock(&dev_data->lock);
> +
> +	ret =3D inv_sensors_timestamp_update_odr(
> +		ts, inv_icm42370_odr_to_period(conf.odr),
> +		iio_buffer_enabled(indio_dev));
> +	if (ret)
> +		goto out_unlock;
> +
> +	ret =3D inv_icm42370_set_accel_conf(dev_data, &conf, NULL);
> +	if (ret)
> +		goto out_unlock;
> +
> +out_unlock:
> +	mutex_unlock(&dev_data->lock);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +/**
> + * inv_icm42370_accel_write_raw() - write raw attribute values to the ac=
celerometer
> + * @indio_dev:	pointer to the IIO device structure.
> + * @chan:	pointer to the IIO channel specification.
> + * @val:	integer part of the value to write.
> + * @val2:	fractional part of the value to write.
> + * @mask:	bitmask specifying which attribute to write.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int inv_icm42370_accel_write_raw(struct iio_dev *indio_dev,
> +					struct iio_chan_spec const *chan,
> +					int val, int val2, long mask)
> +{
> +	struct inv_icm42370_data *dev_data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type !=3D IIO_ACCEL)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D inv_icm42370_accel_write_scale(indio_dev, val, val2);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return inv_icm42370_accel_write_odr(indio_dev, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D inv_icm42370_accel_write_offset(dev_data, chan, val,
> +						      val2);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * inv_icm42370_accel_read_sensor() - internal function to read accelero=
meter sensor registers
> + *
> + * @indio_dev: pointer to the industrial io struct

I/O.

> + * @chan: pointer to iio channel specification
> + * @val: pointer containing accelerometer data in s16 format
> + *
> + * Return 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_read_sensor(struct iio_dev *indio_dev,
> +					  struct iio_chan_spec const *chan,
> +					  s16 *val)
> +{
> +	struct inv_icm42370_data *data =3D iio_priv(indio_dev);
> +	struct device *dev =3D regmap_get_device(data->map);
> +	unsigned int reg;
> +	__be16 *value;
> +	int ret;
> +
> +	if (chan->type !=3D IIO_ACCEL)
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		reg =3D INV_ICM42370_REG_ACCEL_DATA_X1;
> +		break;
> +	case IIO_MOD_Y:
> +		reg =3D INV_ICM42370_REG_ACCEL_DATA_Y1;
> +		break;
> +	case IIO_MOD_Z:
> +		reg =3D INV_ICM42370_REG_ACCEL_DATA_Z1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	pm_runtime_get_sync(dev);
> +	mutex_lock(&data->lock);
> +
> +	/* read accel register data */
> +	value =3D (__be16 *)&data->buffer[0];
> +	ret =3D regmap_bulk_read(data->map, reg, value, sizeof(*value));
> +	if (ret)
> +		goto exit;
> +
> +	*val =3D (s16)be16_to_cpup(value);
> +
> +	if (*val =3D=3D INV_ICM42370_DATA_INVALID)
> +		ret =3D -EINVAL;
> +
> +exit:
> +	mutex_unlock(&data->lock);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +	return ret;
> +}
> +
> +/**
> + * inv_icm42370_accel_read_raw() - read data from the accelerometer sens=
or
> + *
> + * @indio_dev: pointer to the industrial io struct
> + * @chan: pointer to the iio channel specification
> + * @val: integer part of the value
> + * @val2: decimal part of the value
> + * @mask: mask to differentiate between channel info
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_accel_read_raw(struct iio_dev *indio_dev,
> +				       struct iio_chan_spec const *chan,
> +				       int *val, int *val2, long mask)
> +{
> +	struct inv_icm42370_data *dev_data =3D iio_priv(indio_dev);
> +	s16 value;
> +	int ret;
> +
> +	switch (chan->type) {
> +	case IIO_ACCEL:
> +		break;
> +	case IIO_TEMP:
> +		return inv_icm42370_temp_read_raw(indio_dev, chan, val, val2,
> +						  mask);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D inv_icm42370_accel_read_sensor(indio_dev, chan, &value);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +		*val =3D value;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		return inv_icm42370_accel_read_scale(indio_dev, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return inv_icm42370_accel_read_odr(dev_data, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return inv_icm42370_accel_read_offset(dev_data, chan, val,
> +						      val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info inv_icm42370_info =3D {
> +	.read_raw =3D inv_icm42370_accel_read_raw,
> +	.write_raw =3D inv_icm42370_accel_write_raw,
> +};
> +
> +struct iio_dev *inv_icm42370_accel_init(struct iio_dev *indio_dev,
> +					struct inv_icm42370_data *data)
> +{
> +	struct device *dev =3D regmap_get_device(data->map);
> +	struct inv_sensors_timestamp_chip ts_chip;
> +	int ret;
> +
> +	data->sensor_state->scales =3D inv_icm42370_accel_scale;
> +	data->sensor_state->scales_len =3D ARRAY_SIZE(inv_icm42370_accel_scale);
> +
> +	/*
> +	 * clock period is 32kHz (31250ns)
> +	 * jitter is +/- 2% (20 per mille)
> +	 */
> +	ts_chip.clock_period =3D 31250;
> +	ts_chip.jitter =3D 20;
> +	ts_chip.init_period =3D inv_icm42370_odr_to_period(data->conf.odr);
> +	inv_sensors_timestamp_init(&data->sensor_state->ts, &ts_chip);
> +
> +	indio_dev->name =3D "inv_icm42370";
> +	indio_dev->info =3D &inv_icm42370_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D inv_icm42370_accel_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(inv_icm42370_accel_channels);
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);

You register the device before initializing IRQs and PM runtime, causing po=
tential
race conditions as userspace could already interact with the device before =
probe()
has finished.

> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return indio_dev;
> +}
> +
> +/**
> + * inv_icm42370_core_probe() - initialize and register the ICM-42370 dev=
ice
> + * @regmap:	register map for accessing the device's registers.
> + * @chip:	chip identifier, must be %INV_CHIP_ICM42370.
> + * @irq:	interrupt number for the device's data-ready signal.
> + * @bus_setup:	callback to configure bus-specific settings (e.g. I2C).
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +int inv_icm42370_core_probe(struct regmap *regmap, int chip, int irq,
> +			    inv_icm42370_bus_setup bus_setup)
> +{
> +	struct device *dev =3D regmap_get_device(regmap);
> +	struct inv_icm42370_data *data;
> +	struct iio_dev *indio_dev;
> +	struct irq_data *irq_desc;
> +	int irq_type;
> +	bool open_drain;
> +	int ret;
> +
> +	if (chip !=3D INV_CHIP_ICM42370) {
> +		dev_err(dev, "invalid chip =3D %d\n", chip);
> +		return -ENODEV;
> +	}
> +
> +	/* get irq properties, set trigger falling by default */
> +	irq_desc =3D irq_get_irq_data(irq);
> +	if (!irq_desc) {
> +		dev_err(dev, "could not find IRQ %d\n", irq);

dev_err_probe() would be better.

> +		return -EINVAL;
> +	}
> +
> +	irq_type =3D irqd_get_trigger_type(irq_desc);
> +	if (!irq_type)
> +		irq_type =3D IRQF_TRIGGER_FALLING;
> +
> +	open_drain =3D device_property_read_bool(dev, "drive-open-drain");
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	data->sensor_state =3D
> +		devm_kzalloc(dev, sizeof(*data->sensor_state), GFP_KERNEL);
> +	if (!data->sensor_state)
> +		return -ENOMEM;
> +
> +	mutex_init(&data->lock);

devm_mutex_init() and check the return value.

> +	data->chip =3D chip;
> +	data->map =3D regmap;
> +
> +	data->vdd_supply =3D devm_regulator_get(dev, "vdd");

devm_regulator_get_enable will also handle the disabling on unbind. Same
for data->vddio.

> +	if (IS_ERR(data->vdd_supply))
> +		return PTR_ERR(data->vdd_supply);

dev_error_probe() here and below as well (if you want to print an error mes=
sage)

> +
> +	data->vddio_supply =3D devm_regulator_get(dev, "vddio");
> +	if (IS_ERR(data->vddio_supply))
> +		return PTR_ERR(data->vddio_supply);
> +
> +	ret =3D regulator_enable(data->vdd_supply);

Use devm_regulator_get_enable() as mentioned above, you wouldn't need this =
then.
> +	if (ret)
> +		return ret;
> +
> +	ret =3D inv_icm42370_setup(data, bus_setup);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Setup failed\n");
> +
> +	data->indio_accel =3D inv_icm42370_accel_init(indio_dev, data);
> +	if (IS_ERR(data->indio_accel))
> +		return PTR_ERR(data->indio_accel);
> +
> +	ret =3D inv_icm42370_irq_init(data, irq, irq_type, open_drain);
> +	if (ret)
> +		return ret;
> +
> +	/* setup runtime power management */
> +	ret =3D pm_runtime_set_active(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_put(dev);
> +
> +	return devm_add_action_or_reset(dev, inv_icm42370_disable_pm, dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(inv_icm42370_core_probe, "IIO_ICM42370");
> +
> +MODULE_AUTHOR("Kanak Shilledar <kanak.shilledar@axis.com>");
> +MODULE_AUTHOR("Henrik Grimler <henrik.grimler@axis.com>");
> +MODULE_DESCRIPTION("Invensense device ICM42370 driver");

No point in having the word "device" in the description.

> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_INV_SENSORS_TIMESTAMP");
> diff --git a/drivers/iio/accel/inv_icm42370_i2c.c b/drivers/iio/accel/inv=
_icm42370_i2c.c
> new file mode 100644
> index 0000000000000..57e97d66329a1
> --- /dev/null
> +++ b/drivers/iio/accel/inv_icm42370_i2c.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 InvenSense, Inc.
> + * Copyright (C) 2026 Axis Communications AB
> + */
> +
> +#include <linux/kernel.h>

Don't include this in new drivers.

> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>

Remove this.

> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/property.h>
> +
> +#include "inv_icm42370.h"
> +
> +/**
> + * inv_icm42370_i2c_bus_setup() - I2C bus setup for icm42370
> + *
> + * @data: pointer to struct containing the sensor data
> + *
> + * Returns 0 on success, negative errno on error
> + */
> +static int inv_icm42370_i2c_bus_setup(struct inv_icm42370_data *data)
> +{
> +	unsigned int mask, val;
> +	int ret;
> +
> +	/* set slew rates for I2C */
> +	mask =3D INV_ICM42370_DRIVE_CONFIG2_I2C_MASK;
> +	val =3D INV_ICM42370_DRIVE_CONFIG2_I2C(INV_ICM42370_SLEW_RATE_12_36NS);
> +	ret =3D regmap_update_bits(data->map, INV_ICM42370_REG_DRIVE_CONFIG2,
> +				 mask, val);
> +	if (ret)
> +		return ret;
> +
> +	/* set slew rates for SPI */
> +	mask =3D INV_ICM42370_DRIVE_CONFIG3_SPI_MASK;
> +	val =3D INV_ICM42370_DRIVE_CONFIG3_SPI(INV_ICM42370_SLEW_RATE_12_36NS);
> +	ret =3D regmap_update_bits(data->map, INV_ICM42370_REG_DRIVE_CONFIG3,
> +				 mask, val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +static int inv_icm42370_probe(struct i2c_client *client)
> +{
> +	const void *match;
> +	enum inv_icm42370_chip chip;
> +	struct regmap *regmap;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return -EOPNOTSUPP;
> +
> +	match =3D device_get_match_data(&client->dev);
> +	if (!match)
> +		return -EINVAL;
> +	chip =3D (uintptr_t)match;
> +
> +	regmap =3D devm_regmap_init_i2c(client, &inv_icm42370_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return inv_icm42370_core_probe(regmap, chip, client->irq,
> +				       inv_icm42370_i2c_bus_setup);
> +}
> +
> +/**
> + * device id table is used to identify what device can be supported by t=
his driver
> + */
> +static const struct i2c_device_id inv_icm42370_id[] =3D { { "icm42370",
> +							  INV_CHIP_ICM42370 },
> +							{} };

The formatting is awful, fix it to something like:
static const struct i2c_device_id inv_icm42370_id[] =3D {
	{ .compatible =3D "icm42370", .data =3D INV_CHIP_ICM42370 },
	{ }
};

Also the use of named initializers is preferred.

> +MODULE_DEVICE_TABLE(i2c, inv_icm42370_id);
> +
> +/**
> + * inv_icm42370_of_matches - struct for all the compatibe strings
> + *
> + */
> +static const struct of_device_id inv_icm42370_of_matches[] =3D {
> +	{
> +		.compatible =3D "invensense,icm42370",
> +		.data =3D (void *)INV_CHIP_ICM42370,
> +	},

You can put the two on one line.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, inv_icm42370_of_matches);
> +
> +static struct i2c_driver inv_icm42370_driver =3D {
> +	.driver =3D {
> +		.name =3D "inv-icm42370-i2c",
> +		.of_match_table =3D inv_icm42370_of_matches,
> +	},
> +	.probe =3D inv_icm42370_probe,
> +};
> +module_i2c_driver(inv_icm42370_driver);
> +
> +MODULE_AUTHOR("Kanak Shilledar <kanak.shilledar@axis.com>");
> +MODULE_AUTHOR("Henrik Grimler <henrik.grimler@axis.com>");
> +MODULE_DESCRIPTION("InvenSense ICM-42370P I2C driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_ICM42370");
>=20



--=20
Kind regards,
Joshua Crofts
