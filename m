Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E22D9EE4;
	Sun, 13 Sep 2026 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789322404; cv=none; b=qBaHxhfLF6BgeWfZ1a60fyi11sxaCNrVI0AszsAYhEhYMr1ixfKS3ZDWzoexaOxzt1gBeEiFKtvfhtci4AVPa8/c7YGJBbpf89PSojiXPzWS0W4hZYdKcoBOvDpxE0S/De5M4fU1NWb6wlKZ9jLLjot+wzWYKy2Q6ecMTGFJ48g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789322404; c=relaxed/simple;
	bh=F7PSpKrhhhyXKqIb4JKht12wYRH7i89Nyif3me99vdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1Cd2kq3Nw6jgYhFHwxI29fjhvihS07hMdBGXzmbpD4jpfaanuNPXqUKgugi6hI4eDhhrSLKajggzfE4Nw60A1qWFjoVIwLdtfh3H+75dRiYuJkUawW2pBLr0P+ewxD6ENv8ZmAQ8s6dn0OFwOXxfdg321zoE5deGIG3R3Uum7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocC/OXuN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocC/OXuN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF5D1F000FF;
	Sun, 13 Sep 2026 17:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789322401;
	bh=xwIqWdCPAdBnvKM2xMaWZb+9TtIoEAcJaPBaro/VthA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ocC/OXuN/+9OBcYqkBbrDOk1wpDOwAJu3HJiXt50AmeelBa8CC/N+d1dAJUxi4x21
	 dV3rb9hXonCR2SpdYNhaRBM15JslsGtdrs8UaEi9gJCbIsBRCVEMY6Gk0+0icLhkop
	 ltpQTDjyXdm7lhaZA0TNFIF98TazZiTdxI8C7tGRlfo+fDyVfzUIHNK0l7Gz5jQpvb
	 hEeC2wjug1v15LOGp1YSfRQq/p6E+/MRe0V6tIX1/a/Qp9FZNW7Dd+Zkxz6KGjubJS
	 zVUWp3g7DEgajUOa2nl6jSwShnRsy0arSaNj5iOCT+wLpvdYvKFkZfal0AZVKoeb8h
	 5keK8h60uwBsA==
Date: Sun, 13 Sep 2026 18:59:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <krzk+dt@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <conor+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] iio: temperature: add support for Analog Devices
 MAX30210
Message-ID: <20260913185955.13f5a37c@jic23-hlaptop>
In-Reply-To: <1d3cdd6163923b1c537b8db49b833863ee6bf545.1789032019.git.johnerasmusmari.geronimo@analog.com>
References: <cover.1789032019.git.johnerasmusmari.geronimo@analog.com>
	<1d3cdd6163923b1c537b8db49b833863ee6bf545.1789032019.git.johnerasmusmari.geronimo@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Sep 2026 06:12:17 +0800
John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com> wrote:

> Add support for the Analog Devices MAX30210 I2C temperature
> sensor.
>=20
> The driver uses regmap for register access and integrates with
> the IIO framework. It supports:
>=20
> - Direct mode temperature conversion
> - Configurable sampling frequency
> - Threshold events
> - FIFO operation with IIO kfifo buffer support
> - Optional interrupt-driven data ready signaling
>=20
> The device provides 16-bit signed temperature data and a
> 64-sample FIFO.
>=20
> Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analo=
g.com>
Hi John

Various comments inline

Jonathan

