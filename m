Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E6823507C;
	Sun,  2 Aug 2026 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686917; cv=none; b=Ylx8xbP/6VRwjj3xN6AOiEfi0A28A6MHdLPDJmt+PLsSgnNU/tZkJ9SdMcSbZMgxRN8VpHZYCjvLOPI3n2GCQNnUCyH67LlfbzSZg599XWi5LOwOojwpm0f7SYHcMHddNLKhoQco+mWFuZX7dXNT55Fgpkm5xbMHXpHTOYAMWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686917; c=relaxed/simple;
	bh=ikDhLglD9y0BofkdhVBatspgS+rgvLy39uePwwZfwEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nl+a5kBfjhGM72ZfwMvYElyo75F0Q82A2j9ngb2nBSK7a5+FeksZK5VI7r2XbWTmerINmMHPjmnJ/ZWA2Euupdf1XYwUmWWqznM1+TcABAV6LqIlkPgYIkGoX7F03LAcWkH988TXWCTnI0tk8ZQ+Npnwlq1btIs1loTZvOa+hZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=fS2mP2nC; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="fS2mP2nC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1785686907; x=1786291707; i=lukas.metz@gmx.net;
	bh=gvnTEucdMdrsL8VBBXI4yRThtDRbEI80/HxgEcG/jJw=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fS2mP2nCWJAHgRWyjvJVgV0wSqtxhtXZSvhXGcDZ/29ZPhP0HOwYh+a4X5z/zwKL
	 aNchkOf4zhAibe3DE81hL1ILudR5LfKLOxeMCVrB3xUf4Ka9saQjNRa6tdQkNfjMZ
	 tT8USuGfRxQbiwDeae87rNeyZl8RKbTTceeDH42gUJKWJb7fk7ZEf/4iTUIxRs429
	 PS/LsccUgLcRmkuR5Ugho1ykB08hgUP99FyTdQMC1TJr38QEXWzn0p/kxdDwIkI3j
	 MhIL3MjdpP78G0qatrviXu/Bdlolg1vQQF1m6bjgs8mNYyHuVW7i3lXebQ/lKHj3Y
	 9SXT7tzbSqCQOk16vA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDJX-1xHLUa1I6B-00nv5w; Sun, 02
 Aug 2026 18:08:27 +0200
From: Lukas Metz <lukas.metz@gmx.net>
Date: Sun, 02 Aug 2026 18:07:23 +0200
Subject: [PATCH v3 2/2] iio: dac: dac8163: Add driver for DAC8163
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260802-dac8163-work-v3-2-3ecc7bc66d0d@gmx.net>
References: <20260802-dac8163-work-v3-0-3ecc7bc66d0d@gmx.net>
In-Reply-To: <20260802-dac8163-work-v3-0-3ecc7bc66d0d@gmx.net>
To: Jonathan Cameron <jic23@kernel.org>, 
 Siratul Islam <siratul.islam@linux.dev>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Lukas Metz <lukas.metz@gmx.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785686905; l=14699;
 i=lukas.metz@gmx.net; s=20260616; h=from:subject:message-id;
 bh=XPgScvxSFfzpU1Focp0m4mLGVrDv0nyqipeFqDh1jBA=;
 b=uQYTXLFRPGAZi2v6n2IRB00cBaGF7L6yaL7Tm0IfH3gAN6zdCaMPh1QfCx3HmxEUGrIQnVrrq
 ksAYdATEHrnD+6qoWm/FI4sM7BmrYXfvmobSGGqMZCIkyfmhmgYpb3q
X-Developer-Key: i=lukas.metz@gmx.net; a=ed25519;
 pk=ljkIqYPVyHd9CYN4/koqGKt7Mym5FTTB+ZzvvlfD4yM=
