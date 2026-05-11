Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAEA3D5244
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504810; cv=none; b=g3lwD6wTdizhqHZMwxFJFfVgbiNN9h4zlvlGGIyxyY/0tDzUF1X4TJserssyXshe2hMviCcPilCjj7iYOQbNHQ2DBgQM+V34CZZPa0uyDA7w7djsZCBDaTiMunpZHmumKK9kmyzXCzNpNvSuX+XCwQ/zIX3qN98OMKJv+G6cIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504810; c=relaxed/simple;
	bh=A0yZ+ZB7VMvrSEpsLyyhpYOWA3DWGFGP+DkJGGjo2KI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMtDjXhlppFgkeGWHpPQlCZIHXnAK8tvwwSKeanmb9kNRTboZdHC7XZ1B12Kkf+8I6ePZOCdtbg/M84IfndvTgFe5NQsiTi4OYxt1cPDRgSEbR4+ICD7VdrcDZTvTL/LUg708I6lG20B7fsSmnl/KTMtAmGP1bbCBOdaUh6Jq1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaRN0mOe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaRN0mOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEE7C2BCB0;
	Mon, 11 May 2026 13:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778504810;
	bh=A0yZ+ZB7VMvrSEpsLyyhpYOWA3DWGFGP+DkJGGjo2KI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NaRN0mOe111EXtelpUnI8rzN4pekQcWGA4r0BaFXnDR93lAJ5cg3ixye/mHNjDu5I
	 eAREtLC2DNJbSG4qmEf8tRj0yvV5KkEwdQJLJLrx3RgjbBcIkUcp2LViWUU7Yidmay
	 +n2Fx/a/jZKpHiZSKEPSbDV4az08taTEWqBSJMv71ADVTwxODZuVOzxMlR4Ea8j32U
	 Vw30hfmI0NDg8bnfpwRfxAC1QVoJa+cYNAIfopjBimebUPVx45VqSK6Gmfu0jjDQY9
	 oYUeIx3s38heL64+etLrO9E9sVqu06S9DYdaMPbGOCerp7BlFlp7ACyiIPFplorG1m
	 XVl6k+iFD7ZXw==
Date: Mon, 11 May 2026 14:06:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC 2/4] iio: light: add support for APDS9999 sensor
Message-ID: <20260511140644.42eb8edb@jic23-huawei>
In-Reply-To: <b272d93898a67baf7b4b8d02ba0061321906db6e.1778491503.git.azpijr@gmail.com>
References: <cover.1778491503.git.azpijr@gmail.com>
	<b272d93898a67baf7b4b8d02ba0061321906db6e.1778491503.git.azpijr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 12:14:47 +0200
"Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:

> Add IIO driver for Broadcom APDS9999 ambient light sensor.
>=20
> The APDS9999 is a digital proximity and RGB sensor with ALS
> capability. This driver implements the ALS/Lux functionality using the
> green channel.
>=20
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

Hi Jose,

For an RFC I'd normally expect to see a question list or other statement
of why it's an RFC rather than a formal submission.  One thing to note
is many reviewers won't even look at an RFC that doesn't have such
a list of questions.

Various comments inline but so far looks like a fairly standard light
sensor driver so all minor stuff.

Thanks,

Jonathan

> ---
>  drivers/iio/light/apds9999.c | 325 +++++++++++++++++++++++++++++++++++
>  1 file changed, 325 insertions(+)
>  create mode 100644 drivers/iio/light/apds9999.c
>=20
> diff --git a/drivers/iio/light/apds9999.c b/drivers/iio/light/apds9999.c
> new file mode 100644
> index 000000000000..cf44c3003415
> --- /dev/null
> +++ b/drivers/iio/light/apds9999.c
> @@ -0,0 +1,325 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for Broadcom APDS9999 Lux Light Sensor
> + *
> + * Uses the green channel (ALS) which approximates human eye spectral
> + * response for ambient light sensing (lux). RGB and proximity (PS)
> + * functionality not yet implemented.

I'd not mention what is todo twice. That just makes churn in patches
adding them!

> + *
> + * Copyright (C) 2026
> + * Author: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> + *
> + * TODO: proximity and color sensor
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/math64.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +
> +/* Registers */
Ideally a set of defines should be self describing enough to
not need 'section' comments.  These comments have a nasty habbit
of becoming wrong over time!