> diff --git a/drivers/iio/temperature/max30210.c b/drivers/iio/temperature=
/max30210.c
> new file mode 100644
> index 0000000000000..07ff85d6d4848
> --- /dev/null
> +++ b/drivers/iio/temperature/max30210.c
> @@ -0,0 +1,689 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices MAX30210 I2C Temperature Sensor driver
> + *
> + * Copyright 2026 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/regmap.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +
> +#define MAX30210_STATUS_REG		0x00
Up to you but I'm very much a fan of register address and fields together
in the code, using a bit of extra whitespace to make it obvious what
is going on. E.g.=20
#define MAX30210_STATUS_REG		0x00
#define   MAX30210_STATUS_A_FULL_MASK   BIT(7)
#define   MAX30210_STATUS_TEMP_RDY_MASK BIT(6)
#define   MAX30210_STATUS_TEMP_DEC_MASK BIT(5)
#define   MAX30210_STATUS_TEMP_INC_MASK BIT(4)
#define   MAX30210_STATUS_TEMP_LO_MASK  BIT(3)
#define   MAX30210_STATUS_TEMP_HI_MASK  BIT(2)
#define   MAX30210_STATUS_PWR_RDY_MASK  BIT(0)
#define MAX30210_INT_EN_REG		0x02
...

That means everything related to the register is one place
which saves me jumping around when reviewing.

> +#define MAX30210_INT_EN_REG		0x02
> +#define MAX30210_FIFO_DATA_REG		0x08
> +#define MAX30210_FIFO_CONF_1_REG	0x09
> +#define MAX30210_FIFO_CONF_2_REG	0x0A
> +#define MAX30210_SYS_CONF_REG		0x11
> +#define MAX30210_PIN_CONF_REG		0x12
> +#define MAX30210_TEMP_ALM_HI_REG	0x22
> +#define MAX30210_TEMP_ALM_LO_REG	0x24
> +#define MAX30210_TEMP_INC_THRESH_REG	0x26
> +#define MAX30210_TEMP_DEC_THRESH_REG	0x27
> +#define MAX30210_TEMP_CONF_1_REG	0x28
> +#define MAX30210_TEMP_CONF_2_REG	0x29
> +#define MAX30210_TEMP_CONV_REG		0x2A
> +#define MAX30210_TEMP_DATA_REG		0x2B
> +#define MAX30210_TEMP_SLOPE_REG		0x2D
> +#define MAX30210_UNIQUE_ID_REG		0x30
> +#define MAX30210_PART_ID_REG		0xFF
> +
> +#define MAX30210_STATUS_A_FULL_MASK   BIT(7)
> +#define MAX30210_STATUS_TEMP_RDY_MASK BIT(6)
> +#define MAX30210_STATUS_TEMP_DEC_MASK BIT(5)
> +#define MAX30210_STATUS_TEMP_INC_MASK BIT(4)
> +#define MAX30210_STATUS_TEMP_LO_MASK  BIT(3)
> +#define MAX30210_STATUS_TEMP_HI_MASK  BIT(2)
> +#define MAX30210_STATUS_PWR_RDY_MASK  BIT(0)
> +
> +#define MAX30210_FIFOCONF1_A_FULL_MASK		GENMASK(5, 0)
> +#define MAX30210_FIFOCONF1_FLUSH_FIFO_MASK	BIT(4)
> +
> +#define MAX30210_SYSCONF_RESET_MASK		BIT(0)

We often drop the MASK postfix for single bit flags where
the meaning is obvious like this one.
#define MAX30210_SYSCONF_RESET			BIT(0)
Is fine and feels more normal when you use it in the code.

Be careful though when doing this.  Sometimes a field is simply
one that takes only values 0 and 1 but is not representing a boolean.
Those ones need the _MASK postfix and use of FIELD_GET / FIELD_PREP.
A recent example of that was a register bank selector in another driver.
There were only two banks so it was one bit but the code was easier
to read with it being via FIELD_PREP(_BANK_MASK, 0) etc

> +
> +#define MAX30210_PINCONF_EXT_CNV_EN_MASK	BIT(7)
> +#define MAX30210_PINCONF_EXT_CVT_ICFG_MASK	BIT(6)
> +#define MAX30210_PINCONF_INT_FCFG_MASK		GENMASK(3, 2)
> +#define MAX30210_PINCONF_INT_OCFG_MASK		GENMASK(1, 0)