X-Provags-ID: V03:K1:4pbDxWi/WueDwND0HYZXzsvvlkw3vcBEtOV5UxRlGWysuNV20yA
 4yTBeirx8IcSCLEkDsJw3DO/I4QN/6r9pzEwMhR5SP4rBIOpaQ61sqC7XHcoo1BYPusjy6/
 h/jG6wlUFoTRIQTLprwsyVCopuyPJg+hXYW5lNm68tb/+9CQr5KPYXi9IjRFWCvxd6STGUf
 w8Qsh7l+nq5BLheC/Bpcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zdP0cv8N/Og=;bcckN/IQt8Nk2xN25iGA0CQX4HF
 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

The DAC756x, DAC816x, and DAC856x devices are low-power, voltage-output,
dual-channel, 12-, 14-, and 16-bit digital-to-analog converters (DACs),
respectively. These devices include a 2.5-V, 4-ppm/=C2=B0C internal
reference, giving a full-scale output voltage range of 2.5 V or 5 V.

Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
=2D--
 MAINTAINERS                  |   1 +
 drivers/iio/dac/Kconfig      |  16 ++
 drivers/iio/dac/Makefile     |   1 +
 drivers/iio/dac/ti-dac8163.c | 449 ++++++++++++++++++++++++++++++++++++++=
+++++
 4 files changed, 467 insertions(+)

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
index db9f5c711b3d..aa80b871995b 100644
=2D-- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -632,6 +632,22 @@ config TI_DAC7612
=20
 	  If compiled as a module, it will be called ti-dac7612.