> +#define APDS9999_REG_MAIN_CTRL		0x00
> +#define APDS9999_REG_LS_MEAS_RATE	0x04
> +#define APDS9999_REG_LS_GAIN		0x05
> +#define APDS9999_REG_PART_ID		0x06
> +#define APDS9999_REG_MAIN_STATUS	0x07
> +#define APDS9999_REG_LS_DATA_GREEN_0	0x0D
> +
> +#define APDS9999_PART_ID		0xC2
> +
> +/* MAIN_CTRL */
> +#define APDS9999_MAIN_CTRL_LS_EN	BIT(1)

I would keep these with the registers addresses above.
A nice trick to make them look visually different is to use some
additional indenting.  e.g.

#define APDS9999_REG_MAIN_CTRL		0x00
#define   APDS9999_MAIN_CTRL_LS_EN	BIT(1)

#define APDS9999_REG_LS_MEAS_RATE	0x04
#define APDS9999_REG_LS_GAIN		0x05
#define APDS9999_REG_PART_ID		0x06
#define APDS9999_REG_MAIN_STATUS	0x07
#define   APDS9999_MAIN_STATUS_LS_DATA	BIT(3)
#define APDS9999_REG_LS_DATA_GREEN_0	0x0D
> +
> +/* MAIN_STATUS */
> +#define APDS9999_MAIN_STATUS_LS_DATA	BIT(3)
> +
> +/* LS_MEAS_RATE */
> +#define APDS9999_LS_RES_SHIFT		4
Define a mask instead then use FIELD_PREP() / FIELD_GET()
That combines ensuring no overflow with a single representation of
the register field.

> +
> +/*
> + * ALS gain options (register value -> factor)
> + */
Where it fits use single line comments
/* ALS gain options (register value -> factor) */

Given they are specific register values, it may make sense
to use defines or an enum then explicit initialization

> +static const int apds9999_gains[] =3D {
> +	1, 3, 6, 9, 18,
	[ADPDS9999_GAIN_X1] =3D 1,
	[ADPDS9999_GAIN_X3] =3D 3,

Then if you are initializing defaults etc you can use the register
value define directly.  Similar to you've done for RES.

> +};
> +
> +/*
> + * ALS resolution / integration time
> + * Resolution bits [6:4] set both the ADC bit-width and the
> + * integration time used in the lux conversion formula
> + * Value: integration time in microseconds
> + */
> +enum apds9999_resolution {
> +	APDS9999_RES_20BIT,	/* 400 ms */
> +	APDS9999_RES_19BIT,	/* 200 ms */
> +	APDS9999_RES_18BIT,	/* 100 ms (default) */
> +	APDS9999_RES_17BIT,	/*  50 ms */
> +	APDS9999_RES_16BIT,	/*  25 ms */
> +	APDS9999_RES_13BIT,	/*  3.125 ms */
> +	APDS9999_RES_NUM,
No trailing comma as that has to be last one.
For the others I'd use explicit assignment e.g.
	APDS9999_RES_20BIT =3D 0,
etc so it is clear they are actual register field values not
just an enum where any unique values are enough.
> +};
> +
> +static const int apds9999_itimes_us[APDS9999_RES_NUM] =3D {
> +	[APDS9999_RES_20BIT] =3D   400000,
> +	[APDS9999_RES_19BIT] =3D   200000,
> +	[APDS9999_RES_18BIT] =3D   100000,
> +	[APDS9999_RES_17BIT] =3D    50000,
> +	[APDS9999_RES_16BIT] =3D    25000,
> +	[APDS9999_RES_13BIT] =3D     3125,
> +};
> +
> +#define APDS9999_DEFAULT_RES		APDS9999_RES_18BIT
> +#define APDS9999_DEFAULT_GAIN_IDX	1	/* 3x */
> +#define APDS9999_DEFAULT_RATE		2	/* 100 ms */

Give defines for the actual register values.  Then use them in init()
rather than 'DEFAULT magic values.=20

