Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E7F2DCBEC
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241041; cv=none; b=uj/V+4lh+ZDwkuaLSu7fDEa4usegzFF5utx2WS0A5MvO8DTUZD4yx4OKHyPCEl+SrUjXQlSk7fMcQBm9U6tqoZYl668FymMSoFCry69js0EOQCfCPb/ldyd34mvoAyoK8ZmWbljbAeCwheUihZKwNiEkt9+iMwyPy5hFbJTMF1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241041; c=relaxed/simple;
	bh=GhsNWso5/4BP8XEaHdLw/VTXsVaZ5riTiZiXGuC2YYg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eqCWao1XYE1kbMezqCSN26fC4wXcox2Pvsac2RV0D2n3uLvH93cGM5iibs9LON055zDyHUPaWDEOSTfWTV5qyEsXZtv9eV2XK5ESXIOP09TYN7x5nh5jE4hso8ETwKlKXGlT9oEOb5oIXJEGMh77qtqYmJj6mKFRYYsAfqi/68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wS5Z5POF; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wS5Z5POF"
Message-ID: <36ffe80feb5a521c28b1a6d10bf1338dc39ddef1.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782241028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4qURfEOSLz+hRvUsnxUJ4NxQFo0HE18d/70dD5NeZ4=;
	b=wS5Z5POFFtcJ4fga247nhIxCkhYrhxMfSMNCj4UQRltpX4UgB2oKll5zRTCfk+6oMpXD5l
	6sqd0qMVc4idLRmGyaXTsvPIuXyD17X8bFn6QyTVfeE+LnY7xfr2wPm6j+m9IJ9plNanEN
	svaQmtTnNbQylxa12GeZ2dfqEK8/qt0=
Subject: Re: [PATCH 1/2] iio: dac: dac8163: Add driver for DAC8163
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: lukas.metz@gmx.net
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, jic23@kernel.org, krzk+dt@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, 	robh@kernel.org
Date: Wed, 24 Jun 2026 00:56:15 +0600
In-Reply-To: <20260623-dac8163-work-v1-1-5b508158faa0@gmx.net>
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
	 <20260623-dac8163-work-v1-1-5b508158faa0@gmx.net>
