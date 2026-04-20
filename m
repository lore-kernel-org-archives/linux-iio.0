Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD13B36EAAC;
	Mon, 20 Apr 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694954; cv=none; b=qxQPgXBSBSZMF5fL4GSG6mE5ctWjvVipddOgu15m1pBqnX9u+eW+yrVoZzmVIdKigckLY58e/6eSntTbrVOicj/okfsaEuOXOhEMvLQD54vPHpDufkFSoj5c8+nwdw9Uu4jaFf+SRVbgiFLYJSPgOk8D9lMCcVSqV9wrKHWNVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694954; c=relaxed/simple;
	bh=84Wzva522RLPNzNuHkgQG2mQNj6E6SufCbJx/6Fo5JE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noYjpus/Hridc2mjz3f1QoQ0eTNCweSn64vF2lB/SVcTR2tfqDgBanKc0pvRGUmjoBthMtiA6L7IA7X4YSDJ+/wuQD5tgXPyhNNPovq4UsDF+ZtL+puMpIZetR0hHw+l9+sq0mVzKXA254m/Y0o2IufUwg8o8oRs83+D7GOmyhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMIZe3/Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMIZe3/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC76C19425;
	Mon, 20 Apr 2026 14:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776694954;
	bh=84Wzva522RLPNzNuHkgQG2mQNj6E6SufCbJx/6Fo5JE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WMIZe3/QEHSGesUZiqK7KB5JtfdIPbqGq6ecPPyTb/O3/S6mart7H1X0wDabC+/rk
	 H0LOZ28A0qyFNhAdLQH52xmhiNpMMvWU+KeDFgm0W+pujdUp+QuRQ9QXgsnijVDn5a
	 Tj6iD/pkZ9/panPCfc+85TN9KpnYXFDPlbT9UtyW0yloEZQQ3vbmwUQsBoainGv4jy
	 vmc670u52CFLGcU6KwKrbQhhICQMjPJRMqQpr+/zN+V64kE3duPw0392p7jKz8qpqp
	 b5Yp8iajx9ZqQhG65ngxu8Qr4vtqXL7WbBMIsZQro1OoysFgy3FMAdRF2jc2LYnjte
	 q+Yfkoy8ed89Q==
Date: Mon, 20 Apr 2026 15:22:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hardik Phalet <hardik.phalet@pm.me>
Cc: gregkh@linuxfoundation.org, andy@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, me@brighamcampbell.com, nuno.sa@analog.com,
 robh@kernel.org, skhan@linuxfoundation.org, Hardik Phalet
 <hardik.phalet@gmail.com>
Subject: Re: [PATCH v3 3/5] iio: magnetometer: add driver for QST QMC5883P
Message-ID: <20260420152223.32c89f24@jic23-huawei>
In-Reply-To: <20260420-qmc5883p-driver-v3-3-da1e97088f8b@pm.me>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
	<20260420-qmc5883p-driver-v3-3-da1e97088f8b@pm.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Apr 2026 22:32:43 +0000
Hardik Phalet <hardik.phalet@pm.me> wrote:

> Add an IIO driver for the QST QMC5883P, a 3-axis anisotropic
> magneto-resistive (AMR) magnetometer with a 16-bit ADC, communicating
> over I2C. There is no existing upstream driver for this device.
>=20
> The driver supports:
>  - Raw magnetic field readings on X, Y and Z axes
>  - Four full-scale ranges (+/-2 G, +/-8 G, +/-12 G, +/-30 G) selectable
>    via IIO_CHAN_INFO_SCALE
>  - Output data rate configurable via IIO_CHAN_INFO_SAMP_FREQ (10, 50,
>    100, 200 Hz)
>  - vdd-supply regulator management
>=20
> Regmap with an rbtree cache is used throughout. CTRL_1 and CTRL_2 bit
> fields are accessed via regmap_field to avoid read-modify-write races.
> The STATUS register is marked precious so regmap never reads it
> speculatively and clears the DRDY/OVFL bits unexpectedly.
>=20
> The probe-time init sequence is: soft reset, wait 300 us for POR
> completion, deassert reset, then drop the register cache so subsequent
> RMW writes read fresh values from the device. After reset the chip is in
> MODE_SUSPEND per datasheet =C2=A76.2.4, and is left there; the first
> userspace access will wake it via runtime PM (added in a follow-up
> patch).
>=20
> Cleanup is fully devm-managed via devm_regulator_get_enable() and
> devm_iio_device_register().
>=20
> Oversampling ratio and runtime PM are added in follow-up patches.
>=20
> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
Hi Hardik,

