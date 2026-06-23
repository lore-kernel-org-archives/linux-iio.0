Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C730E821;
	Tue, 23 Jun 2026 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230918; cv=none; b=D18v7NF1LUN3UuycUf3ujilwpRnkWj+DyHaLLY95LXhlfZ4JzFE6hi2VSN9y0QtBLAMmz1vrWy9YwcjbVHvSmBpe/Ne/t90kUGC02CLRNIITxnCIq3fprdG8+6FHUyk2tGONDr6JSfocJzeld+7jvhYroIUdviiz12dnWlGJU64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230918; c=relaxed/simple;
	bh=ThJiHZcdtOJyh0lvBz8i/rj8cg6/eXlCpJa8i0gqjjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sxaj1sSMn1A2cop8hAYsOh8Xpo9EFEstDZJGMWBRAagr08OxFGJ+bDJfAKAVDMUiQrkX5/96jhtMBlqniizyJOVecd8m3WUZWDRI4pYDjYEvrJhgYGwQXjlxuTNdJ1yD7N+PBIfviNZk+xW4oljmXO+bnHxLo700X/+/k+uU+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=Kp0GBSfx; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="Kp0GBSfx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1782230906; x=1782835706; i=lukas.metz@gmx.net;
	bh=81dEK9yIGz/gOXhixw7eGXDOHON/ICb7i5iNEvv/Ftw=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Kp0GBSfxhfnc1gRAjiJnAlbVEeoXCaSKt8EN8cSAaMav/TwWyu2zUYLHn0dT9rZN
	 DqppF0pSj0Vs2lsMhhTgD73tG7KlSOx9HUJbHjs/w3S17VlywGyeFdApuRRbN9M/h
	 opfu09Mo4ySbzc4iZJQBQe/Hi4UKn8Kvj4KlhtSBya1flKskpXjyOkSRDyqW79Mc8
	 ZVG+wLaegIrhnPLsemOZ1rgjABWLEAUkmzL2mjyLb185iPvJ7M/L1EAcI6UXi5JXs
	 RPy4Jvzz4P/AIRbosdtRoUBdXHK1Gdc2TcGxwpgzXVB5RcwfeQMeKdweRo/gC9jJ2
	 xDuNzfjBPt6RM/4zbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVNAr-1wli1d2HLT-00KiCX; Tue, 23
 Jun 2026 18:08:26 +0200
From: Lukas Metz <lukas.metz@gmx.net>
Date: Tue, 23 Jun 2026 18:07:27 +0200
Subject: [PATCH 1/2] iio: dac: dac8163: Add driver for DAC8163
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260623-dac8163-work-v1-1-5b508158faa0@gmx.net>
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
In-Reply-To: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Lukas Metz <lukas.metz@gmx.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782230905; l=11091;
 i=lukas.metz@gmx.net; s=20260616; h=from:subject:message-id;
 bh=MqK1vD8D2y7OjtwYY8pxtSo4kvZrbB0DgbeZI6s7ewU=;
 b=SEt3PiVF/32pkjwyIHvWKhD3ELpQ/ZH4QWdeR5M3nvQC0gzyFuOgpVu8jIOfvLSCITmo8F3jk
 +jyRiv+ewHjCU+pJyFU2NPtGPiRRrhp5kIgLoCn8miopYd/UyOJmh1V
X-Developer-Key: i=lukas.metz@gmx.net; a=ed25519;
 pk=ljkIqYPVyHd9CYN4/koqGKt7Mym5FTTB+ZzvvlfD4yM=
X-Provags-ID: V03:K1:INJ03xew0XDohGvV77DNRJ5X3F+1pZPfrngd861TEnUGR9/WXNX
 yF6eShhA8bJSbj8/wlIFDfgt/uq5ZWGVwx6xySHXs+6kv/pjRPKDBMjJs0tOLeNBRj0o1va
 YZ3D0LEDadYL26r2Uy1IBmecpaAN/ZodS8S3CbSkbFVcIMEdbrdoUmtknF/HTJ3ItHHdMhk
 HwqRw+0BgNYoLh6HCt1pg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2FyTuAkJFVI=;o0E6d/j71Lqlqme9oE7AdoSrI4Y
 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
 rtFso2RtYsHBppki3v0deu97CjI=