> +
> +static int max30210_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	unsigned int uval;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 5;
> +		*val2 =3D 1000;
> +
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret =3D regmap_read(st->regmap, MAX30210_TEMP_CONF_2_REG, &uval);
> +		if (ret)
> +			return ret;
> +
> +		uval =3D FIELD_GET(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, uval);
> +
> +		/*
> +		 * TEMP_PERIOD is an index into the sampling frequency lookup
> +		 * table. Clamp in case the register holds a reserved value.
> +		 */
> +		uval =3D min_t(unsigned int, uval, ARRAY_SIZE(max30210_samp_freq_avail=
) - 1);

min() without very good reasons.

> +
> +		*val =3D max30210_samp_freq_avail[uval][0];
> +		*val2 =3D max30210_samp_freq_avail[uval][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_RAW: {
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
> +
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		ret =3D regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
> +				   MAX30210_TEMPCONV_CONV_T_MASK);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Wait until CONVERT_T auto-clears.
> +		 * Datasheet:
> +		 *   tBIAS_WU =3D 260 =C2=B5s
> +		 *   tINT     =3D 8 ms
> +		 *
> +		 * Worst-case conversion =E2=89=88 8.26 ms.
> +		 * Use 10 ms timeout for margin.
> +		 */
> +		ret =3D regmap_read_poll_timeout(st->regmap, MAX30210_TEMP_CONV_REG, u=
val,
> +					       !(uval & MAX30210_TEMPCONV_CONV_T_MASK),
> +					       500,          /* poll every 500 =C2=B5s */
> +					       10000);       /* 10 ms timeout */
> +		if (ret)
> +			return ret;
> +
> +		return max30210_read_temp(st->regmap, MAX30210_TEMP_DATA_REG, val);
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int max30210_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		if (val < 0 || val2 < 0)
> +			return -EINVAL;

Not important but I'd move this check before the DIRECT_MODE claim
as it has nothing to do with device state.

> +
> +		for (unsigned int i =3D 0; i < ARRAY_SIZE(max30210_samp_freq_avail); i=
++) {
> +			if (val !=3D max30210_samp_freq_avail[i][0] ||
> +			    val2 !=3D max30210_samp_freq_avail[i][1])
> +				continue;
> +
> +			return regmap_update_bits(st->regmap, MAX30210_TEMP_CONF_2_REG,
> +					MAX30210_TEMPCONF2_TEMP_PERIOD_MASK,
> +					FIELD_PREP(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, i));
> +		}
> +
> +		return -EINVAL;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +
> +static int max30210_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	/* Enable FIFO-full interrupt */

More comments to think about whether they add anything useful over
the code.  If they do maybe the defines need their names to be
tweaked!  E.g. ALMOST_FULL would be clearer.  You don't need
to exactly match datasheets where space demands etc may have
lead to things getting too abbreviated to be useful!

> +	ret =3D regmap_set_bits(st->regmap, MAX30210_INT_EN_REG,
> +			      MAX30210_STATUS_A_FULL_MASK);
> +	if (ret)
> +		return ret;
> +
> +	/* Flush FIFO before starting autonomous conversions */
> +	ret =3D regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
> +			      MAX30210_FIFOCONF1_FLUSH_FIFO_MASK);
> +	if (ret)
> +		return ret;
> +
> +	/* Start autonomous temperature conversion */
> +	return regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
> +			    MAX30210_TEMPCONV_AUTO_MASK | MAX30210_TEMPCONV_CONV_T_MASK);

If you do use MASK prefix, then I'd expect to always have FIELD_PREP()
involved.  So another reason to drop _MASK from these things
that have obvious meaning without.  Even then I'd be temped
to use FIELD_PREP simply to align with the off case I mention below.

> +}
> +
> +static int max30210_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	/* Stop autonomous conversion */

Not obvious why you'd write the whole register. Perhaps
specify that 0 as

