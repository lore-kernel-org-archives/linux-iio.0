Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB103403EB;
	Wed,  8 Jul 2026 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504399; cv=none; b=qMCY9jiU1gJiHhY5+fQQReI5bUDH9VqgVbR0AF33wpQ/+V7Cd9cqm40RoXgb4xOk8iyzs/tWfk+B0lut6pKob9IMdC+iIGEFt5+HIEXR4xXMBCcwAX6hxQlZCrRGYDbebrxSc7rfOpti3RmbQeew76Py3uooUSCKSqIQuEaD8Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504399; c=relaxed/simple;
	bh=Pb1+/jeHfYSyX7wqCpCccPt4eN9NUNsKvrVGf33ZD+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BhmDxicGCfUMzCfur9cKwGmhQXuGsALEUuxNQCRVKTd2hrrOUaG/i1OVC3LwDLKoP5ssCmB9mwZV0IAo3Jv9JcxOFpb1dGtW7/iTwFfk/wKVsDynvJGAey+DdtRfZgCZ/s8TwO6A++Dmn7qcyRbhrGFzkOZdnaJ0fzbPWFeFVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=oTftV+ts; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="oTftV+ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1783504388; x=1784109188; i=lukas.metz@gmx.net;
	bh=zlJ6gZtcHE78uHXdS+sdeVveBkhujP1/82HXfh0iyCE=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oTftV+tsuq+OyLx7HGPLoychjSVH6hX3NyG25SsCd7XU/XH5okYVMpCds3O9ZOtm
	 uwiUPDYpgUQdsVPrPaJdSHBZqvGhhw27zQIlG1k6EI8HwDqcKAtZ0Xjj7KQne1cSE
	 1vihEnlPYZB/5+z8rW3usdSY0HPzv9JdLzfKlkUm4ofdzdOTsk4aNxKrq5SpcAhPP
	 2PKjPN22HPy1j46FCo7S4AgOHo18F4mSJ1O7ds1mBuV/K5ZjScoOtvllQpOVNassG
	 qBZyms6gip5qQkgVUL97pdqMiBQi/pQcmcR6HHPj9nIk/tkneZWWsTEG8RsxbJRju
	 yUEpqlqGp5IFAwj0Tg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRVh-1wabV23AE7-00IkKc; Wed, 08
 Jul 2026 11:53:07 +0200
From: Lukas Metz <lukas.metz@gmx.net>
Date: Wed, 08 Jul 2026 11:52:44 +0200
Subject: [PATCH v2 2/2] iio: dac: dac8163: Add driver for DAC8163
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
In-Reply-To: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Lukas Metz <lukas.metz@gmx.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783504386; l=11722;
 i=lukas.metz@gmx.net; s=20260616; h=from:subject:message-id;
 bh=zeCTRrFcnPY1I0H6pgkY9MHxA32oAoOjMlY5ZkZE+Nc=;
 b=nJQ69llQLcLX9H1qqa0W0HV3duBiQGvgMjzA1fK+ouLNHyQn4IfPqpHUtMgrIIGRtdkOaNeDg
 3jO0lgsGB1gADRegvT948QtbFX0xSsj7KGr9XjSWLxh3s12mAjOElrA
X-Developer-Key: i=lukas.metz@gmx.net; a=ed25519;
 pk=ljkIqYPVyHd9CYN4/koqGKt7Mym5FTTB+ZzvvlfD4yM=
X-Provags-ID: V03:K1:pNxwkd20exTlydprgngTwETOHgbxa6J5jme7coaYUYB98jxHBkI
 3VnOJOP9+SnkitaTzypCcxr5tAAx8bv7PYXOTjqMI622eodhkXjaCrx0RMkNeVNU8RH9ogq
 m7ZtFuOBtNmu+ygwG1cEAH3Ib10hyzhPQsvc3HmugSk5GEiZ+q86F5sdk+5CEdrP3Bxhd3x
 XGEVQatd+kHYETsLhBO/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N15kBw65C5g=;304D1Uf5drrweS5k3kCqVoteJgl
 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
 mOK8Byp72JmnUXjl9Xpl4cSaYN2cwvQYNdjjkFm

The DAC756x, DAC816x, and DAC856x devices are low-power, voltage-output,
dual-channel, 12-, 14-, and 16-bit digital-to-analog converters (DACs),
respectively. These devices include a 2.5-V, 4-ppm/=C2=B0C internal
reference, giving a full-scale output voltage range of 2.5 V or 5 V.

Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
=2D--
 MAINTAINERS                  |   1 +
 drivers/iio/dac/Kconfig      |  15 ++
 drivers/iio/dac/Makefile     |   1 +
 drivers/iio/dac/ti-dac8163.c | 373 ++++++++++++++++++++++++++++++++++++++=