> +
> +struct apds9999_data {
> +	struct i2c_client *client;
> +	struct mutex lock;
Locks must have a comment saying what data they are protecting.

> +	int als_gain_idx;	/* index into apds9999_gains[] */
> +	int als_res;		/* index into apds9999_itimes_us[] */
> +	int als_rate;		/* LS_MEAS_RATE[2:0] register value */
> +};
> +
> +/*
> + * Hardware init, write default register values and enable ALS
> + */
> +static int apds9999_init(struct apds9999_data *data)
> +{
> +	struct i2c_client *client =3D data->client;
> +	u8 reg;
> +	int ret;
> +
> +	mutex_lock(&data->lock);
As below - guard() helps in simple cases like this.

> +
> +	reg =3D (APDS9999_DEFAULT_RES << APDS9999_LS_RES_SHIFT) |
> +	      APDS9999_DEFAULT_RATE;

FIELD_PREP() for both of them so we won't need to figure out if they
are shifted or not.

> +	ret =3D i2c_smbus_write_byte_data(client, APDS9999_REG_LS_MEAS_RATE, re=
g);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret =3D i2c_smbus_write_byte_data(client, APDS9999_REG_LS_GAIN,
> +					APDS9999_DEFAULT_GAIN_IDX);

As mentioned above, actual define for that index rather than a default one.
The only place I expect to see what chosen defaults actually are is what
is passed to calls in this function.

> +	if (ret < 0)
> +		goto out;
> +
> +	ret =3D i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL,
> +					APDS9999_MAIN_CTRL_LS_EN);
> +	if (ret < 0)
> +		goto out;
> +
> +	data->als_gain_idx =3D APDS9999_DEFAULT_GAIN_IDX;
> +	data->als_res =3D APDS9999_DEFAULT_RES;
> +	data->als_rate =3D APDS9999_DEFAULT_RATE;
Given you don't unwind any of these written before an error (which is fine)
it makes more logical sense to assign these caches are each write is known
to succeed - that is spread them out in the function above.
> +
> +out:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +/*
> + * Read the 3-byte green-channel ADC value from 0x0D..0x0F
> + * Waits for LS_DATA_STATUS to be asserted (up to ~2x integration time)
> + */
> +static int apds9999_als_read(struct apds9999_data *data, u32 *counts)
> +{
> +	struct i2c_client *client =3D data->client;
> +	u8 buf[3];
> +	int ret, tries;
> +
> +	mutex_lock(&data->lock);
Use guard(mutex)(&data->lock); and direct returns in error paths given no n=
eed
to get to the unlock once it is happening on leaving the scope of the funct=
ion.

Make sure to also included cleanup.h for that.
> +
> +	/*
> +	 * Poll MAIN_STATUS for new data.  Timeout: ~2 integration periods
> +	 * plus margin.  Each try sleeps 20 ms

Do we have no way of having a better idea of how long we might need
to sleep?

> +	 */
> +	tries =3D (apds9999_itimes_us[data->als_res] * 2) / 20000;
> +	if (tries < 2)
> +		tries =3D 2;
	tries =3D max(2, tries);
Maybe combine with line above.

> +
> +	while (tries--) {
> +		ret =3D i2c_smbus_read_byte_data(client,
> +						APDS9999_REG_MAIN_STATUS);
> +		if (ret < 0)
> +			goto out;
> +		if (ret & APDS9999_MAIN_STATUS_LS_DATA)
> +			break;
> +		msleep(20);

fsleep() probably appropriate.

> +	}
> +
> +	if (tries < 0) {
> +		ret =3D -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	/* Block-read all 3 bytes of LS_DATA_GREEN */
> +	ret =3D i2c_smbus_read_i2c_block_data(client,
> +					     APDS9999_REG_LS_DATA_GREEN_0,
> +					     3, buf);
sizeof(buf)
> +	if (ret < 0)
> +		goto out;
> +	if (ret !=3D 3) {
sizeof(buf)
> +		ret =3D -EIO;
> +		goto out;
> +	}
> +
> +	*counts =3D buf[0] | ((u32)buf[1] << 8) | ((u32)(buf[2] & 0x0F) << 16);
Smells like get_unaligned_le24() & GENMASK(20, 0)
or something like that.

> +	ret =3D 0;
> +
> +out:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static int apds9999_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct apds9999_data *data =3D iio_priv(indio_dev);
> +	int gain, itime_us;
> +	u64 scale_nano;
> +	u32 counts;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D apds9999_als_read(data, &counts);
> +		if (ret < 0)
> +			return ret;
> +		*val =3D (int)counts;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Scale (lux per count) =3D 54 / (gain * integration_time_ms)
> +		 *
> +		 * The constant 54 is derived from the datasheet table:
> +		 *   at gain =3D 3x, itime =3D 100 ms =E2=86=92 0.180 lux/count
> +		 *   =E2=86=92 C =3D 0.180 * 3 * 100 =3D 54
> +		 *
> +		 * Expressed as IIO_VAL_INT_PLUS_NANO.
> +		 * Uses itime_us directly to avoid truncation for
> +		 * sub-millisecond integration times (e.g. 3.125 ms).
> +		 */
> +		gain =3D apds9999_gains[data->als_gain_idx];
> +		itime_us =3D apds9999_itimes_us[data->als_res];
> +
> +		/* scale_nano =3D 54e12 / (gain * itime_us) nano-lux/count */
> +		scale_nano =3D div_u64(54000000000000ULL,
> +				     (u32)(gain * itime_us));
> +		*val =3D (int)(scale_nano / 1000000000);

NANO rather than making a reviewer count 0s ;)

> +		*val2 =3D (int)(scale_nano % 1000000000);
> +		return IIO_VAL_INT_PLUS_NANO;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val =3D 0;
> +		*val2 =3D apds9999_itimes_us[data->als_res];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_chan_spec apds9999_channels[] =3D {
> +	{
> +		.type =3D IIO_LIGHT,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME),

Given this is mainly an RGB sensor I'd want to see the IIO_INTENSITY
channels there as well for an initial submission.  Understood
that you've sent this RFC for early feedback.


> +	},
> +};
> +
> +static const struct iio_info apds9999_info =3D {
> +	.read_raw =3D apds9999_read_raw,
> +};
> +
> +static int apds9999_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct apds9999_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret, part_id;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	data->client =3D client;
> +	mutex_init(&data->lock);
	ret =3D devm_mutex_init(&data->lock);
	if (ret)
		return ret;