The DAC756x, DAC816x, and DAC856x devices are low-power, voltage-output,
dual-channel, 12-, 14-, and 16-bit digital-to-analog converters (DACs),
respectively. These devices include a 2.5-V, 4-ppm/=C2=B0C internal
reference, giving a full-scale output voltage range of 2.5 V or 5 V.

Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
=2D--
 MAINTAINERS                  |   6 +
 drivers/iio/dac/Kconfig      |  10 ++
 drivers/iio/dac/Makefile     |   1 +
 drivers/iio/dac/ti-dac8163.c | 339 ++++++++++++++++++++++++++++++++++++++=
+++++
 4 files changed, 356 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d238590a31f2..e82cc28e1bc3 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26394,6 +26394,12 @@ S:	Odd Fixes
 F:	drivers/clk/ti/
 F:	include/linux/clk/ti.h
=20
+TI DAC8163 DAC DRIVER
+M:	Lukas Metz <lukas.metz@gmx.net>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/dac/ti-dac8163.c
+
 TI DATA TRANSFORM AND HASHING ENGINE (DTHE) V2 CRYPTO DRIVER
 M:	T Pratham <t-pratham@ti.com>
 L:	linux-crypto@vger.kernel.org
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index db9f5c711b3d..6b6e5ee0732a 100644
=2D-- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -632,6 +632,16 @@ config TI_DAC7612
=20
 	  If compiled as a module, it will be called ti-dac7612.
=20
+config TI_DAC8163
+	tristate "Texas Instruments 12/14/16-bit 2-channel DAC driver"
+	depends on SPI_MASTER
+	help
+	  Driver for the Texas Instruments digital-to-analog converter
+	  family dacxx6x compatible with the variants DAC7562,
+	  DAC7563, DAC8162, DAC8163, DAC8562 and DAC8563.
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
index 000000000000..84a9dfb5347d
=2D-- /dev/null
+++ b/drivers/iio/dac/ti-dac8163.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DACxx6x IIO driver (SPI)
+ */
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/of.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/iio/iio.h>
+#include <linux/regulator/consumer.h>
+#include <linux/units.h>
+#include <linux/gpio/consumer.h>
+#include <linux/printk.h>
+#include <linux/bitfield.h>
+
+#define COMMAND_MASK GENMASK(6, 3)
+#define ADDRESS_MASK GENMASK(2, 0)
+
+#define COMMAND_SET(x, y) (FIELD_PREP(COMMAND_MASK, (x)) | \
+							FIELD_PREP(ADDRESS_MASK, (y)))
+
+#define CMD_WRITE_INPUT_REG	0x0
+#define CMD_UPDATE_DAC	0x1
+#define CMD_WRITE_UPDATE_ALL	0x2
+#define CMD_WRITE_UPDATE	0x3
+#define CMD_SET_PWR_MODE		0x4
+#define CMD_SOFT_RST			0x5
+
+#define CMD_LDAC_MODE		0x6
+#define LDAC_MODE_CHANNEL_A_MASK BIT(0)
+#define LDAC_MODE_CHANNEL_B_MASK BIT(1)
+
+#define CMD_SEL_REFERENCE	0x7
+#define VOLTAGE_REFERENCE_MASK BIT(0)
+
+enum dacxx6x_ldac_modes {
+	LDAC_MODE_ACTIVE =3D 0,
+	LDAC_MODE_INACTIVE =3D 1
+};
+
+enum dacxx6x_voltage_reference {
+	VOLTAGE_REFERENCE_EXTERNAL =3D 0,
+	VOLTAGE_REFERENCE_INTERNAL =3D 1
+};
+
+enum dacxx6x_supported_device_ids {
+	ID_DAC7562,
+	ID_DAC7563,
+	ID_DAC8162,
+	ID_DAC8163,
+	ID_DAC8562,
+	ID_DAC8563
+};
+
+struct dacxx6x_state {
+	struct spi_device *spi;
+
+	struct regulator *vref;
+	struct gpio_desc *loaddacs;
+
+	bool internal_ref;
+	int vref_uv;
+
+	unsigned int cached[2];
+
+	/*
+	 * Lock to protect the state of the device from potential concurrent
+	 * write accesses from userspace.
+	 */
+	struct mutex lock;
+};
+
+struct dacxx6x_chip_info {
+	const char *name;
+	const struct iio_chan_spec channels[2];
+};
+
+#define DACXX6X_CHAN(id, resolution)                                     =
   \