+++++
 4 files changed, 390 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 314f235332f5..5512f5eaab44 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26399,6 +26399,7 @@ M:	Lukas Metz <lukas.metz@gmx.net>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
+F:	drivers/iio/dac/ti-dac8163.c
=20
 TI DATA TRANSFORM AND HASHING ENGINE (DTHE) V2 CRYPTO DRIVER
 M:	T Pratham <t-pratham@ti.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index db9f5c711b3d..de3b8fa5ffbf 100644
=2D-- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -632,6 +632,21 @@ config TI_DAC7612
=20
 	  If compiled as a module, it will be called ti-dac7612.
=20
+config TI_DAC8163
+	tristate "Texas Instruments 12/14/16-bit 2-channel DAC driver"
+	depends on SPI_MASTER
+	help
+	  Driver for the Texas Instruments digital-to-analog converter
+	  family dacxx6x compatible with the following variants
+	  - DAC7562 (2 channels, 12 bits, resets to zero)
+	  - DAC7563 (2 channels, 12 bits, resets to mid-scale)
+	  - DAC8162 (2 channels, 14 bits, resets to zero)
+	  - DAC8163 (2 channels, 14 bits, resets to mid-scale)
+	  - DAC8562 (2 channels, 16 bits, resets to zero)
+	  - DAC8563 (2 channels, 16 bits, resets to mid-scale)
+
+	  If compiled as a module, it will be called ti-dac8163.
+
 config VF610_DAC
 	tristate "Vybrid vf610 DAC driver"
 	depends on HAS_IOMEM
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 2a80bbf4e80a..359cde446623 100644
=2D-- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -62,4 +62,5 @@ obj-$(CONFIG_TI_DAC082S085) +=3D ti-dac082s085.o
 obj-$(CONFIG_TI_DAC5571) +=3D ti-dac5571.o
 obj-$(CONFIG_TI_DAC7311) +=3D ti-dac7311.o
 obj-$(CONFIG_TI_DAC7612) +=3D ti-dac7612.o
+obj-$(CONFIG_TI_DAC8163) +=3D ti-dac8163.o
 obj-$(CONFIG_VF610_DAC) +=3D vf610_dac.o