Welcome to IIO. Various comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/=
Kconfig
> index fb313e591e85..333c5e6f231d 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -298,4 +298,15 @@ config YAMAHA_YAS530
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called yamaha-yas.
> =20
> +config QMC5883P
Should be somewhere further up. In theory at least these files are in alpha=
numeric
order.

> +	tristate "QMC5883P 3-Axis Magnetometer"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to build support for QMC5883P I2C-based
> +	  3-axis magnetometer chip.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called qmc5883p.
> +
>  endmenu
> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer=
/Makefile
> index 5bd227f8c120..ff519a055d77 100644
> --- a/drivers/iio/magnetometer/Makefile
> +++ b/drivers/iio/magnetometer/Makefile
> @@ -39,3 +39,5 @@ obj-$(CONFIG_SI7210)			+=3D si7210.o
>  obj-$(CONFIG_TI_TMAG5273)		+=3D tmag5273.o
> =20
>  obj-$(CONFIG_YAMAHA_YAS530)		+=3D yamaha-yas530.o
> +
> +obj-$(CONFIG_QMC5883P) +=3D qmc5883p.o
Alphabetical order.

> diff --git a/drivers/iio/magnetometer/qmc5883p.c b/drivers/iio/magnetomet=
er/qmc5883p.c
> new file mode 100644
> index 000000000000..e4a76ae7c2cf
> --- /dev/null
> +++ b/drivers/iio/magnetometer/qmc5883p.c
> @@ -0,0 +1,574 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * qmc5883p.c - QMC5883P magnetometer driver

No point in having the file name in the file.  The only thing that can
do is become wrong in the longer term!

> + *
> + * Copyright 2026 Hardik Phalet <hardik.phalet@pm.me>
> + *
> + * TODO: add triggered buffer support, PM, OSR, DSR
> + *
Blank line above doesn't add anything. Mind you I'm not really
sure driver todo lists add much in general. It's perfectly ok to
never support some of these features.

> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/units.h>
> +#include <linux/unaligned.h>
Seems a very short list.  e.g. dev_printk.h is missing.
Give this another look and follow the (unfortunately) rather fuzzy
version of Include What You Use principles.

> +/*
> + * Oversampling rate
Single line comment seems fine here.
Same for other ones above.


> + */
> +#define QMC5883P_OSR_8 0x00
> +#define QMC5883P_OSR_4 0x01
> +#define QMC5883P_OSR_2 0x02
> +#define QMC5883P_OSR_1 0x03

> +
> +struct qmc5883p_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct mutex mutex; /* protects regmap and rf field accesses */

Need more on that comment.  Why does it mater?  regmap has it's own internal
locks.  Are there some sequences of accesses that must be done without
anything else in between?

> +	struct qmc5883p_rf rf;
> +};
> +
> +enum qmc5883p_channels {

I don't think the named nature of the enum is used. If not, just make
it anonymous.

> +	AXIS_X =3D 0,
> +	AXIS_Y,
> +	AXIS_Z,
> +};
>
> +
> +static const struct regmap_config qmc5883p_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D 0x0B,
> +	.cache_type =3D REGCACHE_RBTREE,

Why this rather than MAPLE?  Unless you have strong reason just
go with REGCACHE_MAPLE so no one asks ;)