+	{                                                                   \
+		.type =3D IIO_VOLTAGE, .channel =3D (id), .output =3D 1,          \
+		.indexed =3D 1, .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),       \
+		.scan_type =3D { .realbits =3D (resolution),                    \
+			       .shift =3D 16 - (resolution) },                \
+	}
+
+static const struct dacxx6x_chip_info dacxx6x_chip_info_table[6] =3D {
+	[ID_DAC7562] =3D {
+		.name =3D "dac7562",
+		.channels =3D {
+			DACXX6X_CHAN(0, 12),
+			DACXX6X_CHAN(1, 12),
+		}
+	},
+	[ID_DAC7563] =3D {
+		.name =3D "dac7563",
+		.channels =3D {
+			DACXX6X_CHAN(0, 12),
+			DACXX6X_CHAN(1, 12),
+		}
+	},
+	[ID_DAC8162] =3D {
+		.name =3D "dac8162",
+		.channels =3D {
+			DACXX6X_CHAN(0, 14),
+			DACXX6X_CHAN(1, 14),
+		}
+	},
+	[ID_DAC8163] =3D {
+		.name =3D "dac8163",
+		.channels =3D {
+			DACXX6X_CHAN(0, 14),
+			DACXX6X_CHAN(1, 14),
+		}
+	},
+	[ID_DAC8562] =3D {
+		.name =3D "dac8562",
+		.channels =3D {
+			DACXX6X_CHAN(0, 16),
+			DACXX6X_CHAN(1, 16),
+		}
+	},
+	[ID_DAC8563] =3D {
+		.name =3D "dac8563",
+		.channels =3D {
+			DACXX6X_CHAN(0, 16),
+			DACXX6X_CHAN(1, 16),
+		}
+	},
+};
+
+static int dacxx6x_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct dacxx6x_state *st;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		st =3D iio_priv(indio_dev);
+		mutex_lock(&st->lock);
+		*val =3D st->cached[chan->channel];
+		mutex_unlock(&st->lock);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		st =3D iio_priv(indio_dev);
+		*val =3D st->vref_uv / MILLI; /* vref in mV */
+		*val2 =3D chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int dacxx6x_write_reg(struct dacxx6x_state *st, int reg, int addr,
+			     unsigned int val)
+{
+	u8 tx[3];
+
+	tx[0] =3D COMMAND_SET(reg, addr);
+	tx[1] =3D (val >> 8) & 0xff;
+	tx[2] =3D val & 0xff;
+
+	return spi_write(st->spi, tx, sizeof(tx));
+}
+
+static int dacxx6x_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct dacxx6x_state *st =3D iio_priv(indio_dev);
+	struct device *dev =3D &st->spi->dev;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		dev_dbg(dev, "%s: val=3D%d val2=3D%d\n", __func__, val, val2);
+		if (val2 !=3D 0)
+			return -EINVAL;
+
+		if (val < 0 || val >=3D BIT(chan->scan_type.realbits))
+			return -EINVAL;
+
+		mutex_lock(&st->lock);
+		int ret =3D dacxx6x_write_reg(st, CMD_WRITE_UPDATE, chan->channel,
+					    (unsigned int)val
+						    << chan->scan_type.shift);
+
+		if (!ret)
+			st->cached[chan->channel] =3D val;
+		mutex_unlock(&st->lock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info dacxx6x_iio_info =3D {
+	.write_raw =3D dacxx6x_write_raw,
+	.read_raw =3D dacxx6x_read_raw
+};
+
+static int dacxx6x_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct dacxx6x_state *st;
+	const struct dacxx6x_chip_info *info;
+	int ret;
+
+	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st =3D iio_priv(indio_dev);
+	st->spi =3D spi;
+	spi_set_drvdata(spi, indio_dev);
+
+	st->loaddacs =3D devm_gpiod_get_optional(&spi->dev, "ti,loaddacs",
+					       GPIOD_OUT_LOW);
+	if (IS_ERR(st->loaddacs))
+		return PTR_ERR(st->loaddacs);
+
+	st->internal_ref =3D
+		device_property_read_bool(&spi->dev, "ti,internal-ref");
+
+	if (!st->internal_ref) {
+		st->vref =3D devm_regulator_get(&spi->dev, "vref");
+		if (IS_ERR(st->vref))
+			return PTR_ERR(st->vref);
+
+		ret =3D regulator_enable(st->vref);
+		if (ret < 0)
+			return ret;
+	}
+
+	mutex_init(&st->lock);
+
+	if (st->internal_ref) {
+		st->vref_uv =3D 2500000; /* 2.5V internal reference */
+	} else {
+		st->vref_uv =3D regulator_get_voltage(st->vref);
+		if (st->vref_uv < 0) {
+			ret =3D st->vref_uv;
+			goto err;
+		}
+	}
+
+	gpiod_set_value(st->loaddacs, 0);
+
+	ret =3D dacxx6x_write_reg(st, CMD_LDAC_MODE, 0,
+				FIELD_PREP(LDAC_MODE_CHANNEL_A_MASK, LDAC_MODE_INACTIVE) |
+				FIELD_PREP(LDAC_MODE_CHANNEL_B_MASK, LDAC_MODE_INACTIVE));
+
+	if (ret < 0)
+		goto err;
+
+	ret =3D dacxx6x_write_reg(st, CMD_SEL_REFERENCE, 0,
+				FIELD_PREP(VOLTAGE_REFERENCE_MASK, st->internal_ref));
+
+	if (ret < 0)
+		goto err;
+
+	info =3D spi_get_device_match_data(spi);
+
+	indio_dev->name =3D info->name;
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->info =3D &dacxx6x_iio_info;
+	indio_dev->channels =3D info->channels;
+	indio_dev->num_channels =3D 2;
+
+	ret =3D iio_device_register(indio_dev);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	if (!st->internal_ref)
+		regulator_disable(st->vref);
+	mutex_destroy(&st->lock);
+	return ret;
+}
+
+static void dacxx6x_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
+	struct dacxx6x_state *st =3D iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	mutex_destroy(&st->lock);
+	if (!st->internal_ref)
+		regulator_disable(st->vref);
+}
+
+#define DACXX6X_COMPATIBLE(of_compatible, id)        \
+	{                                            \
+		.compatible =3D of_compatible,         \
+		.data =3D &dacxx6x_chip_info_table[id] \
+	}
+
+static const struct of_device_id dacxx6x_of_match[] =3D {
+	DACXX6X_COMPATIBLE("ti,dac7562", ID_DAC7562),
+	DACXX6X_COMPATIBLE("ti,dac7563", ID_DAC7563),
+	DACXX6X_COMPATIBLE("ti,dac8162", ID_DAC8162),
+	DACXX6X_COMPATIBLE("ti,dac8163", ID_DAC8163),
+	DACXX6X_COMPATIBLE("ti,dac8562", ID_DAC8562),
+	DACXX6X_COMPATIBLE("ti,dac8563", ID_DAC8563),
+	{}
+};
+MODULE_DEVICE_TABLE(of, dacxx6x_of_match);
+
+static const struct spi_device_id dacxx6x_id_table[] =3D {
+	{ "dac7562", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC7562] },
+	{ "dac7563", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC7563] },
+	{ "dac8162", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8162] },
+	{ "dac8163", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8163] },
+	{ "dac8562", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8562] },
+	{ "dac8563", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8563] },
+	{}
+};
+
+MODULE_DEVICE_TABLE(spi, dacxx6x_id_table);
+
+static struct spi_driver dacxx6x_driver =3D {
+	.driver =3D {
+		.name =3D "ti-dacxx6x",
+		.of_match_table =3D dacxx6x_of_match,
+	},
+	.probe =3D dacxx6x_probe,
+	.remove =3D dacxx6x_remove,
+	.id_table =3D dacxx6x_id_table,
+};
+
+module_spi_driver(dacxx6x_driver);
+
+MODULE_AUTHOR("Lukas Metz <lukas.metz@gmx.net>");
+MODULE_DESCRIPTION("Texas Instruments 12/14/16-bit 2-channel DAC driver")=
;
+MODULE_LICENSE("GPL");

=2D-=20
2.43.0