The advantage this brings for lock debugging is pretty minor but it's
also cheap so for new code always use it.

> +
> +	part_id =3D i2c_smbus_read_byte_data(client, APDS9999_REG_PART_ID);
> +	if (part_id < 0) {
> +		dev_err(dev, "failed to read PART_ID: %d\n", part_id);
> +		return part_id;
> +	}
> +	if (part_id !=3D APDS9999_PART_ID) {
> +		dev_err(dev, "unexpected PART_ID 0x%02x (expected 0x%02x)\n",
> +			part_id, APDS9999_PART_ID);

We don't fail on missmatched IDs - it's fine to bring an info message but
not more than that.  The reason is fallback compatibles in device tree.
If a future device is fully compatible with this (it may have more features
and typically has a different part ID) we want the driver from
an old kernel to support it.  That only works if we don't error out on
failure to match IDs.
=20
> +		return -ENODEV;
> +	}
> +
> +	dev_dbg(dev, "APDS-9999 detected, PART_ID=3D0x%02x\n", part_id);
> +
> +	ret =3D apds9999_init(data);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to initialize device: %d\n", ret);
> +		return ret;
As below - return dev_err_probe()
> +	}
> +
> +	indio_dev->name =3D "apds9999";
> +	indio_dev->info =3D &apds9999_info;
> +	indio_dev->channels =3D apds9999_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(apds9999_channels);
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register IIO device: %d\n", ret);
> +		return ret;

For all error messages in probe() or functions called from probe() use
		return dev_err_probe(dev, ret, "failed to register IIO device\n");
which handles deferred probing, drop unnecessary prints such as those on me=
mory
failure, pretty prints the return value and usefully is more compact.

> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Disable the light sensor on driver removal
> + */
> +static void apds9999_remove(struct i2c_client *client)
> +{
> +	/* Set MAIN_CTRL to 0 =E2=86=92 LS_EN cleared, sensor enters standby */
> +	i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL, 0);
This looks to me like you will be doing tear down in a different order to
setup. For example the userspace interfaces will not be removeed until
after you've put the sensor in stand by.

There are two solutions to this (1st preferred)
1. Use devm_add_action_or_reset() to register the standby write here
   in a driver specific callback that is cleaned up in the right place.
   That might be registered in adps9999_init() rather than directly in prob=
e.
   Once you've done that drop the remove() callback as no longer needed.
2. Stop using devm_ registration calls from whereever in probe this matches
   up with.

Basically you mustn't mix and match devm and non devm based cleanup.

> +}
> +
> +static const struct i2c_device_id apds9999_id[] =3D {
> +	{ "apds9999", 0 },
The , 0 doesn't add anything so drop it
	{ "apds9999" },

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, apds9999_id);
> +
> +static const struct of_device_id apds9999_of_match[] =3D {
> +	{ .compatible =3D "brcm,apds9999" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, apds9999_of_match);
> +
> +static struct i2c_driver apds9999_driver =3D {
> +	.driver =3D {
> +		.name =3D "apds9999",
> +		.of_match_table =3D apds9999_of_match,
> +	},
> +	.probe =3D apds9999_probe,
> +	.remove =3D apds9999_remove,
> +	.id_table =3D apds9999_id,
> +};
> +
Common convention to tightly compule this macro with the struct i2c_driver
by not having a blank line here.

> +module_i2c_driver(apds9999_driver);
> +
> +MODULE_AUTHOR("Jose A. Perez de Azpillaga <azpijr@gmail.com>");
> +MODULE_DESCRIPTION("APDS-9999 Lux Light Sensor IIO Driver");
> +MODULE_LICENSE("GPL");