> +	.rd_table =3D &qmc5883p_readable_table,
> +	.wr_table =3D &qmc5883p_writable_table,
> +	.volatile_table =3D &qmc5883p_volatile_table,
> +	.precious_table =3D &qmc5883p_precious_table,
> +};
> +
> +static const struct reg_field qmc5883p_rf_osr =3D
> +	REG_FIELD(QMC5883P_REG_CTRL_1, 4, 5);
> +static const struct reg_field qmc5883p_rf_odr =3D
> +	REG_FIELD(QMC5883P_REG_CTRL_1, 2, 3);
> +static const struct reg_field qmc5883p_rf_mode =3D
> +	REG_FIELD(QMC5883P_REG_CTRL_1, 0, 1);
> +static const struct reg_field qmc5883p_rf_rng =3D
> +	REG_FIELD(QMC5883P_REG_CTRL_2, 2, 3);
> +static const struct reg_field qmc5883p_rf_sftrst =3D
> +	REG_FIELD(QMC5883P_REG_CTRL_2, 7, 7);
> +static const struct reg_field qmc5883p_rf_chip_id =3D
> +	REG_FIELD(QMC5883P_REG_CHIP_ID, 0, 7);
> +
> +/*
> + * qmc5883p_get_measure - read all three axes.

I think that bit is obvious from the function signature so I'd drop it.

> + * Must be called with data->mutex held.

Instead of a comment, use markings on the function so the compiler / static
analysis can check it.  Look at __must_hold()  That acts as both a real

check and documentation.


> + */
> +static int qmc5883p_get_measure(struct qmc5883p_data *data, s16 *x, s16 =
*y,
> +				s16 *z)
> +{
> +	int ret;
> +	u8 reg_data[6];

	__le16 reg_data[3];

and use aligned accessors below.

> +	unsigned int status;
> +
> +	/*
> +	 * Poll the status register until DRDY is set or timeout.
> +	 * Read the whole register in one shot so that OVFL is captured from
> +	 * the same read: reading 0x09 clears both DRDY and OVFL, so a second
> +	 * read would always see OVFL=3D0.
> +	 * At ODR=3D10Hz one period is 100ms; use 150ms as a safe upper bound.
> +	 */
> +	ret =3D regmap_read_poll_timeout(data->regmap, QMC5883P_REG_STATUS,
> +				       status, status & QMC5883P_STATUS_DRDY,
> +				       QMC5883P_DRDY_POLL_US,
> +				       150 * (MICRO / MILLI));
> +	if (ret)
> +		return ret;
> +
> +	if (status & QMC5883P_STATUS_OVFL) {
> +		dev_warn_ratelimited(data->dev,
> +			"data overflow, consider reducing field range\n");
> +		ret =3D -ERANGE;
> +		return ret;
=09
		return -ERANGE;

> +	}
> +
> +	ret =3D regmap_bulk_read(data->regmap, QMC5883P_REG_X_LSB, reg_data,
> +			       ARRAY_SIZE(reg_data));
> +	if (ret)
> +		return ret;
> +
> +	*x =3D (s16)get_unaligned_le16(&reg_data[0]);
> +	*y =3D (s16)get_unaligned_le16(&reg_data[2]);
> +	*z =3D (s16)get_unaligned_le16(&reg_data[4]);
> +
> +	return ret;
> +}
> +
> +static int qmc5883p_read_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	s16 x, y, z;
> +	struct qmc5883p_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +	unsigned int regval;

When nothing else gives an order to definitions go with reverse
xmas tree.=20

> +
> +	guard(mutex)(&data->mutex);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D qmc5883p_get_measure(data, &x, &y, &z);
> +		if (ret < 0)
> +			return ret;
> +		switch (chan->address) {
> +		case AXIS_X:
> +			*val =3D x;
> +			break;
> +		case AXIS_Y:
> +			*val =3D y;
> +			break;
> +		case AXIS_Z:
> +			*val =3D z;
> +			break;
> +		}
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret =3D regmap_field_read(data->rf.rng, &regval);
> +		if (ret < 0)
> +			return ret;
> +		*val =3D qmc5883p_scale[regval][0];
> +		*val2 =3D qmc5883p_scale[regval][1];
> +		return IIO_VAL_INT_PLUS_NANO;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret =3D regmap_field_read(data->rf.odr, &regval);
> +		if (ret < 0)
> +			return ret;
> +		*val =3D qmc5883p_odr[regval];
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int qmc5883p_write_scale(struct qmc5883p_data *data, int val, int=
 val2)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(qmc5883p_scale); i++) {
> +		if (qmc5883p_scale[i][0] =3D=3D val && qmc5883p_scale[i][1] =3D=3D val=
2)
> +			return regmap_field_write(data->rf.rng, i);

Another sashiko one I might have missed.  Given there is only one field
for all channels, is having per channel scale appropriate?

Under the ABI it's not wrong to do that, as any ABI element being modified
is allowed to modify any other (that's there to handle complex interactions)
but it might not be the best we can do wrt to a user friendly interface.


> +	}
> +
> +	return -EINVAL;
> +}

