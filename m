Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145153033C6;
	Sat, 25 Jul 2026 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784938809; cv=none; b=G9+pedVAGrmLVj+CT7+jwRtco7mLcEQHxEj5P361GhPJFKWUHmxsB6kqrk39ZfZ5ZifaS8bxPuR7JFvaTiuslAzm7+Dmga7gtrAOyKsW6w2BR71Ubs76JIphEXGawuuFDauWSb+8s/yZn9Dzgcc0nKt5xox5HG2ot4gZIhgsH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784938809; c=relaxed/simple;
	bh=u9+3PBD3XRPhBnXZDl34GZwnEUNA2cV+YZwTUrGIn/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPjO2tQqRA9KqeaxuaYGvznkXuBwcQH7TDrfrga7nvjNdk2VCzOkgOS7WMVQ8ej6+oAWzFFJCb/OfnB82j+Lqn0mZ1Q4JlKvjNABPYC+HkGmUYGlltQdnnJIO+qyQIZD3RVfBT+EgUb4PDwmzcR5SYdmvlVU6G9qXp+myQRFrPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyQYQy5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyQYQy5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAC11F000E9;
	Sat, 25 Jul 2026 00:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784938807;
	bh=RO6xBnz6ZwFqlMg/A1CVvYBTESYE+5ArNwAq89W+UTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hyQYQy5TW6FegYQYgex1fUojBuPMZwTvypACiukE7Krmceq0LaJD0WJelZmjzHEsP
	 ZyNTbgL/Kp+RGG5Pf/b6MkRB7j0NCCT7GAseOtsTjMOxdksVj+cc94IJrthl3o9BWK
	 kxxAkD7XLo/wnSI60C4QXcSR9JX0hPzffB1fH0jwE3zgmXcqMzR61hzW6JZekeAhp6
	 bKi8qqB//pAFPn9ABOMdUty77qtky4GA0D2QbGp0ArTlTeKCrpLoF2liOCpVYvfB6e
	 pqSsPZ1EiRkpB5K6D6ipI+N6yqNgxv05EZuOy/g1b2eaaaqTpFF/aoH24pzH0u58yJ
	 zX6Brz5w2OK/Q==
Date: Sat, 25 Jul 2026 01:20:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V19 8/9] iio: imu: inv_icm42607: Add Temp Support in
 icm42607
Message-ID: <20260725012002.664ae3a3@jic23-huawei>
In-Reply-To: <20260722153942.144387-9-macroalpha82@gmail.com>
References: <20260722153942.144387-1-macroalpha82@gmail.com>
	<20260722153942.144387-9-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jul 2026 10:39:39 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add functions for reading temperature sensor data.
>=20
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
I think this is now Chris beats sashiko. It is now confused
about the temperature channel handling but it looks fine to me.
It is complex, so fair enough you confused the poor thing ;)


Jonathan