=20
+config TI_DAC8163
+	tristate "Texas Instruments 12/14/16-bit 2-channel DAC driver"
+	depends on SPI_MASTER
+	select REGMAP_SPI
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
index 000000000000..35af7828dc22
=2D-- /dev/null
+++ b/drivers/iio/dac/ti-dac8163.c
@@ -0,0 +1,449 @@
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
+#include <linux/gpio/consumer.h>
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
+#define VREF_MASK	    BIT(0)
+
+#define DAC8163_INTERNAL_REF_mV 2500
+#define DAC8163_RES_12_BIT	12
+#define DAC8163_RES_14_BIT	14
+#define DAC8163_RES_16_BIT	16
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
+	const struct regmap_config regmap_config;
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
+			.shift =3D 16 - (resolution),			\
+		},							\
+	}
+
+#define DAC8163_MID_SCALE(resolution) \
+	(BIT((resolution) - 1) << (16 - (resolution)))
+
+static bool dac8163_reg_false(struct device *dev, unsigned int ref)
+{
+	return false;
+}
+
+static const struct reg_default dacxxx2_reg_defaults[] =3D {
+	{
+		.reg =3D FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
+		       FIELD_PREP_CONST(ADDRESS_MASK, 0),
+		.def =3D 0,
+	},
+	{
+		.reg =3D FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
+		       FIELD_PREP_CONST(ADDRESS_MASK, 1),
+		.def =3D 0,
+	},
+};
+
+static const struct regmap_config dacxxx2_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 16,
+	.max_register =3D CMD_REF << 3,
+	.cache_type =3D REGCACHE_MAPLE,
+	.volatile_reg =3D dac8163_reg_false,
+	.reg_defaults =3D dacxxx2_reg_defaults,
+	.num_reg_defaults =3D ARRAY_SIZE(dacxxx2_reg_defaults),
+};
+
+static const struct reg_default dac7563_reg_defaults[] =3D {
+	{
+		.reg =3D FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
+		       FIELD_PREP_CONST(ADDRESS_MASK, 0),
+		.def =3D DAC8163_MID_SCALE(12),
+	},
+	{
+		.reg =3D FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
+		       FIELD_PREP_CONST(ADDRESS_MASK, 1),
+		.def =3D DAC8163_MID_SCALE(12),
+	},
+};
+
+static const struct regmap_config dac7563_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 16,
+	.max_register =3D CMD_REF << 3,
+	.cache_type =3D REGCACHE_MAPLE,
+	.volatile_reg =3D dac8163_reg_false,
+	.reg_defaults =3D dac7563_reg_defaults,
+	.num_reg_defaults =3D ARRAY_SIZE(dac7563_reg_defaults),
+};
+
+static const struct reg_default dac8163_reg_defaults[] =3D {
+	{
+		.reg =3D FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
+		       FIELD_PREP_CONST(ADDRESS_MASK, 0),
+		.def =3D DAC8163_MID_SCALE(14),
+	},
+	{
+		.reg =3D FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
+		       FIELD_PREP_CONST(ADDRESS_MASK, 1),
+		.def =3D DAC8163_MID_SCALE(14),
+	},
+};
+
+static const struct regmap_config dac8163_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 16,
+	.max_register =3D CMD_REF << 3,
+	.cache_type =3D REGCACHE_MAPLE,
+	.volatile_reg =3D dac8163_reg_false,
+	.reg_defaults =3D dac8163_reg_defaults,
+	.num_reg_defaults =3D ARRAY_SIZE(dac8163_reg_defaults),
+};
+
+static const struct reg_default dac8563_reg_defaults[] =3D {
+	{
+		.reg =3D FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
+		       FIELD_PREP_CONST(ADDRESS_MASK, 0),
+		.def =3D DAC8163_MID_SCALE(16),
+	},
+	{
+		.reg =3D FIELD_PREP_CONST(COMMAND_MASK, CMD_WRITE_UPDATE) |
+		       FIELD_PREP_CONST(ADDRESS_MASK, 1),
+		.def =3D DAC8163_MID_SCALE(16),
+	},
+};
+
+static const struct regmap_config dac8563_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 16,
+	.max_register =3D CMD_REF << 3,
+	.cache_type =3D REGCACHE_MAPLE,
+	.volatile_reg =3D dac8163_reg_false,
+	.reg_defaults =3D dac8563_reg_defaults,
+	.num_reg_defaults =3D ARRAY_SIZE(dac8563_reg_defaults),
+};
+
+static const struct dac8163_chip_info dac7562_chip_info =3D {
+	.name =3D "dac7562",
+	.channels =3D {
+		DAC8163_CHAN(0, DAC8163_RES_12_BIT),
+		DAC8163_CHAN(1, DAC8163_RES_12_BIT),
+	},
+	.regmap_config =3D dacxxx2_regmap_config,
+};
+
+static const struct dac8163_chip_info dac7563_chip_info =3D {
+	.name =3D "dac7563",
+	.channels =3D {
+		DAC8163_CHAN(0, DAC8163_RES_12_BIT),
+		DAC8163_CHAN(1, DAC8163_RES_12_BIT),
+	},
+	.regmap_config =3D dac7563_regmap_config,
+};
+
+static const struct dac8163_chip_info dac8162_chip_info =3D {
+	.name =3D "dac8162",
+	.channels =3D {
+		DAC8163_CHAN(0, DAC8163_RES_14_BIT),
+		DAC8163_CHAN(1, DAC8163_RES_14_BIT),
+	},
+	.regmap_config =3D dacxxx2_regmap_config,
+};
+
+static const struct dac8163_chip_info dac8163_chip_info =3D {
+	.name =3D "dac8163",
+	.channels =3D {
+		DAC8163_CHAN(0, DAC8163_RES_14_BIT),
+		DAC8163_CHAN(1, DAC8163_RES_14_BIT),
+	},
+	.regmap_config =3D dac8163_regmap_config,
+};
+
+static const struct dac8163_chip_info dac8562_chip_info =3D {
+	.name =3D "dac8562",
+	.channels =3D {
+		DAC8163_CHAN(0, DAC8163_RES_16_BIT),
+		DAC8163_CHAN(1, DAC8163_RES_16_BIT),
+	},
+	.regmap_config =3D dacxxx2_regmap_config,
+};
+
+static const struct dac8163_chip_info dac8563_chip_info =3D {
+	.name =3D "dac8563",
+	.channels =3D {
+		DAC8163_CHAN(0, DAC8163_RES_16_BIT),
+		DAC8163_CHAN(1, DAC8163_RES_16_BIT),
+	},
+	.regmap_config =3D dac8563_regmap_config,
+};
+
+static int dac8163_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct dac8163_state *st =3D iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		ret =3D regmap_read(st->regmap,
+				  FIELD_PREP(COMMAND_MASK, CMD_WRITE_UPDATE) |
+				  FIELD_PREP(ADDRESS_MASK, chan->channel),
+				  val);
+		if (ret)
+			return ret;
+		*val >>=3D chan->scan_type.shift;
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SCALE: {
+		*val =3D st->vref_mV * st->gain;
+		*val2 =3D chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
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
+	case IIO_CHAN_INFO_RAW: {
+		if (val2 !=3D 0)
+			return -EINVAL;
+
+		if (val < 0 || val >=3D BIT(chan->scan_type.realbits))
+			return -ERANGE;
+
+		return regmap_write(st->regmap,
+				    FIELD_PREP(COMMAND_MASK, CMD_WRITE_UPDATE) |
+				    FIELD_PREP(ADDRESS_MASK, chan->channel),
+				    (u16)val << chan->scan_type.shift);
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info dac8163_iio_info =3D {
+	.write_raw =3D dac8163_write_raw,
+	.read_raw =3D dac8163_read_raw,
+};
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
+	st->regmap =3D devm_regmap_init_spi(spi, &info->regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
+				     "failed to initialize regmap\n");
+
+	// for now we keep the ldac pin asserted permanently so that the output
+	// is updated immediately after a write to the channels raw attribute
+	ldac_gpio =3D devm_gpiod_get_optional(&spi->dev, "ldac",
+					    GPIOD_OUT_HIGH);
+	if (IS_ERR(ldac_gpio))
+		return dev_err_probe(&spi->dev, PTR_ERR(ldac_gpio),
+				     "failed to get ldac gpio");
+
+	ret =3D devm_regulator_get_enable(&spi->dev, "avdd");
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to get avdd voltage\n");
+
+	if (device_property_present(&spi->dev, "vrefin-supply")) {
+		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev,
+							     "vrefin");
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "failed to get vrefin voltage\n");
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
+	ret =3D regmap_write(st->regmap, FIELD_PREP(COMMAND_MASK, CMD_SOFT_RST),
+			   FULL_RESET);
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to reset device\n");
+
+	ret =3D regmap_write(st->regmap, FIELD_PREP(COMMAND_MASK, CMD_LDAC_MODE)=
,
+			   FIELD_PREP(LDAC_CHANNEL_A_MASK, LDAC_INACTIVE) |
+			   FIELD_PREP(LDAC_CHANNEL_B_MASK, LDAC_INACTIVE));
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to set ldac mode\n");
+
+	ret =3D regmap_write(st->regmap, FIELD_PREP(COMMAND_MASK, CMD_REF),
+			   FIELD_PREP(VREF_MASK, internal_reference));
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to select reference voltage\n");
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
+		.driver_data =3D (kernel_ulong_t)&dac7562_chip_info,
+	},
+	{
+		.name =3D "dac7563",
+		.driver_data =3D (kernel_ulong_t)&dac7563_chip_info,
+	},
+	{
+		.name =3D "dac8162",
+		.driver_data =3D (kernel_ulong_t)&dac8162_chip_info,
+	},
+	{
+		.name =3D "dac8163",
+		.driver_data =3D (kernel_ulong_t)&dac8163_chip_info,
+	},
+	{
+		.name =3D "dac8562",
+		.driver_data =3D (kernel_ulong_t)&dac8562_chip_info,
+	},
+	{
+		.name =3D "dac8563",
+		.driver_data =3D (kernel_ulong_t)&dac8563_chip_info,
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