...

> +
> +static int qmc5883p_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct qmc5883p_data *data =3D iio_priv(indio_dev);
> +	int ret, restore;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	ret =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);

Sashiko was complaining about this and what mode we are in after reset
before calling this function. See below.  I think the solution
is probably to put it in normal mode in probe() and then deal with this
stuff as runtime pm later.


> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret =3D qmc5883p_write_odr(data, val);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret =3D qmc5883p_write_scale(data, val, val2);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	restore =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
> +	if (restore && !ret)
> +		ret =3D restore;
> +
> +	return ret;
> +}
> +
> +/*
> + * qmc5883p_read_avail - expose available values to userspace.
> + *
> + * Creates the _available sysfs attributes automatically:
> + *   in_magn_sampling_frequency_available
> + *   in_magn_scale_available

Probably standard enough for an IIO driver to not need a comment
that is more about what the core code is doing with this than what
this function does.

I'd drop the comment. It is the sort of thing that will become out
of date as a driver evolves and doesn't bring enough value to make
that risk worthwhile.

> + */
> +static int qmc5883p_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals =3D qmc5883p_odr;
> +		*type =3D IIO_VAL_INT;
> +		*length =3D ARRAY_SIZE(qmc5883p_odr);
> +		return IIO_AVAIL_LIST;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals =3D (const int *)qmc5883p_scale;
> +		*type =3D IIO_VAL_INT_PLUS_NANO;
> +		*length =3D ARRAY_SIZE(qmc5883p_scale) * 2;
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/*
> + * Tell the IIO core how to parse sysfs writes. Without this, the core
> + * defaults to IIO_VAL_INT_PLUS_MICRO (6 fractional digits), which would
> + * silently truncate nano-scale writes like "0.000000040" to 0.

Not sure this comment is really needed given this is a
pretty standard IIO thing.

> + */
> +static int qmc5883p_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan,
> +				      long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info qmc5883p_info =3D {
> +	.read_raw =3D qmc5883p_read_raw,
> +	.write_raw =3D qmc5883p_write_raw,
> +	.write_raw_get_fmt =3D qmc5883p_write_raw_get_fmt,
> +	.read_avail =3D qmc5883p_read_avail,
> +};
> +
> +static int qmc5883p_rf_init(struct qmc5883p_data *data)
> +{
> +	struct regmap *regmap =3D data->regmap;
> +	struct device *dev =3D data->dev;
> +	struct qmc5883p_rf *rf =3D &data->rf;
> +
> +	rf->osr =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_osr);

Might be worth looking at whether you can use
devm_regmap_field_bulk_alloc() without impacting the code readability too
much. I'm fine with this if that option looks too ugly by needing an
enum to index the fields.  Main positive is it would avoid the
repetition in this function.



> +	if (IS_ERR(rf->osr))
> +		return PTR_ERR(rf->osr);
> +
> +	rf->odr =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_odr);
> +	if (IS_ERR(rf->odr))
> +		return PTR_ERR(rf->odr);
> +
> +	rf->mode =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_mode);
> +	if (IS_ERR(rf->mode))
> +		return PTR_ERR(rf->mode);
> +
> +	rf->rng =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_rng);
> +	if (IS_ERR(rf->rng))
> +		return PTR_ERR(rf->rng);
> +
> +	rf->sftrst =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_sftrst);
> +	if (IS_ERR(rf->sftrst))
> +		return PTR_ERR(rf->sftrst);
> +
> +	rf->chip_id =3D devm_regmap_field_alloc(dev, regmap, qmc5883p_rf_chip_i=
d);
> +	if (IS_ERR(rf->chip_id))
> +		return PTR_ERR(rf->chip_id);
> +
> +	return 0;
> +}
> +

