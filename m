Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78A0377003
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526308; cv=none; b=dyWqOU99AH0zzvwLL48UNf35qA2vVMPbM5nEnzsnNt7MlAvDRUxyg5Q1Dhotitq2YCroB4On+4jHOQ6QGYwCwjg8PEzIYBjb4w/f26m1kNwrrIIycePvretMNsG2U1q37jDy679PDCuhumMkT8sVvTxOvCbOK2SZs48cTkTZX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526308; c=relaxed/simple;
	bh=NRBHkdHf8U1o3Vm1YFi5bW5NylV874hTQJBEJFXVcUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y0OEmQcbEvawHbOjfaSbgV8mVLcYWt1zRA9CHb9EfR2WWipBxKhoSa3Q5BqkCK7AVGal5zI001eVTCKb499O5nkLpQ5TJLOEduyyrxxbR1WDBDb6ZnfT7E5x7o3pEnimbgC6mKWwhJTDA8Ndjq/xx5GeuGx7qyvJM5Wy/SVjN1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ukke5BSy; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ukke5BSy"
Message-ID: <e84c4e047e104cca9b88dda791997ceecba1204c.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783526304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcCCOzvDbV98M3F8rlVkTHld5hCbvC21pR1I6zAcNZ8=;
	b=Ukke5BSykD7WieqMgrsaJSYGpONxqjQmGqH7zvEXmCZVW9q3PuvU1WOt5Ucno+CeZ5zY4e
	Aw25yA11bvZn77hCrogwHy4IKdY414P/Hhv/1wi/5iiss2rIUTy2xm/PS4QKkMO5T6Y90l
	G1aueunYlVJTF7R+JhnLs0WeBKZAKq4=
Subject: Re: [PATCH v2 2/2] iio: dac: dac8163: Add driver for DAC8163
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Lukas Metz <lukas.metz@gmx.net>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, 	devicetree@vger.kernel.org
Date: Wed, 08 Jul 2026 21:58:13 +0600
In-Reply-To: <20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
	 <20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Wed, 2026-07-08 at 11:52 +0200, Lukas Metz wrote:
> The DAC756x, DAC816x, and DAC856x devices are low-power, voltage-output,
> dual-channel, 12-, 14-, and 16-bit digital-to-analog converters (DACs),
> respectively. These devices include a 2.5-V, 4-ppm/=C2=B0C internal
> reference, giving a full-scale output voltage range of 2.5 V or 5 V.
> =C2=A0
> =C2=A0	=C2=A0 If compiled as a module, it will be called ti-dac7612.
> =C2=A0
> +config TI_DAC8163
> +	tristate "Texas Instruments 12/14/16-bit 2-channel DAC driver"
> +	depends on SPI_MASTER
Missing "select REGMAP_SPI" here.
> +	help
> +	=C2=A0 Driver for the Texas Instruments digital-to-analog converter
> +	=C2=A0 family dacxx6x compatible with the following variants
> +	=C2=A0 - DAC7562 (2 channels, 12 bits, resets to zero)
> +	=C2=A0 - DAC7563 (2 channels, 12 bits, resets to mid-scale)
>=20
>=20
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * DAC8163 IIO driver (SPI)
> + * https://www.ti.com/de/lit/gpn/dac8163
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
I asked you to add this "mod_devicetable.h" header previously. But I notice=
d some reviews by Uwe=C2=A0
to use more specific headers.=C2=A0
In your case these should be=C2=A0


#include <linux/device-id/spi.h>
#include <linux/device-id/of.h>

unless I'm missing something.

> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/stddef.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define COMMAND_MASK GENMASK(6, 3)
> +#define ADDRESS_MASK GENMASK(2, 0)
> +
> +#define CMD_SET(x, y) \
> +	(FIELD_PREP(COMMAND_MASK, (x)) | FIELD_PREP(ADDRESS_MASK, (y)))
> +
> +#define CMD_WRITE_INPUT_REG	0x0
> +#define CMD_UPDATE_DAC		0x1
> +#define CMD_WRITE_UPDATE_ALL	0x2
> +#define CMD_WRITE_UPDATE	0x3
> +#define CMD_POWER_MODE		0x4
> +#define CMD_SOFT_RST		0x5
> +#define CMD_LDAC_MODE		0x6
> +#define CMD_REF			0x7
> +
> +#define LDAC_CHANNEL_A_MASK BIT(0)
> +#define LDAC_CHANNEL_B_MASK BIT(1)
> +#define VREF_MASK BIT(0)
Since the MASKs are defined together, align the values.

+#define LDAC_CHANNEL_A_MASK	BIT(0)
+#define LDAC_CHANNEL_B_MASK	BIT(1)
+#define VREF_MASK		BIT(0)