diff --git a/drivers/iio/dac/ti-dac8163.c b/drivers/iio/dac/ti-dac8163.c
new file mode 100644
index 000000000000..6be0aac2e875
=2D-- /dev/null
+++ b/drivers/iio/dac/ti-dac8163.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DAC8163 IIO driver (SPI)
+ * https://www.ti.com/de/lit/gpn/dac8163
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+
+#define COMMAND_MASK GENMASK(6, 3)
+#define ADDRESS_MASK GENMASK(2, 0)
+
+#define CMD_SET(x, y) \
+	(FIELD_PREP(COMMAND_MASK, (x)) | FIELD_PREP(ADDRESS_MASK, (y)))
+
+#define CMD_WRITE_INPUT_REG	0x0
+#define CMD_UPDATE_DAC		0x1
+#define CMD_WRITE_UPDATE_ALL	0x2
+#define CMD_WRITE_UPDATE	0x3
+#define CMD_POWER_MODE		0x4
+#define CMD_SOFT_RST		0x5
+#define CMD_LDAC_MODE		0x6
+#define CMD_REF			0x7
+
+#define LDAC_CHANNEL_A_MASK BIT(0)
+#define LDAC_CHANNEL_B_MASK BIT(1)
+#define VREF_MASK BIT(0)
+
+#define DAC8163_INTERNAL_REF_mV 2500
+
+enum dac8163_reset_types {
+	OUTPUT_ONLY_RESET =3D 0,
+	FULL_RESET =3D 1,
+};
+
+enum dac8163_ldac_modes {
+	LDAC_ACTIVE =3D 0,
+	LDAC_INACTIVE =3D 1,
+};
+
+enum dac8163_voltage_reference {
+	VREF_EXTERNAL =3D 0,
+	VREF_INTERNAL =3D 1,
+};
+
+struct dac8163_state {
+	struct regmap *regmap;
+	struct regulator *vref;
+
+	int vref_mV;
+	int gain;
+};
+
+struct dac8163_chip_info {
+	const char *name;
+	const struct iio_chan_spec channels[2];
+	u16 default_output_reg;
+};
+
+#define DAC8163_CHAN(id, resolution)					\
+	{								\
+		.type =3D IIO_VOLTAGE,					\
+		.channel =3D (id),					\
+		.output =3D 1,						\
+		.indexed =3D 1,						\
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	\
+		.scan_type =3D {						\
+			.realbits =3D (resolution),			\
+			.shift =3D 16 - (resolution)			\
+		},							\
+	}
+
+#define DAC8163_MID_SCALE(resolution) \
+	(BIT((resolution) - 1) << (16 - (resolution)))
+
+static const struct dac8163_chip_info dac7562_chip_info =3D {
+	.name =3D "dac7562",
+	.channels =3D {
+		DAC8163_CHAN(0, 12),
+		DAC8163_CHAN(1, 12),
+	},
+	.default_output_reg =3D 0,
+};
+
+static const struct dac8163_chip_info dac7563_chip_info =3D {
+	.name =3D "dac7563",
+	.channels =3D {
+		DAC8163_CHAN(0, 12),
+		DAC8163_CHAN(1, 12),
+	},
+	.default_output_reg =3D DAC8163_MID_SCALE(12),
+};
+
+static const struct dac8163_chip_info dac8162_chip_info =3D {
+	.name =3D "dac8162",
+	.channels =3D {
+		DAC8163_CHAN(0, 14),
+		DAC8163_CHAN(1, 14),
+	},
+	.default_output_reg =3D 0,
+};
+
+static const struct dac8163_chip_info dac8163_chip_info =3D {
+	.name =3D "dac8163",
+	.channels =3D {
+		DAC8163_CHAN(0, 14),
+		DAC8163_CHAN(1, 14),
+	},
+	.default_output_reg =3D DAC8163_MID_SCALE(14),
+};
+
+static const struct dac8163_chip_info dac8562_chip_info =3D {
+	.name =3D "dac8562",
+	.channels =3D {
+		DAC8163_CHAN(0, 16),
+		DAC8163_CHAN(1, 16),
+	},
+	.default_output_reg =3D 0,
+};
+
+static const struct dac8163_chip_info dac8563_chip_info =3D {
+	.name =3D "dac8563",
+	.channels =3D {
+		DAC8163_CHAN(0, 16),
+		DAC8163_CHAN(1, 16),
+	},
+	.default_output_reg =3D DAC8163_MID_SCALE(16),
+};
+
+static int dac8163_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct dac8163_state *st =3D iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret =3D regmap_read(st->regmap,
+				  CMD_SET(CMD_WRITE_UPDATE, chan->channel),
+				  val);
+		if (ret)
+			return ret;
+		*val >>=3D chan->scan_type.shift;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val =3D st->vref_mV * st->gain;
+		*val2 =3D chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int dac8163_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct dac8163_state *st =3D iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val2 !=3D 0)
+			return -EINVAL;
+
+		if (val < 0 || val >=3D BIT(chan->scan_type.realbits))
+			return -ERANGE;
+
+		return regmap_write(st->regmap,
+				    CMD_SET(CMD_WRITE_UPDATE, chan->channel),
+				    (u16)val << chan->scan_type.shift);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info dac8163_iio_info =3D {
+	.write_raw =3D dac8163_write_raw,
+	.read_raw =3D dac8163_read_raw
+};
+
+static bool dac8163_reg_false(struct device *dev, unsigned int ref)
+{
+	return false;
+}
+
+static int dac8163_probe(struct spi_device *spi)
+{
+	const struct dac8163_chip_info *info;
+	struct gpio_desc *ldac_gpio;
+	struct iio_dev *indio_dev;
+	struct dac8163_state *st;
+	bool internal_reference;
+	int ret;
+
+	info =3D spi_get_device_match_data(spi);
+	if (!info)
+		return -ENODEV;
+
+	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st =3D iio_priv(indio_dev);
+
+	indio_dev->name =3D info->name;
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->info =3D &dac8163_iio_info;
+	indio_dev->channels =3D info->channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(info->channels);
+
+	const struct reg_default reg_defaults[] =3D {
+		{
+			.reg =3D CMD_SET(CMD_WRITE_UPDATE, 0),
+			.def =3D info->default_output_reg,
+		},
+		{
+			.reg =3D CMD_SET(CMD_WRITE_UPDATE, 1),
+			.def =3D info->default_output_reg,
+		},
+	};
+
+	const struct regmap_config regmap_config =3D {
+		.reg_bits =3D 8,
+		.val_bits =3D 16,
+
+		.max_register =3D CMD_REF << 3,
+		.cache_type =3D REGCACHE_MAPLE,
+
+		.volatile_reg =3D dac8163_reg_false,
+
+		.reg_defaults =3D reg_defaults,
+		.num_reg_defaults =3D ARRAY_SIZE(reg_defaults),
+	};
+
+	st->regmap =3D devm_regmap_init_spi(spi, &regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	// for now we keep the ldac pin asserted permanently so that the output
+	// is updated immediately after a write to the channels raw attribute
+	ldac_gpio =3D devm_gpiod_get_optional(&spi->dev, "ldac",
+					    GPIOD_OUT_HIGH);
+	if (IS_ERR(ldac_gpio))
+		return PTR_ERR(ldac_gpio);
+
+	if (device_property_present(&spi->dev, "vrefin-supply")) {
+		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev,
+							     "vrefin");
+		if (ret < 0)
+			return ret;
+
+		st->vref_mV =3D ret / (MICRO / MILLI);
+		internal_reference =3D false;
+		st->gain =3D 1;
+	} else {
+		st->vref_mV =3D DAC8163_INTERNAL_REF_mV;
+		internal_reference =3D true;
+		st->gain =3D 2;
+	}
+
+	ret =3D devm_regulator_get_enable(&spi->dev, "avdd");
+	if (ret < 0)
+		return ret;
+
+	ret =3D regmap_write(st->regmap, FIELD_PREP(COMMAND_MASK, CMD_SOFT_RST),
+			   FULL_RESET);
+
+	if (ret < 0)
+		return ret;
+
+	ret =3D regmap_write(st->regmap, FIELD_PREP(COMMAND_MASK, CMD_LDAC_MODE)=
,
+			   FIELD_PREP(LDAC_CHANNEL_A_MASK, LDAC_INACTIVE) |
+			   FIELD_PREP(LDAC_CHANNEL_B_MASK, LDAC_INACTIVE));
+	if (ret < 0)
+		return ret;
+
+	ret =3D regmap_write(st->regmap, FIELD_PREP(COMMAND_MASK, CMD_REF),
+			   FIELD_PREP(VREF_MASK, internal_reference));
+	if (ret < 0)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id dac8163_of_match[] =3D {
+	{
+		.compatible =3D "ti,dac7562",
+		.data =3D &dac7562_chip_info,
+	},
+	{
+		.compatible =3D "ti,dac7563",
+		.data =3D &dac7563_chip_info,
+	},
+	{
+		.compatible =3D "ti,dac8162",
+		.data =3D &dac8162_chip_info,
+	},
+	{
+		.compatible =3D "ti,dac8163",
+		.data =3D &dac8163_chip_info,
+	},
+	{
+		.compatible =3D "ti,dac8562",
+		.data =3D &dac8562_chip_info,
+	},
+	{
+		.compatible =3D "ti,dac8563",
+		.data =3D &dac8563_chip_info,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dac8163_of_match);
+
+static const struct spi_device_id dac8163_id_table[] =3D {
+	{
+		.name =3D "dac7562",
+		.driver_data =3D (kernel_ulong_t)&dac7562_chip_info
+	},
+	{
+		.name =3D "dac7563",
+		.driver_data =3D (kernel_ulong_t)&dac7563_chip_info
+	},
+	{
+		.name =3D "dac8162",
+		.driver_data =3D (kernel_ulong_t)&dac8162_chip_info
+	},
+	{
+		.name =3D "dac8163",
+		.driver_data =3D (kernel_ulong_t)&dac8163_chip_info
+	},
+	{
+		.name =3D "dac8562",
+		.driver_data =3D (kernel_ulong_t)&dac8562_chip_info
+	},
+	{
+		.name =3D "dac8563",
+		.driver_data =3D (kernel_ulong_t)&dac8563_chip_info
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, dac8163_id_table);
+
+static struct spi_driver dac8163_driver =3D {
+	.driver =3D {
+		.name =3D "dac8163",
+		.of_match_table =3D dac8163_of_match,
+	},
+	.probe =3D dac8163_probe,
+	.id_table =3D dac8163_id_table,
+};
+module_spi_driver(dac8163_driver);
+
+MODULE_AUTHOR("Lukas Metz <lukas.metz@gmx.net>");
+MODULE_DESCRIPTION("Texas Instruments 12/14/16-bit 2-channel DAC driver")=
;
+MODULE_LICENSE("GPL");

=2D-=20
2.43.0