> ---
>  drivers/iio/imu/inv_icm42607/Makefile         |  1 +
>  .../iio/imu/inv_icm42607/inv_icm42607_accel.c |  8 ++
>  .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  |  8 ++
>  .../iio/imu/inv_icm42607/inv_icm42607_temp.c  | 98 +++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_temp.h  | 38 +++++++
>  5 files changed, 153 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
>=20
> diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_=
icm42607/Makefile
> index 8e73385c8f4b..7b907e019601 100644
> --- a/drivers/iio/imu/inv_icm42607/Makefile
> +++ b/drivers/iio/imu/inv_icm42607/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_INV_ICM42607) +=3D inv-icm42607.o
>  inv-icm42607-y +=3D inv_icm42607_core.o
>  inv-icm42607-y +=3D inv_icm42607_gyro.o
>  inv-icm42607-y +=3D inv_icm42607_accel.o
> +inv-icm42607-y +=3D inv_icm42607_temp.o
> =20
>  obj-$(CONFIG_INV_ICM42607_I2C) +=3D inv-icm42607-i2c.o
>  inv-icm42607-i2c-y +=3D inv_icm42607_i2c.o
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/=
iio/imu/inv_icm42607/inv_icm42607_accel.c
> index f563c7708420..0b3f035c2da0 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> @@ -15,6 +15,7 @@
>  #include <linux/types.h>
> =20
>  #include "inv_icm42607.h"
> +#include "inv_icm42607_temp.h"
> =20
>  #define INV_ICM42607_ACCEL_CHAN(_modifier, _index, _ext_info)			\
>  {										\
> @@ -40,6 +41,7 @@ enum inv_icm42607_accel_scan {
>  	INV_ICM42607_ACCEL_SCAN_X,
>  	INV_ICM42607_ACCEL_SCAN_Y,
>  	INV_ICM42607_ACCEL_SCAN_Z,
> +	INV_ICM42607_ACCEL_SCAN_TEMP,
>  };
> =20
>  static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[=
] =3D {
> @@ -54,6 +56,7 @@ static const struct iio_chan_spec inv_icm42607_accel_ch=
annels[] =3D {
>  				inv_icm42607_accel_ext_infos),
>  	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42607_ACCEL_SCAN_Z,
>  				inv_icm42607_accel_ext_infos),
> +	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
>  };
> =20
>  static const int inv_icm42607_accel_scale_nano[][2] =3D {
> @@ -187,6 +190,11 @@ static int inv_icm42607_accel_read_raw(struct iio_de=
v *indio_dev,
>  	switch (chan->type) {
>  	case IIO_ACCEL:
>  		break;
> +	case IIO_TEMP:
> +		if (mask !=3D IIO_CHAN_INFO_SAMP_FREQ)
> +			return inv_icm42607_temp_read_raw(indio_dev, chan,
> +							  val, val2, mask);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/i=
io/imu/inv_icm42607/inv_icm42607_gyro.c
> index b68d4d6f5c3f..5b4683c2dd1e 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> @@ -15,6 +15,7 @@
>  #include <linux/types.h>
> =20
>  #include "inv_icm42607.h"
> +#include "inv_icm42607_temp.h"
> =20
>  #define INV_ICM42607_GYRO_CHAN(_modifier, _index, _ext_info)			\
>  {										\
> @@ -40,6 +41,7 @@ enum inv_icm42607_gyro_scan {
>  	INV_ICM42607_GYRO_SCAN_X,
>  	INV_ICM42607_GYRO_SCAN_Y,
>  	INV_ICM42607_GYRO_SCAN_Z,
> +	INV_ICM42607_GYRO_SCAN_TEMP,
>  };
> =20
>  static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[]=
 =3D {
> @@ -54,6 +56,7 @@ static const struct iio_chan_spec inv_icm42607_gyro_cha=
nnels[] =3D {
>  			       inv_icm42607_gyro_ext_infos),
>  	INV_ICM42607_GYRO_CHAN(IIO_MOD_Z, INV_ICM42607_GYRO_SCAN_Z,
>  			       inv_icm42607_gyro_ext_infos),
> +	INV_ICM42607_TEMP_CHAN(INV_ICM42607_GYRO_SCAN_TEMP),
>  };
> =20
>  static const int inv_icm42607_gyro_scale_nano[][2] =3D {
> @@ -184,6 +187,11 @@ static int inv_icm42607_gyro_read_raw(struct iio_dev=
 *indio_dev,
>  	switch (chan->type) {
>  	case IIO_ANGL_VEL:
>  		break;
> +	case IIO_TEMP:
> +		if (mask !=3D IIO_CHAN_INFO_SAMP_FREQ)
> +			return inv_icm42607_temp_read_raw(indio_dev, chan,
> +							  val, val2, mask);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c b/drivers/i=
io/imu/inv_icm42607/inv_icm42607_temp.c
> new file mode 100644
> index 000000000000..8681ef2b49e2
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +
> +#include "inv_icm42607.h"
> +#include "inv_icm42607_temp.h"
> +
> +static int inv_icm42607_temp_read(struct inv_icm42607_state *st, s16 *te=
mp)
> +{
> +	struct inv_icm42607_sensor_conf conf =3D INV_ICM42607_SENSOR_CONF_INIT;
> +	struct device *dev =3D regmap_get_device(st->map);
> +	int ret, gyro_mode, accel_mode;
> +	unsigned int val;
> +	u8 raw[2];
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/*
> +	 * Check if both the gyro and accel are off and if so, enable one
> +	 * of them. The temp sensor cannot be read if both the gyro and
> +	 * accel sensor are off. Prefer to enable the accel over the gyro
> +	 * as the datasheet says the gyro uses 5x more power and it has
> +	 * a minimum run time of 45ms.
> +	 */
> +	ret =3D regmap_read(st->map, INV_ICM42607_REG_PWR_MGMT0, &val);
> +	if (ret)
> +		return ret;
> +
> +	accel_mode =3D FIELD_GET(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, val);
> +	gyro_mode =3D FIELD_GET(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, val);
> +	if (!gyro_mode && !accel_mode) {
> +		/* enable accel sensor */
> +		conf.mode =3D INV_ICM42607_SENSOR_MODE_LOW_NOISE;
> +		ret =3D inv_icm42607_set_sensor_conf(st, &conf, IIO_ACCEL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D regmap_bulk_read(st->map, INV_ICM42607_REG_TEMP_DATA1,
> +			       raw, sizeof(raw));
> +	if (ret)
> +		return ret;
> +
> +	*temp =3D get_unaligned_be16(raw);
> +	if (*temp =3D=3D INV_ICM42607_DATA_INVALID)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +int inv_icm42607_temp_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct inv_icm42607_state *st =3D iio_device_get_drvdata(indio_dev);
> +	s16 temp;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D inv_icm42607_temp_read(st, &temp);
> +		if (ret)
> +			return ret;
> +		*val =3D temp;
> +		return IIO_VAL_INT;
> +	/*
> +	 * T=C2=B0C =3D (temp / 128) + 25
> +	 * Tm=C2=B0C =3D 1000 * ((temp * 100 / 12800) + 25)
> +	 * scale: 100000 / 12800 ~=3D 7.8125
> +	 * offset: 3200
> +	 */
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 7;
> +		*val2 =3D 812500000;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D 3200;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h b/drivers/i=
io/imu/inv_icm42607/inv_icm42607_temp.h
> new file mode 100644
> index 000000000000..18499b4d0b94
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#ifndef INV_ICM42607_TEMP_H_
> +#define INV_ICM42607_TEMP_H_
> +
> +#include <linux/bitops.h>
> +
> +struct iio_dev;
> +struct iio_chan_spec;
> +
> +#define INV_ICM42607_TEMP_CHAN(_index)				\
> +{								\
> +	.type =3D IIO_TEMP,					\
> +	.info_mask_separate =3D					\
> +		BIT(IIO_CHAN_INFO_RAW) |			\
> +		BIT(IIO_CHAN_INFO_OFFSET) |			\
> +		BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_all =3D				\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +	.info_mask_shared_by_all_available =3D			\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +	.scan_index =3D _index,					\
> +	.scan_type =3D {						\
> +		.sign =3D 's',					\
> +		.realbits =3D 16,					\
> +		.storagebits =3D 16,				\
> +		.endianness =3D IIO_BE,				\
> +	},							\
> +}
> +
> +int inv_icm42607_temp_read_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int *val, int *val2, long mask);
> +
> +#endif