> +
> +#define DAC8163_INTERNAL_REF_mV 2500
> +
...
> +
> +#define DAC8163_MID_SCALE(resolution) \
> +	(BIT((resolution) - 1) << (16 - (resolution)))
> +
> +static const struct dac8163_chip_info dac7562_chip_info =3D {
> +	.name =3D "dac7562",
> +	.channels =3D {
> +		DAC8163_CHAN(0, 12),
> +		DAC8163_CHAN(1, 12),
> +	},
> +	.default_output_reg =3D 0,
> +};
> +
> +static const struct dac8163_chip_info dac7563_chip_info =3D {
> +	.name =3D "dac7563",
> +	.channels =3D {
> +		DAC8163_CHAN(0, 12),
> +		DAC8163_CHAN(1, 12),
> +	},
> +	.default_output_reg =3D DAC8163_MID_SCALE(12),
These resolution values are repeated multiple times. I think they could be =
defined as something like
#define DAC8163_RES_12_BIT	12 // 14, 16

> +};
> +
> +static const struct dac8163_chip_info dac8162_chip_info =3D {
> +	.name =3D "dac8162",
> +	.channels =3D {
> +		DAC8163_CHAN(0, 14),
> +		DAC8163_CHAN(1, 14),
> +	},
> +	.default_output_reg =3D 0,
> +};
> +
> +static const struct dac8163_chip_info dac8163_chip_info =3D {
> +	.name =3D "dac8163",
> +	.channels =3D {
> +		DAC8163_CHAN(0, 14),
> +		DAC8163_CHAN(1, 14),
> +	},
> +	.default_output_reg =3D DAC8163_MID_SCALE(14),
> +};
> +
> +static const struct dac8163_chip_info dac8562_chip_info =3D {
> +	.name =3D "dac8562",
> +	.channels =3D {
> +		DAC8163_CHAN(0, 16),
> +		DAC8163_CHAN(1, 16),
> +	},
> +	.default_output_reg =3D 0,
> +};
> +
> +static const struct dac8163_chip_info dac8563_chip_info =3D {
> +	.name =3D "dac8563",
> +	.channels =3D {
> +		DAC8163_CHAN(0, 16),
> +		DAC8163_CHAN(1, 16),
> +	},
> +	.default_output_reg =3D DAC8163_MID_SCALE(16),
> +};
> +
> +static int dac8163_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *val,
> +			=C2=A0=C2=A0=C2=A0 int *val2, long mask)
Put val on the same line as val2. i.e.,
+static int dac8163_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)

> +{
>=20
...
> +
> +static const struct iio_info dac8163_iio_info =3D {
> +	.write_raw =3D dac8163_write_raw,
> +	.read_raw =3D dac8163_read_raw
Missing trailing comma here.
> +};
> +
> +static bool dac8163_reg_false(struct device *dev, unsigned int ref)
> +{
> +	return false;
> +}
> +
> +static int dac8163_probe(struct spi_device *spi)
> +{
>=20
...
> +
> +	const struct reg_default reg_defaults[] =3D {
> +		{
> +			.reg =3D CMD_SET(CMD_WRITE_UPDATE, 0),
> +			.def =3D info->default_output_reg,
> +		},
> +		{
> +			.reg =3D CMD_SET(CMD_WRITE_UPDATE, 1),
> +			.def =3D info->default_output_reg,
> +		},
> +	};
> +
> +	const struct regmap_config regmap_config =3D {
> +		.reg_bits =3D 8,
> +		.val_bits =3D 16,
> +
> +		.max_register =3D CMD_REF << 3,
> +		.cache_type =3D REGCACHE_MAPLE,
> +
> +		.volatile_reg =3D dac8163_reg_false,
> +
> +		.reg_defaults =3D reg_defaults,
> +		.num_reg_defaults =3D ARRAY_SIZE(reg_defaults),
> +	};
Why are these defined inside probe? Should be defined outside the function.
> +
> +	st->regmap =3D devm_regmap_init_spi(spi, &regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
Use "dev_err_probe"
return dev_err_probe(dev, PTR_ERR(st->regmap),
				     "regmap initialization failed\n");
> +
> +	// for now we keep the ldac pin asserted permanently so that the output
> +	// is updated immediately after a write to the channels raw attribute
> +	ldac_gpio =3D devm_gpiod_get_optional(&spi->dev, "ldac",
> +
...
>=20
> +
> +static const struct spi_device_id dac8163_id_table[] =3D {
> +	{
> +		.name =3D "dac7562",
> +		.driver_data =3D (kernel_ulong_t)&dac7562_chip_info
Missing trailing commas here too, this and the ones below.
> +	},
> +	{
> +		.name =3D "dac7563",
> +		.driver_data =3D (kernel_ulong_t)&dac7563_chip_info
> +	},
> +	{
> +		.name =3D "dac8162",
> +		.driver_data =3D (kernel_ulong_t)&dac8162_chip_info
> +	},
> +	{
> +		.name =3D "dac8163",
> +		.driver_data =3D (kernel_ulong_t)&dac8163_chip_info
> +	},
> +	{
> +		.name =3D "dac8562",
> +		.driver_data =3D (kernel_ulong_t)&dac8562_chip_info
> +	},
> +	{
> +		.name =3D "dac8563",
> +		.driver_data =3D (kernel_ulong_t)&dac8563_chip_info
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, dac8163_id_table);
> +
> +static struct spi_driver dac8163_driver =3D {
> +	.driver =3D {
> +		.name =3D "dac8163",
> +		.of_match_table =3D dac8163_of_match,
> +	},
> +	.probe =3D dac8163_probe,
> +	.id_table =3D dac8163_id_table,
> +};
> +module_spi_driver(dac8163_driver);
> +
> +MODULE_AUTHOR("Lukas Metz <lukas.metz@gmx.net>");
> +MODULE_DESCRIPTION("Texas Instruments 12/14/16-bit 2-channel DAC driver"=
);
> +MODULE_LICENSE("GPL");

--
Best regards,
Sirat