X-Priority: 1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Tue, 2026-06-23 at 18:07 +0200, Lukas Metz wrote:
> The DAC756x, DAC816x, and DAC856x devices are low-power, voltage-output,
> dual-channel, 12-, 14-, and 16-bit digital-to-analog converters (DACs),
> respectively. These devices include a 2.5-V, 4-ppm/=C2=B0C internal
> reference, giving a full-scale output voltage range of 2.5 V or 5 V.
>=20
> Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 ++
> =C2=A0drivers/iio/dac/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/dac/ti-dac8163.c | 339 ++++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A04 files changed, 356 insertions(+)
Hi! I took a quick look, and probably missed a lot of stuff. But here are m=
y thoughts.
> diff --git a/MAINTAINERS b/MAINTAINERS
...
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DACxx6x IIO driver (SPI)
> + */
A link to the datasheet here would be nice.
> +
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/of.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/iio/iio.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/units.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/printk.h>
> +#include <linux/bitfield.h>
Sort the includes alphabetically. And include what you use. "mod_devicetabl=
e.h" is missing for example.
While at it, separate the core headers from "<linux/iio/iio.h>". add ir in =
a sepatate line.
> +
> +#define COMMAND_MASK GENMASK(6, 3)
> +#define ADDRESS_MASK GENMASK(2, 0)
> +
> +#define COMMAND_SET(x, y) (FIELD_PREP(COMMAND_MASK, (x)) | \
> +							FIELD_PREP(ADDRESS_MASK, (y)))
I'd align the FIELD_PREPs to make it look better. It may also fit in a sing=
le line.
> +
> +#define CMD_WRITE_INPUT_REG	0x0
> +#define CMD_UPDATE_DAC	0x1
> +#define CMD_WRITE_UPDATE_ALL	0x2
> +#define CMD_WRITE_UPDATE	0x3
> +#define CMD_SET_PWR_MODE		0x4
> +#define CMD_SOFT_RST			0x5
> +
> +#define CMD_LDAC_MODE		0x6
> +#define LDAC_MODE_CHANNEL_A_MASK BIT(0)
> +#define LDAC_MODE_CHANNEL_B_MASK BIT(1)
> +
> +#define CMD_SEL_REFERENCE	0x7
> +#define VOLTAGE_REFERENCE_MASK BIT(0)
> +
Group the CMD values together, also all these values would look better alig=
ned.
> +enum dacxx6x_ldac_modes {
> +	LDAC_MODE_ACTIVE =3D 0,
> +	LDAC_MODE_INACTIVE =3D 1
> +};
A trailing comma would be nice.
> +
> +enum dacxx6x_voltage_reference {
> +	VOLTAGE_REFERENCE_EXTERNAL =3D 0,
> +	VOLTAGE_REFERENCE_INTERNAL =3D 1
> +};
Same here
> +
> +enum dacxx6x_supported_device_ids {
> +	ID_DAC7562,
> +	ID_DAC7563,
> +	ID_DAC8162,
> +	ID_DAC8163,
> +	ID_DAC8562,
> +	ID_DAC8563
> +};
> +
Here too.
>=20
> +struct dacxx6x_state {
Since the filename is dac8163.c, how about naming the functions/structs/oth=
er symbols that as well instead of dacxx6x?
> +	struct spi_device *spi;
> +
How about use regmap?
> +	struct regulator *vref;
> +	struct gpio_desc *loaddacs;
> +
> +	bool internal_ref;
> +	int vref_uv;
> +
> +	unsigned int cached[2];
> +
> +	/*
> +	 * Lock to protect the state of the device from potential concurrent
> +	 * write accesses from userspace.
> +	 */
> +	struct mutex lock;
> +};
> +
> +struct dacxx6x_chip_info {
> +	const char *name;
> +	const struct iio_chan_spec channels[2];
> +};
> +
> +#define DACXX6X_CHAN(id, resolution)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +	{=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +		.type =3D IIO_VOLTAGE, .channel =3D (id), .output =3D 1,=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +		.indexed =3D 1, .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
> +		.scan_type =3D { .realbits =3D (resolution),=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shift =3D 16 - (resolution) },=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
> +	}
> +
> +static const struct dacxx6x_chip_info dacxx6x_chip_info_table[6] =3D {
> +	[ID_DAC7562] =3D {
> +		.name =3D "dac7562",
> +		.channels =3D {
> +			DACXX6X_CHAN(0, 12),
> +			DACXX6X_CHAN(1, 12),
> +		}
> +	},
> +	[ID_DAC7563] =3D {
> +		.name =3D "dac7563",
> +		.channels =3D {
> +			DACXX6X_CHAN(0, 12),
> +			DACXX6X_CHAN(1, 12),
> +		}
> +	},
> +	[ID_DAC8162] =3D {
> +		.name =3D "dac8162",
> +		.channels =3D {
> +			DACXX6X_CHAN(0, 14),
> +			DACXX6X_CHAN(1, 14),
> +		}
> +	},
> +	[ID_DAC8163] =3D {
> +		.name =3D "dac8163",
> +		.channels =3D {
> +			DACXX6X_CHAN(0, 14),
> +			DACXX6X_CHAN(1, 14),
> +		}
> +	},
> +	[ID_DAC8562] =3D {
> +		.name =3D "dac8562",
> +		.channels =3D {
> +			DACXX6X_CHAN(0, 16),
> +			DACXX6X_CHAN(1, 16),
> +		}
> +	},
> +	[ID_DAC8563] =3D {
> +		.name =3D "dac8563",
> +		.channels =3D {
> +			DACXX6X_CHAN(0, 16),
> +			DACXX6X_CHAN(1, 16),
> +		}
> +	},
> +};
> +
> +static int dacxx6x_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *val,
> +			=C2=A0=C2=A0=C2=A0 int *val2, long mask)
> +{
> +	struct dacxx6x_state *st;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		st =3D iio_priv(indio_dev);
Could this be assigned  before the switch?
> +		mutex_lock(&st->lock);
> +		*val =3D st->cached[chan->channel];
> +		mutex_unlock(&st->lock);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		st =3D iio_priv(indio_dev);
> +		*val =3D st->vref_uv / MILLI; /* vref in mV */
> +		*val2 =3D chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int dacxx6x_write_reg(struct dacxx6x_state *st, int reg, int addr=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val)
> +{
> +	u8 tx[3];
> +
> +	tx[0] =3D COMMAND_SET(reg, addr);
> +	tx[1] =3D (val >> 8) & 0xff;
How about put_unaligned_be16?
>=20
> +	tx[2] =3D val & 0xff;
> +
> +	return spi_write(st->spi, tx, sizeof(tx));
> +}
> +
> +static int dacxx6x_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int val,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int val2, long mask)
> +{
> +	struct dacxx6x_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D &st->spi->dev;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		dev_dbg(dev, "%s: val=3D%d val2=3D%d\n", __func__, val, val2);
> +		if (val2 !=3D 0)
> +			return -EINVAL;
> +
> +		if (val < 0 || val >=3D BIT(chan->scan_type.realbits))
> +			return -EINVAL;
> +
> +		mutex_lock(&st->lock);
> +		int ret =3D dacxx6x_write_reg(st, CMD_WRITE_UPDATE, chan->channel,
> +					=C2=A0=C2=A0=C2=A0 (unsigned int)val
> +						=C2=A0=C2=A0=C2=A0 << chan->scan_type.shift);
This case should be enclosed { }. Also, Use guard() from "cleanup.h" instea=
d of manual mutex lock/unlock. Here and in
other places.
> +
> +		if (!ret)
> +			st->cached[chan->channel] =3D val;
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info dacxx6x_iio_info =3D {
> +	.write_raw =3D dacxx6x_write_raw,
> +	.read_raw =3D dacxx6x_read_raw
Trailing comma here
> +};
> +
> +static int dacxx6x_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct dacxx6x_state *st;
> +	const struct dacxx6x_chip_info *info;
> +	int ret;
Sort these in a reverse christmas tree order.
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->spi =3D spi;
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	st->loaddacs =3D devm_gpiod_get_optional(&spi->dev, "ti,loaddacs",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPIOD_OUT_LOW);
Vendor prefixes are not needed here.
> +	if (IS_ERR(st->loaddacs))
> +		return PTR_ERR(st->loaddacs);
> +
> +	st->internal_ref =3D
> +		device_property_read_bool(&spi->dev, "ti,internal-ref");
> +
> +	if (!st->internal_ref) {
> +		st->vref =3D devm_regulator_get(&spi->dev, "vref");
> +		if (IS_ERR(st->vref))
> +			return PTR_ERR(st->vref);
Maybe use return dev_err_probe?
> +
> +		ret =3D regulator_enable(st->vref);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	mutex_init(&st->lock);
use devm_mutex_init.
> +
> +	if (st->internal_ref) {
> +		st->vref_uv =3D 2500000; /* 2.5V internal reference */
A note on where this value came from or why this was chosen, or a reference=
 to datasheet would be better.
> +	} else {
> +		st->vref_uv =3D regulator_get_voltage(st->vref);
> +		if (st->vref_uv < 0) {
> +			ret =3D st->vref_uv;
> +			goto err;
> +		}
> +	}
> +
You have a CMD_SOFT_RST defined but not used. Should this be used to reset =
before doing any configuration?
> +	gpiod_set_value(st->loaddacs, 0);
> +
> +	ret =3D dacxx6x_write_reg(st, CMD_LDAC_MODE, 0,
> +				FIELD_PREP(LDAC_MODE_CHANNEL_A_MASK, LDAC_MODE_INACTIVE) |
> +				FIELD_PREP(LDAC_MODE_CHANNEL_B_MASK, LDAC_MODE_INACTIVE));
> +
> +	if (ret < 0)
> +		goto err;
> +
> +	ret =3D dacxx6x_write_reg(st, CMD_SEL_REFERENCE, 0,
> +				FIELD_PREP(VOLTAGE_REFERENCE_MASK, st->internal_ref));
> +
> +	if (ret < 0)
> +		goto err;
> +
> +	info =3D spi_get_device_match_data(spi);
> +
> +	indio_dev->name =3D info->name;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &dacxx6x_iio_info;
> +	indio_dev->channels =3D info->channels;
> +	indio_dev->num_channels =3D 2;
use ARRAY_SIZE(info->channels) and include linux/array_size.h
> +
> +	ret =3D iio_device_register(indio_dev);
Use devm_iio_device_register
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	if (!st->internal_ref)
> +		regulator_disable(st->vref);
> +	mutex_destroy(&st->lock);
> +	return ret;
> +}
> +
> +static void dacxx6x_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> +	struct dacxx6x_state *st =3D iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
Using devm would help here too. No need to unregister manually
> +	mutex_destroy(&st->lock);
> +	if (!st->internal_ref)
> +		regulator_disable(st->vref);
> +}
> +
> +#define DACXX6X_COMPATIBLE(of_compatible, id)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
> +	{=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +		.compatible =3D of_compatible,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> +		.data =3D &dacxx6x_chip_info_table[id] \
> +	}
> +
> +static const struct of_device_id dacxx6x_of_match[] =3D {
> +	DACXX6X_COMPATIBLE("ti,dac7562", ID_DAC7562),
> +	DACXX6X_COMPATIBLE("ti,dac7563", ID_DAC7563),
> +	DACXX6X_COMPATIBLE("ti,dac8162", ID_DAC8162),
> +	DACXX6X_COMPATIBLE("ti,dac8163", ID_DAC8163),
> +	DACXX6X_COMPATIBLE("ti,dac8562", ID_DAC8562),
> +	DACXX6X_COMPATIBLE("ti,dac8563", ID_DAC8563),
> +	{}
{} should have a space "{ }"
> +};
> +MODULE_DEVICE_TABLE(of, dacxx6x_of_match);
> +
> +static const struct spi_device_id dacxx6x_id_table[] =3D {
> +	{ "dac7562", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC7562] },
> +	{ "dac7563", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC7563] },
> +	{ "dac8162", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8162] },
> +	{ "dac8163", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8163] },
> +	{ "dac8562", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8562] },
> +	{ "dac8563", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8563] },
> +	{}
Same here
> +};
> +
> +MODULE_DEVICE_TABLE(spi, dacxx6x_id_table);
> +
> +static struct spi_driver dacxx6x_driver =3D {
> +	.driver =3D {
> +		.name =3D "ti-dacxx6x",
Name doesn't need vendor prefix.
> +		.of_match_table =3D dacxx6x_of_match,
> +	},
> +	.probe =3D dacxx6x_probe,
> +	.remove =3D dacxx6x_remove,
> +	.id_table =3D dacxx6x_id_table,
> +};
> +
No space here.=20
> +module_spi_driver(dacxx6x_driver);
> +
> +MODULE_AUTHOR("Lukas Metz <lukas.metz@gmx.net>");
> +MODULE_DESCRIPTION("Texas Instruments 12/14/16-bit 2-channel DAC driver"=
);
> +MODULE_LICENSE("GPL");

Thanks
Sirat