> +
> +#define QMC5883P_CHAN(ch)                                               =
  \
> +	{                                                                 \
> +		.type =3D IIO_MAGN,                                         \
> +		.channel2 =3D IIO_MOD_##ch,                                 \
> +		.modified =3D 1,                                            \
> +		.address =3D AXIS_##ch,                                     \
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |            \
> +				      BIT(IIO_CHAN_INFO_SCALE),           \
> +		.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE), \

See above, whether scale is really separate of should be in shared_by_type.


> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +		.info_mask_shared_by_type_available =3D                     \
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),                     \
> +	}
> +
> +static const struct iio_chan_spec qmc5883p_channels[] =3D {
> +	QMC5883P_CHAN(X),
> +	QMC5883P_CHAN(Y),
> +	QMC5883P_CHAN(Z),
> +};
> +
> +static int qmc5883p_chip_init(struct qmc5883p_data *data)
> +{
> +	int ret;
> +
> +	ret =3D regmap_field_write(data->rf.sftrst, 1);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The datasheet does not specify a post-reset delay, but POR
> +	 * completion takes up to 250 microseconds. Use 300 microseconds
> +	 * to be safe.

Very minor, but wrap comments up to 80 chars. That gives us:
(my email client has a ruler which makes these easy to spot!)

	 * The datasheet does not specify a post-reset delay, but POR completion
	 * takes up to 250 microseconds. Use 300 microseconds to be safe.
> +	 */
> +	fsleep(300);
> +
> +	ret =3D regmap_field_write(data->rf.sftrst, 0);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Soft reset restored every register to its default. Drop the cache
> +	 * so subsequent RMW writes read fresh values from the device.
> +	 */
> +	regcache_drop_region(data->regmap, QMC5883P_REG_CHIP_ID,
> +			     QMC5883P_REG_CTRL_2);
> +
> +	/* Chip is now in MODE_SUSPEND per datasheet =C2=A76.2.4. Leave it ther=
e. */

As below, sashiko raises concern that we can't read if if suspend mode so a=
fter
this patch the driver doesn't function right.  I haven't looked into it in =
detail
but sounds plausible.

> +	return 0;
> +}
> +
> +static int qmc5883p_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct qmc5883p_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap =3D devm_regmap_init_i2c(client, &qmc5883p_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "regmap initialization failed\n");
> +
> +	data =3D iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

Add this when it is used. I'd guess in the runtime pm patch.
Note that shashiko raised some concerns about bisectibility and they
make me wonder if there are problems if runtime pm is simply disabled.
To handle that we normally make sure the device is in whatever mode is
needed to take a reading before we turn on runtime pm.

https://sashiko.dev/#/patchset/20260420-qmc5883p-driver-v3-0-da1e97088f8b%4=
0pm.me

(Note this wasn't running on linux-iio until a few days ago so your
earlier versions weren't covered!)

> +	data->dev =3D dev;
> +	data->regmap =3D regmap;
> +
> +	mutex_init(&data->mutex);
For new code prefer
	ret =3D devm_mutex_init(dev, &data->mutex);
	if (ret)
		return ret;

It brings minor benefits for lock debugging hence I'm not inclined
to update old code, but we might as well use best practice in
new code.

> +
> +	ret =3D qmc5883p_rf_init(data);
> +	if (ret)
...


> +static const struct of_device_id qmc5883p_of_match[] =3D {
> +	{ .compatible =3D "qstcorp,qmc5883p" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qmc5883p_of_match);
> +
> +static const struct i2c_device_id qmc5883p_id[] =3D {
> +	{ "qmc5883p", 0 },

	{ "qmc5883p" },

Is enough.  Under the C spec .driver_data gets set to 0 anyway
but more important is it isn't used, so we shouldn't set it.  Any change
to add more parts will require changing that line anyway so we aren't
saving on future churn by setting it.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, qmc5883p_id);