FIELD_PREP(MAX30210_TEMP_CONV_AUTO, 0) |
FIELD_PREP(MAX30210_TEMP_CONV_T, 0),

Compiler can flatten that to 0.


> +	ret =3D regmap_write(st->regmap, MAX30210_TEMP_CONV_REG, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	/* Flush FIFO */
> +	ret =3D regmap_set_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
> +			      MAX30210_FIFOCONF1_FLUSH_FIFO_MASK);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable FIFO-full interrupt */
> +	return regmap_clear_bits(st->regmap, MAX30210_INT_EN_REG,
> +				 MAX30210_STATUS_A_FULL_MASK);

Similar to below, the use of _MASK postfix for a flag like this to
me makes the code harder to read because I feel a need to go check
that it is just one bit.  Anyhow, that applies in lots of places.

> +}


> +static int max30210_setup(struct max30210_state *st, struct device *dev)
> +{
> +	struct gpio_desc *powerdown_gpio;
> +	unsigned int val;
> +	int ret;
> +
> +	/* Optional hardware reset via powerdown GPIO */

That is kind of obvious from the code so I'd drop the comment.

> +	powerdown_gpio =3D devm_gpiod_get_optional(dev, "powerdown",
> +						 GPIOD_OUT_HIGH);
It is fine to go a bit long on lines if it helps readability.
Here the gain is minor but it's only a few chars long.

> +	if (IS_ERR(powerdown_gpio))
> +		return dev_err_probe(dev, PTR_ERR(powerdown_gpio),
> +				     "failed to request powerdown GPIO\n");
> +
> +	if (powerdown_gpio) {
> +		/* Deassert powerdown to power up device */
> +		gpiod_set_value(powerdown_gpio, 0);
> +	} else {
> +		/* Software reset fallback */
Also obvious.  Check all your comments for ones that are saying things
that are naturally true.

> +		ret =3D regmap_set_bits(st->regmap, MAX30210_SYS_CONF_REG,
> +				      MAX30210_SYSCONF_RESET_MASK);

Comment at the top about use of _MASK postfix was from seeing this line.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Datasheet Figure 6:
> +	 * tPU max =3D 700 =C2=B5s after power-up or reset before device is rea=
dy.
> +	 */
> +	fsleep(700);
> +
> +	/* Clear status byte */

This is a good comment so keep it. Not obvious to anyone seeing the code
that the register is read to clear.

> +	return regmap_read(st->regmap, MAX30210_STATUS_REG, &val);
> +}
> +
> +static int max30210_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max30210_state *st;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EOPNOTSUPP;
When I see one of these I immediate search for uses of smbus
functions to check it's right.  Obviously here they are all hidden
by regmap which got me wondering why it wasn't regmap doing this
check...  So=20
https://elixir.bootlin.com/linux/v7.2.5/source/drivers/base/regmap/regmap-i=
2c.c#L350
for val_bits =3D 8 and reg_bits =3D 8 there are two possible paths.
	else if (config->val_bits =3D=3D 8 && config->reg_bits =3D=3D 8 &&
		 i2c_check_functionality(i2c->adapter,
					 I2C_FUNC_SMBUS_I2C_BLOCK))
		bus =3D &regmap_i2c_smbus_i2c_block;
	}
or
	else if (config->val_bits =3D=3D 8 && config->reg_bits =3D=3D 8 &&
		 i2c_check_functionality(i2c->adapter,
					 I2C_FUNC_SMBUS_BYTE_DATA))
		bus =3D &regmap_smbus_byte;
	}

The first one relies on auto increment behaviour for multi reg reads.
The second doesn't.  I guess this works because a device that doesn't
do autoincrement reads won't have a driver that issues them.

Anyhow upshot is it is already checked, so you don't need another check
in the driver.  At somepoint I'll do a sweep for these and remove
any that might get cut and paste into new drivers.

> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;


